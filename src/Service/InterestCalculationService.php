<?php

namespace App\Service;

use App\Entity\Account;
use App\Entity\InterestAccrual;
use App\Repository\InterestAccrualRepository;
use App\Repository\InterestRateConfigRepository;
use App\Repository\TransactionRepository;
use App\Service\FinancialPeriodService;
use Doctrine\ORM\EntityManagerInterface;

class InterestCalculationService
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private InterestAccrualRepository $interestAccrualRepository,
        private InterestRateConfigRepository $interestRateConfigRepository,
        private TransactionRepository $transactionRepository,
        private FinancialPeriodService $financialPeriodService
    ) {
    }

    public function generateMonthlyInterest(
        Account $account,
        string $period
    ): ?InterestAccrual {

        $existing = $this->interestAccrualRepository
            ->findOneBy([
                'account' => $account,
                'period' => $period,
            ]);

        if ($existing) {
            return null;
        }

        $fechaCorte = $this->financialPeriodService
            ->getEligibilityDate();

        $capitalBase = $this->transactionRepository
            ->getCapitalElegibleHastaFecha(
                $account,
                $fechaCorte
            );

        if ($capitalBase <= 0) {
            return null;
        }

        $config = $this->interestRateConfigRepository
            ->findActiveRate(
                new \DateTimeImmutable()
            );

        $interestRate = $config
            ? (float) $config->getRate()
            : 1.00;

        $interestAmount = round(
            $capitalBase * ($interestRate / 100),
            2
        );

        $interest = new InterestAccrual();

        $interest->setAccount($account);
        $interest->setPeriod($period);
        $interest->setCapitalBase((string) $capitalBase);
        $interest->setInterestRate((string) $interestRate);
        $interest->setInterestAmount((string) $interestAmount);
        $interest->setCreatedAt(
            new \DateTimeImmutable()
        );

        $this->entityManager->persist($interest);
        $this->entityManager->flush();

        return $interest;
    }
}
