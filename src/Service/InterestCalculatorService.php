<?php

namespace App\Service;

use App\Entity\MonthlyBalanceLog;
use App\Entity\User;
use App\Repository\InterestRateConfigRepository;
use App\Repository\MonthlyBalanceLogRepository;
use App\Repository\TransactionRepository;
use Doctrine\ORM\EntityManagerInterface;

class InterestCalculatorService
{
    public function __construct(
        private EntityManagerInterface $em,
        private InterestRateConfigRepository $rateConfigRepo,
        private MonthlyBalanceLogRepository $balanceLogRepo,
        private TransactionRepository $transactionRepo
    ) {}

    public function processMonthlyInterestForUser(User $user, int $year, int $month): MonthlyBalanceLog
    {
        // 1. Obtener la tasa de interés vigente
        $targetDate = new \DateTimeImmutable(sprintf('%d-%02d-01', $year, $month));
        $activeRateConfig = $this->rateConfigRepo->createQueryBuilder('r')
            ->where('r.startDate <= :targetDate')
            ->andWhere('r.endDate IS NULL OR r.endDate >= :targetDate')
            ->setParameter('targetDate', $targetDate)
            ->orderBy('r.startDate', 'DESC')
            ->setMaxResults(1)
            ->getQuery()
            ->getOneOrNullResult();

        $appliedRate = $activeRateConfig ? (float)$activeRateConfig->getRate() : 1.00;

        // 2. Obtener el registro del mes anterior
        $prevMonth = $month === 1 ? 12 : $month - 1;
        $prevYear = $month === 1 ? $year - 1 : $year;

        $previousLog = $this->balanceLogRepo->findOneBy([
            'user' => $user,
            'year' => $prevYear,
            'month' => $prevMonth
        ]);

        // Capital Base = Solo la suma de aportes acumulados del mes anterior
        $baseCapital = $previousLog ? (float)$previousLog->getTotalAccumulated() : 0.00;

        // 3. El interés se calcula SOLO sobre los aportes (Capital Base sin intereses previos)
        $earnedInterest = round($baseCapital * ($appliedRate / 100), 2);

        // 4. Obtener nuevos aportes del mes actual
        $startOfMonth = new \DateTime(sprintf('%d-%02d-01 00:00:00', $year, $month));
        $endOfMonth = (clone $startOfMonth)->modify('last day of this month 23:59:59');

        $qb = $this->transactionRepo->createQueryBuilder('t')
            ->select('SUM(t.amount)')
            ->where('t.type = :type')
            ->andWhere('t.createdAt BETWEEN :start AND :end')
            ->setParameter('type', 'DEPOSIT')
            ->setParameter('start', $startOfMonth)
            ->setParameter('end', $endOfMonth);

        if (property_exists(\App\Entity\Transaction::class, 'account')) {
            $qb->join('t.account', 'a')
               ->andWhere('a.user = :user')
               ->setParameter('user', $user);
        } else {
            $qb->andWhere('t.user = :user')
               ->setParameter('user', $user);
        }

        $newDeposits = (float)($qb->getQuery()->getSingleScalarResult() ?? 0.00);

        // 5. Total Acumulado en el mes = Capital Base de Aportes + Nuevos Aportes (SIN SUMAR INTERESES)
        $totalAccumulated = $baseCapital + $newDeposits;

        // 6. Guardar / Actualizar registro
        $log = $this->balanceLogRepo->findOneBy([
            'user' => $user,
            'year' => $year,
            'month' => $month
        ]) ?? new MonthlyBalanceLog();

        $log->setUser($user)
            ->setYear($year)
            ->setMonth($month)
            ->setBaseCapital((string)$baseCapital)
            ->setNewDeposits((string)$newDeposits)
            ->setAppliedRate((string)$appliedRate)
            ->setEarnedInterest((string)$earnedInterest)
            ->setTotalAccumulated((string)$totalAccumulated); // Solo guarda aportes acumulados

        $this->em->persist($log);
        $this->em->flush();

        return $log;
    }
}