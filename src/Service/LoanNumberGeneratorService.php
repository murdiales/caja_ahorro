<?php

namespace App\Service;

use App\Repository\LoanRepository;

class LoanNumberGeneratorService
{
    public function __construct(
        private LoanRepository $loanRepository
    ) {
    }

    public function generate(): string
    {
        $year = date('Y');

        $count = $this->loanRepository->count([]);

        return sprintf(
            'PRE-%s-%06d',
            $year,
            $count + 1
        );
    }
}
