<?php

namespace App\Command;

use App\Repository\AccountRepository;
use App\Repository\SystemConfigRepository;
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
        private InterestCalculationService $interestCalculationService,
        private SystemConfigRepository $systemConfigRepository
    ) {
        parent::__construct();
    }

    protected function execute(
        InputInterface $input,
        OutputInterface $output
    ): int {

        $autoGeneration = $this->systemConfigRepository
            ->findOneBy([
                'configKey' => 'interest_auto_generation'
            ]);

        if (!$autoGeneration || $autoGeneration->getConfigValue() !== '1') {
            $output->writeln(
                'La generación automática de intereses está deshabilitada.'
            );

            return Command::SUCCESS;
        }

        $period = date('Y-m');

        $output->writeln(
            sprintf(
                'Procesando período financiero: %s',
                $period
            )
        );

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
