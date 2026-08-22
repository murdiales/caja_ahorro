<?php

namespace App\Controller;

use App\Entity\Account;
use App\Repository\TransactionRepository;
use App\Repository\InterestAccrualRepository;
use App\Repository\InterestRateConfigRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/account')]
final class AccountController extends AbstractController
{
    #[Route('/{id}', name: 'app_account_show', methods: ['GET'])]
    public function show(Account $account, TransactionRepository $transactionRepository, InterestAccrualRepository $interestAccrualRepository, InterestRateConfigRepository $interestRateConfigRepository): Response
    {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        if (
            !$this->isGranted('ROLE_ADMIN')
            && !$this->isGranted('ROLE_TESORERO')    
        ) {

            if (
                !$account->getUser()
                || $account->getUser()->getId() !== $this->getUser()->getId()
            ) {
                throw $this->createAccessDeniedException(
                    'No puede acceder a cuentas de otros socios.'
                );
            }
        }

        // Últimas 10 transacciones
        $recentTransactions = $transactionRepository->findBy(
            ['account' => $account],
            ['id' => 'DESC'],
            10
        );

$accumulatedInterest = 0;

foreach ($account->getInterestAccruals() as $interestAccrual) {

    $accumulatedInterest +=
        (float) $interestAccrual->getInterestAmount();
}

$availableBalance =
    (float) $account->getCurrentBalance()
    + $accumulatedInterest;

$interestHistory = $account
    ->getInterestAccruals()
    ->toArray();

$activeRate = $interestRateConfigRepository
    ->findActiveRate(
        new \DateTimeImmutable()
    );

$currentRate = $activeRate
    ? (float) $activeRate->getRate()
    : 0;

$today = new \DateTimeImmutable();

$nextCutoff = new \DateTimeImmutable(
    $today->format('Y-m') . '-28'
);

if ((int)$today->format('d') >= 28) {
    $nextCutoff = $nextCutoff->modify('+1 month');
}

        return $this->render('account/show.html.twig', [
            'account' => $account,
            'recentTransactions' => $recentTransactions,
            'accumulatedInterest' => $accumulatedInterest,
            'availableBalance'   => $availableBalance, 
            'interestHistory' => $interestHistory,
            'currentRate' => $currentRate,
            'nextCutoff' => $nextCutoff,

        ]);
    }

    #[Route('/{id}/transactions', name: 'app_account_transactions', methods: ['GET'])]
    public function transactions(Account $account, TransactionRepository $transactionRepository): Response
    {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        if (
            !$this->isGranted('ROLE_ADMIN')
            && !$this->isGranted('ROLE_TESORERO')
        ) {

            if (
                !$account->getUser()
                || $account->getUser()->getId() !== $this->getUser()->getId()
            ) {
                throw $this->createAccessDeniedException(
                    'No puede acceder a cuentas de otros socios.'
                );
            }
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
