<?php

namespace App\Command;

use App\Entity\InterestGenerationLog;
use App\Repository\AccountRepository;
use App\Service\FinancialPeriodService;
use App\Service\InterestCalculationService;
use Doctrine\ORM\EntityManagerInterface;
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
        private FinancialPeriodService $financialPeriodService,
        private EntityManagerInterface $entityManager
    ) {
        parent::__construct();
    }

    protected function execute(
        InputInterface $input,
        OutputInterface $output
    ): int {

        $period = $this->financialPeriodService
            ->getCurrentPeriod();

        $cutoffDay = $this->financialPeriodService
            ->getCutoffDay();

        $currentDay = (int) date('d');

        if ($currentDay < $cutoffDay) {

            $output->writeln(
                sprintf(
                    'Aún no se alcanza el día de corte (%d).',
                    $cutoffDay
                )
            );

            $log = new InterestGenerationLog();
            $log->setPeriod($period);
            $log->setExecutionDate(
                new \DateTimeImmutable()
            );
            $log->setAccountsProcessed(0);
            $log->setInterestsGenerated(0);
            $log->setStatus('SKIPPED');
            $log->setNotes(
                sprintf(
                    'Proceso omitido. Día actual: %d. Día de corte: %d.',
                    $currentDay,
                    $cutoffDay
                )
            );

            $this->entityManager->persist($log);
            $this->entityManager->flush();

            return Command::SUCCESS;
        }

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

        $log = new InterestGenerationLog();
        $log->setPeriod($period);
        $log->setExecutionDate(
            new \DateTimeImmutable()
        );
        $log->setAccountsProcessed(
            count($accounts)
        );
        $log->setInterestsGenerated(
            $generated
        );
        $log->setStatus('COMPLETED');
        $log->setNotes(
            sprintf(
                'Proceso ejecutado correctamente. %d intereses generados.',
                $generated
            )
        );

        $this->entityManager->persist($log);
        $this->entityManager->flush();

        return Command::SUCCESS;
    }
}
