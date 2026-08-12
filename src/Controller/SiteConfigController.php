<?php

namespace App\Controller;

use App\Entity\SystemConfig;
use App\Repository\SystemConfigRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;

#[Route('/configuracion/sitio-web')]
class SiteConfigController extends AbstractController
{
    #[Route('/', name: 'app_site_config_index', methods: ['GET', 'POST'])]
    public function index(Request $request, SystemConfigRepository $repo, EntityManagerInterface $em, SluggerInterface $slugger): Response
    {
        if ($request->isMethod('POST')) {
            // 1. Guardar textos
            $textFields = ['site_title', 'hero_subtitle', 'about_us_text', 'contact_info'];
            foreach ($textFields as $field) {
                $val = $request->request->get($field);
                $config = $repo->findOneBy(['configKey' => $field]) ?? new SystemConfig();
                $config->setConfigKey($field)->setConfigValue($val);
                $em->persist($config);
            }

            // 2. Procesar subida de imágenes
            $imageFiles = ['hero_banner' => $request->files->get('hero_banner'), 'logo' => $request->files->get('logo')];
            foreach ($imageFiles as $key => $file) {
                if ($file) {
                    $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
                    $newFilename = $slugger->slug($originalFilename).'-'.uniqid().'.'.$file->guessExtension();

                    try {
                        $file->move($this->getParameter('kernel.project_dir').'/public/uploads/site', $newFilename);
                        $config = $repo->findOneBy(['configKey' => $key]) ?? new SystemConfig();
                        $config->setConfigKey($key)->setConfigValue($newFilename);
                        $em->persist($config);
                    } catch (FileException $e) {
                        $this->addFlash('danger', 'Error al subir la imagen: '.$key);
                    }
                }
            }

            $em->flush();
            $this->addFlash('success', 'La configuración del sitio web ha sido actualizada.');
            return $this->redirectToRoute('app_site_config_index');
        }

        // Cargar valores existentes
        $configs = [];
        foreach ($repo->findAll() as $c) {
            $configs[$c->getConfigKey()] = $c->getConfigValue();
        }

        return $this->render('site_config/index.html.twig', [
            'configs' => $configs,
        ]);
    }
}