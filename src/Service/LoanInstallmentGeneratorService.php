<?php

namespace App\Service;

use App\Entity\Loan;
use App\Entity\LoanInstallment;
use Doctrine\ORM\EntityManagerInterface;

class LoanInstallmentGeneratorService
{
    public function __construct(
        private EntityManagerInterface $entityManager
    ) {
    }

    public function generate(
        Loan $loan,
        \DateTimeImmutable $firstDueDate
    ): void {
        $amount = (float) $loan->getAmount();
        $months = $loan->getTermMonths();
        $rate = (float) $loan->getInterestRate() / 100;

        $principalMonthly = round($amount / $months, 2);
        $balance = $amount;

        for ($i = 1; $i <= $months; $i++) {
            $year = (int) $firstDueDate->format('Y');
            $month = (int) $firstDueDate->format('m');
            $day = (int) $firstDueDate->format('d');

            $currentMonth = $month + ($i - 1);
            $currentYear = $year + intdiv($currentMonth - 1, 12);
            $currentMonth = (($currentMonth - 1) % 12) + 1;

            $lastDayOfMonth = cal_days_in_month(
                CAL_GREGORIAN,
                $currentMonth,
                $currentYear
            );

            $dueDate = new \DateTime();
            $dueDate->setDate(
                $currentYear,
                $currentMonth,
                min($day, $lastDayOfMonth)
            );
            $dueDate->setTime(0, 0, 0);

            if ($i === $months) {
                $principal = $balance;
            } else {
                $principal = $principalMonthly;
            }

            $interest = round($balance * $rate, 2);
            $installmentAmount = round($principal + $interest, 2);
            $closingBalance = max(0, round($balance - $principal, 2));

            $installment = new LoanInstallment();
            $installment->setLoan($loan);
            $installment->setInstallmentNumber($i);
            $installment->setDueDate($dueDate);
            
            $installment->setOpeningBalance(
                number_format($balance, 2, '.', '')
            );
            $installment->setPrincipalAmount(
                number_format($principal, 2, '.', '')
            );
            $installment->setInterestAmount(
                number_format($interest, 2, '.', '')
            );
            $installment->setInstallmentAmount(
                number_format($installmentAmount, 2, '.', '')
            );
            $installment->setClosingBalance(
                number_format($closingBalance, 2, '.', '')
            );
            $installment->setLateFeeAmount('0.00');
            $installment->setStatus('PENDIENTE');

            $installment->setCreatedAt(
                new \DateTimeImmutable()
            );

            $installment->setUpdatedAt(
                new \DateTimeImmutable()
            );

            $this->entityManager->persist($installment);
            $balance = $closingBalance;
        }

        $this->entityManager->flush();
    }
}
