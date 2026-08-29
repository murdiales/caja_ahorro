<?php

namespace App\Controller;

use App\Entity\Loan;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class LoanRejectController extends AbstractController
{
    #[Route(
        '/loans/{id}/reject',
        name: 'loan_reject',
        requirements: ['id' => '\d+'],
        methods: ['POST']
    )]
    public function reject(
        Loan $loan,
        Request $request,
        EntityManagerInterface $entityManager
    ): Response {

        if ($loan->getStatus() !== 'SOLICITADO') {

            $this->addFlash(
                'warning',
                'Solo se pueden rechazar préstamos en estado SOLICITADO.'
            );

            return $this->redirectToRoute(
                'loan_detail',
                [
                    'id' => $loan->getId()
                ]
            );
        }

        $loan->setStatus('RECHAZADO');

        $loan->setRejectionDate(
            new \DateTimeImmutable()
        );

        $loan->setRejectedBy(
            'ADMINISTRADOR'
        );

        $loan->setRejectionReason(
            'Solicitud rechazada por administración.'
        );

        $loan->setUpdatedAt(
            new \DateTimeImmutable()
        );

        $entityManager->flush();

        $this->addFlash(
            'success',
            sprintf(
                'Préstamo %s rechazado correctamente.',
                $loan->getNumber()
            )
        );

        return $this->redirectToRoute(
            'loan_detail',
            [
                'id' => $loan->getId()
            ]
        );
    }
}
