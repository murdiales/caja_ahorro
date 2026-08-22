<?php

namespace App\Controller;

use App\Entity\SystemConfig;
use App\Repository\SystemConfigRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class FinancialConfigController extends AbstractController
{
    #[Route(
        '/gestion-financiera/configuracion',
        name: 'app_financial_config'
    )]
    public function index(
        SystemConfigRepository $repository
    ): Response {

        $configs = [];

        foreach ($repository->findAll() as $config) {
            $configs[
                $config->getConfigKey()
            ] = $config->getConfigValue();
        }

        return $this->render(
            'financial_config/index.html.twig',
            [
                'configs' => $configs
            ]
        );
    }

    #[Route(
        '/gestion-financiera/configuracion/editar',
        name: 'app_financial_config_edit'
    )]
    public function edit(
        Request $request,
        SystemConfigRepository $repository,
        EntityManagerInterface $em
    ): Response {

        if ($request->isMethod('POST')) {

            $configsToSave = [
                'interest_cutoff_day' =>
                    $request->request->get('interest_cutoff_day'),

                'interest_eligibility_rule' =>
                    $request->request->get('interest_eligibility_rule'),

                'interest_auto_generation' =>
                    $request->request->get('interest_auto_generation')
            ];

            foreach ($configsToSave as $key => $value) {

                $config = $repository->findOneBy([
                    'configKey' => $key
                ]);

                if ($config) {
                    $config->setConfigValue($value);
                    $em->persist($config);
                }
            }

            $em->flush();

            $this->addFlash(
                'success',
                'Configuración financiera actualizada correctamente.'
            );

            return $this->redirectToRoute(
                'app_financial_config'
            );
        }

        $configs = [];

        foreach ($repository->findAll() as $config) {
            $configs[
                $config->getConfigKey()
            ] = $config->getConfigValue();
        }

        return $this->render(
            'financial_config/edit.html.twig',
            [
                'configs' => $configs
            ]
        );
    }
}
