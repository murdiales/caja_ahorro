<?php

namespace App\Service;

use App\Entity\Account;
use App\Entity\Loan;
use Doctrine\ORM\EntityManagerInterface;

class LoanRequestService
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private LoanNumberGeneratorService $numberGenerator,
        private LoanAmortizationService $amortizationService,
        private LoanInstallmentGeneratorService $installmentGenerator
    ) {
    }

    public function create(
        Account $account,
        float $amount,
        int $termMonths,
        float $interestRate,
        \DateTimeImmutable $firstDueDate
    ): Loan {

        $simulation = $this->amortizationService->generateSchedule(
            $amount,
            $termMonths,
            $interestRate
        );

        $loan = new Loan();

        $loan->setAccount($account);

        $loan->setNumber(
            $this->numberGenerator->generate()
        );

        $loan->setAmount(
            number_format($amount, 2, '.', '')
        );

        $loan->setTermMonths($termMonths);

        $loan->setInterestRate(
            number_format($interestRate, 2, '.', '')
        );

        $loan->setTotalInterest(
            number_format(
                $simulation['totalInterest'],
                2,
                '.',
                ''
            )
        );

        $loan->setTotalAmount(
            number_format(
                $simulation['totalPayment'],
                2,
                '.',
                ''
            )
        );

        $loan->setStatus('SOLICITADO');

        $loan->setRequestDate(
            new \DateTimeImmutable()
        );

        $loan->setCreatedAt(
            new \DateTimeImmutable()
        );

        $loan->setUpdatedAt(
            new \DateTimeImmutable()
        );

        $this->entityManager->persist($loan);
        $this->entityManager->flush();

        $this->installmentGenerator->generate(
            $loan,
            $firstDueDate
        );

        return $loan;
    }
}
