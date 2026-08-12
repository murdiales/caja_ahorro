<?php

namespace App\Controller;

use App\Entity\Document;
use App\Repository\DocumentRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;

/**
 * @Route("/gestion-documental")
 */
#[Route('/gestion-documental')]
class DocumentController extends AbstractController
{
    /**
     * @Route("/", name="app_document_index")
     */
    #[Route('/', name: 'app_document_index')]
    public function index(Request $request, DocumentRepository $repo): Response
    {
        $category = $request->query->get('category');
        $criteria = $category ? ['category' => $category] : [];

        return $this->render('document/index.html.twig', [
            'documents' => $repo->findBy($criteria, ['uploadedAt' => 'DESC']),
            'currentCategory' => $category,
        ]);
    }

    /**
     * @Route("/subir", name="app_document_upload", methods={"POST"})
     */
    #[Route('/subir', name: 'app_document_upload', methods: ['POST'])]
    public function upload(Request $request, EntityManagerInterface $em, SluggerInterface $slugger): Response
    {
        $file = $request->files->get('file');
        $title = $request->request->get('title');
        $category = $request->request->get('category');

        if ($file && $title && $category) {
            $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
            $safeFilename = $slugger->slug($originalFilename);
            $newFilename = $safeFilename.'-'.uniqid().'.'.$file->guessExtension();

            try {
                $file->move(
                    $this->getParameter('kernel.project_dir').'/public/uploads/documents',
                    $newFilename
                );

                $doc = new Document();
                $doc->setTitle($title);
                $doc->setCategory($category);
                $doc->setFilePath($newFilename);
                $doc->setUploadedBy($this->getUser());

                $em->persist($doc);
                $em->flush();

                $this->addFlash('success', 'Documento subido correctamente.');
            } catch (FileException $e) {
                $this->addFlash('danger', 'Error al subir el archivo.');
            }
        }

        return $this->redirectToRoute('app_document_index');
    }
}