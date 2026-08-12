<?php

namespace App\Command;

use App\Entity\Transaction;
use App\Repository\AccountRepository;
use App\Repository\UserRepository;
use App\Service\InterestCalculatorService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

#[AsCommand(
    name: 'app:seed-deposits',
    description: 'Fuerza el registro de $30 de aporte de agosto a diciembre y recalcula.',
)]
class SeedDepositsCommand extends Command
{
    public function __construct(
        private UserRepository $userRepo,
        private AccountRepository $accountRepo,
        private EntityManagerInterface $em,
        private InterestCalculatorService $calculator
    ) {
        parent::__construct();
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        $user = $this->userRepo->find(1);
        $account = $this->accountRepo->findOneBy(['user' => $user]);

        if (!$account) {
            $io->error('No se encontró la cuenta del usuario 1.');
            return Command::FAILURE;
        }

        for ($m = 8; $m <= 12; $m++) {
            $tx = new Transaction();
            $tx->setAmount('30.00');

            // Aseguramos asignación de tipo de transacción según tu entidad
            if (method_exists($tx, 'setType')) {
                $tx->setType('DEPOSIT');
            }

            if (method_exists($tx, 'setAccount')) {
                $tx->setAccount($account);
            }

            if (method_exists($tx, 'setUser')) {
                $tx->setUser($user);
            }

            // Fecha fijada a mediados del mes correspondiente
            $date = new \DateTime(sprintf('2026-%02d-15 12:00:00', $m));
            if (method_exists($tx, 'setCreatedAt')) {
                $tx->setCreatedAt($date);
            }

            $this->em->persist($tx);
        }

        $this->em->flush();
        $io->info('Depósitos de $30 insertados correctamente en la base de datos.');

        // Recalcular meses de 8 a 12
        for ($m = 8; $m <= 12; $m++) {
            $this->calculator->processMonthlyInterestForUser($user, 2026, $m);
        }

        $io->success('Cierres mensuales recalculados con éxito.');
        return Command::SUCCESS;
    }
}