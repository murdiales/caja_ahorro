<?php

namespace App\Controller;

use App\Entity\Account;
use App\Repository\TransactionRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/account')]
final class AccountController extends AbstractController
{
    #[Route('/{id}', name: 'app_account_show', methods: ['GET'])]
    public function show(Account $account, TransactionRepository $transactionRepository): Response
    {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        // Últimas 10 transacciones
        $recentTransactions = $transactionRepository->findBy(
            ['account' => $account],
            ['id' => 'DESC'],
            10
        );

        return $this->render('account/show.html.twig', [
            'account' => $account,
            'recentTransactions' => $recentTransactions,
        ]);
    }

    #[Route('/{id}/transactions', name: 'app_account_transactions', methods: ['GET'])]
    public function transactions(Account $account, TransactionRepository $transactionRepository): Response
    {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        // Filtro de los últimos 6 meses
        $sixMonthsAgo = new \DateTime('-6 months');

        $transactions = $transactionRepository->createQueryBuilder('t')
            ->where('t.account = :account')
            ->andWhere('t.createdAt >= :sixMonthsAgo')
            ->setParameter('account', $account)
            ->setParameter('sixMonthsAgo', $sixMonthsAgo)
            ->orderBy('t.createdAt', 'DESC')
            ->getQuery()
            ->getResult();

        return $this->render('account/transactions.html.twig', [
            'account' => $account,
            'transactions' => $transactions,
            'sixMonthsAgo' => $sixMonthsAgo,
        ]);
    }
}