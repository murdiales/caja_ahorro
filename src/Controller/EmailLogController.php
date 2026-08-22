<?php

namespace App\Controller;

use App\Entity\EmailLog;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[IsGranted('ROLE_ADMIN')]
final class EmailLogController extends AbstractController
{
    #[Route('/gestion-documental/correos-enviados', name: 'app_email_log_index', methods: ['GET'])]
    #[Route('/email-log', name: 'app_email_log_legacy', methods: ['GET'])]
    public function index(EntityManagerInterface $em): Response
    {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        $logs = $em->getRepository(EmailLog::class)->findBy([], ['sentAt' => 'DESC']);

        return $this->render('email_log/index.html.twig', [
            'logs' => $logs,
        ]);
    }
}
