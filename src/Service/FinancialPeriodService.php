<?php

namespace App\Service;

use App\Repository\SystemConfigRepository;

class FinancialPeriodService
{
    public function __construct(
        private SystemConfigRepository $systemConfigRepository
    ) {
    }

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

    public function getCutoffDay(): int
    {
        $config = $this->systemConfigRepository
            ->findOneBy([
                'configKey' => 'interest_cutoff_day'
            ]);

        return $config
            ? (int) $config->getConfigValue()
            : 28;
    }

    public function getCutoffDate(): \DateTimeImmutable
    {
        $year = date('Y');
        $month = date('m');
        $day = $this->getCutoffDay();

        return new \DateTimeImmutable(
            sprintf(
                '%s-%s-%02d',
                $year,
                $month,
                $day
            )
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
