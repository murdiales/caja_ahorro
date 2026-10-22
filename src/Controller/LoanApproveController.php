<?php

namespace App\Controller;

use App\Entity\Loan;
use App\Entity\Transaction;
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

        // 1. Validar que el préstamo tenga cuenta asociada
        if (!$loan->getAccount()) {
            $this->addFlash(
                'danger',
                'El préstamo no tiene una cuenta asociada.'
            );

            return $this->redirectToRoute(
                'loan_detail',
                [
                    'id' => $loan->getId()
                ]
            );
        }

        // Obtener cuenta asociada
        $account = $loan->getAccount();

        // Actualizar saldo de la cuenta
        $currentBalance = (float) $account->getCurrentBalance();
        $loanAmount = (float) $loan->getAmount();
        $newBalance = $currentBalance + $loanAmount;
        
        $account->setCurrentBalance(
            number_format($newBalance, 2, '.', '')
        );

        // Registrar transacción de desembolso como DEPOSIT
        $transaction = new Transaction();
        $transaction->setAccount($account);
        $transaction->setType('DEPOSIT');
        $transaction->setAmount(
            number_format($loanAmount, 2, '.', '')
        );
        $transaction->setDescription(
            sprintf(
                'DESEMBOLSO PRESTAMO %s',
                $loan->getNumber()
            )
        );

        $now = new \DateTime();
        $transaction->setCreatedAt($now);
        $transaction->setTransactionDate($now);
        $transaction->setEffectiveDate($now);

        $entityManager->persist($transaction);

        // Actualizar estado y datos del préstamo
        $loan->setStatus('APROBADO');

        $loan->setApprovalDate(
            new \DateTimeImmutable()
        );

        // 2. Obtener el usuario real que aprueba
        $loan->setApprovedBy(
            $this->getUser()?->getUserIdentifier() ?? 'SISTEMA'
        );

        if (method_exists($loan, 'setUpdatedAt')) {
            $loan->setUpdatedAt(
                new \DateTimeImmutable()
            );
        }

        $entityManager->flush();

        $this->addFlash(
            'success',
            sprintf(
                'Préstamo %s aprobado y desembolsado correctamente.',
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
