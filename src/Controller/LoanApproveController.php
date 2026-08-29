<?php

namespace App\Controller;

use App\Entity\Loan;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class LoanApproveController extends AbstractController
{
    #[Route(
        '/loans/{id}/approve',
        name: 'loan_approve',
        requirements: ['id' => '\d+'],
        methods: ['POST']
    )]
    public function approve(
        Loan $loan,
        EntityManagerInterface $entityManager
    ): Response {

        if ($loan->getStatus() !== 'SOLICITADO') {

            $this->addFlash(
                'warning',
                'Solo se pueden aprobar préstamos en estado SOLICITADO.'
            );

            return $this->redirectToRoute(
                'loan_detail',
                [
                    'id' => $loan->getId()
                ]
            );
        }

        $loan->setStatus('APROBADO');

        $loan->setApprovalDate(
            new \DateTimeImmutable()
        );

        $loan->setApprovedBy(
            'ADMINISTRADOR'
        );

        $loan->setUpdatedAt(
            new \DateTimeImmutable()
        );

        $entityManager->flush();

        $this->addFlash(
            'success',
            sprintf(
                'Préstamo %s aprobado correctamente.',
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
