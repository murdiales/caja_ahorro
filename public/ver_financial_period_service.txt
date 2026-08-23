<?php

namespace App\Service;

class FinancialPeriodService
{
    public function getCurrentPeriod(): string
    {
        return date('Y-m');
    }

    public function getEligiblePeriod(): string
    {
        return date(
            'Y-m',
            strtotime('first day of last month')
        );
    }

    public function getCutoffDate(): \DateTimeImmutable
    {
        $year = date('Y');
        $month = date('m');

        return new \DateTimeImmutable(
            sprintf('%s-%s-28', $year, $month)
        );
    }

    public function getEligibilityDate(): \DateTimeImmutable
    {
        return new \DateTimeImmutable(
            date(
                'Y-m-t',
                strtotime('last month')
            )
        );
    }
}
