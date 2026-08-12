<?php

namespace App\Command;

use App\Repository\UserRepository;
use App\Service\InterestCalculatorService;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

#[AsCommand(
    name: 'app:process-monthly-interest',
    description: 'Calcula y registra los intereses acumulados del mes para todos los socios.',
)]
class ProcessMonthlyInterestCommand extends Command
{
    public function __construct(
        private UserRepository $userRepository,
        private InterestCalculatorService $interestCalculator
    ) {
        parent::__construct();
    }

    protected function configure(): void
    {
        $this
            ->addOption('year', 'y', InputOption::VALUE_OPTIONAL, 'Año del proceso', (int)date('Y'))
            ->addOption('month', 'm', InputOption::VALUE_OPTIONAL, 'Mes del proceso', (int)date('m'));
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        $year = (int) $input->getOption('year');
        $month = (int) $input->getOption('month');

        $io->title("Procesando Cierre de Intereses: $month/$year");

        $users = $this->userRepository->findAll();
        $processed = 0;

        foreach ($users as $user) {
            $this->interestCalculator->processMonthlyInterestForUser($user, $year, $month);
            $processed++;
        }

        $io->success("Se procesó correctamente el cálculo para $processed socio(s).");

        return Command::SUCCESS;
    }
}