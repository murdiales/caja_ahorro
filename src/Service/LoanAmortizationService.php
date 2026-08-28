<?php

namespace App\Service;

class LoanAmortizationService
{
    public function generateSchedule(
        float $amount,
        int $months,
        float $monthlyRate
    ): array {
        $capitalMonthly = round($amount / $months, 2);

        $balance = $amount;

        $totalInterest = 0;
        $totalPayment = 0;

        $installments = [];

        for ($i = 1; $i <= $months; $i++) {

            $interest = round(
                $balance * ($monthlyRate / 100),
                2
            );

            $payment = round(
                $capitalMonthly + $interest,
                2
            );

            $closingBalance = round(
                $balance - $capitalMonthly,
                2
            );

            if ($closingBalance < 0) {
                $closingBalance = 0;
            }

            $installments[] = [
                'installment' => $i,
                'opening_balance' => $balance,
                'principal' => $capitalMonthly,
                'interest' => $interest,
                'payment' => $payment,
                'closing_balance' => $closingBalance,
            ];

            $totalInterest += $interest;
            $totalPayment += $payment;

            $balance = $closingBalance;
        }

        return [
            'capitalMonthly' => $capitalMonthly,
            'totalInterest' => round($totalInterest, 2),
            'totalPayment' => round($totalPayment, 2),
            'installments' => $installments,
        ];
    }
}
