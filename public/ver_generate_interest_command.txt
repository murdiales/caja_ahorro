<?php

namespace App\Command;

use App\Repository\AccountRepository;
use App\Service\InterestCalculationService;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

#[AsCommand(
    name: 'app:generate-interest',
    description: 'Genera intereses mensuales para todas las cuentas',
)]
class GenerateInterestCommand extends Command
{
    public function __construct(
        private AccountRepository $accountRepository,
        private InterestCalculationService $interestCalculationService
    ) {
        parent::__construct();
    }

    protected function execute(
        InputInterface $input,
        OutputInterface $output
    ): int {

        $period = date('Y-m');

        $accounts = $this->accountRepository->findAll();

        $generated = 0;

        foreach ($accounts as $account) {

            $interest =
                $this->interestCalculationService
                    ->generateMonthlyInterest(
                        $account,
                        $period
                    );

            if ($interest) {
                $generated++;
            }
        }

        $output->writeln(
            sprintf(
                '%d interés(es) generado(s)',
                $generated
            )
        );

        return Command::SUCCESS;
    }
}
