<?php

namespace App\Command;

use App\Service\LoanAmortizationService;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

#[AsCommand(
    name: 'app:test-loan',
    description: 'Prueba el cálculo de amortización de préstamos',
)]
class TestLoanCommand extends Command
{
    private LoanAmortizationService $loanAmortizationService;

    public function __construct(
        LoanAmortizationService $loanAmortizationService
    ) {
        parent::__construct();
        $this->loanAmortizationService = $loanAmortizationService;
    }

    protected function configure(): void
    {
        $this
            ->setDescription('Prueba el cálculo de amortización de préstamos');
    }

    protected function execute(
        InputInterface $input,
        OutputInterface $output
    ): int {
        $result = $this->loanAmortizationService
            ->generateSchedule(
                1000,
                10,
                1
            );

        $output->writeln('');
        $output->writeln('=== SIMULACIÓN DE PRÉSTAMO ===');
        $output->writeln('');

        $output->writeln(
            'Capital mensual: $' . $result['capitalMonthly']
        );

        $output->writeln(
            'Interés total: $' . $result['totalInterest']
        );

        $output->writeln(
            'Total a pagar: $' . $result['totalPayment']
        );

        $output->writeln('');
        $output->writeln('=== CUOTAS ===');

        foreach ($result['installments'] as $quota) {
            $output->writeln(
                sprintf(
                    'Cuota %d | Capital: %.2f | Interés: %.2f | Pago: %.2f',
                    $quota['installment'],
                    $quota['principal'],
                    $quota['interest'],
                    $quota['payment']
                )
            );
        }

        return Command::SUCCESS;
    }
}
