<?php

namespace App\Repository;

use App\Entity\Account;
use App\Entity\Transaction;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Transaction>
 */
class TransactionRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Transaction::class);
    }

    public function getCapitalElegibleHastaFecha(
        Account $account,
        \DateTimeInterface $fechaCorte
    ): float {
        $resultado = $this->createQueryBuilder('t')
            ->select('SUM(
                CASE
                    WHEN t.type = :deposito THEN t.amount
                    WHEN t.type = :retiro THEN -t.amount
                    ELSE 0
                END
            ) AS capital')
            ->andWhere('t.account = :account')
            ->andWhere('t.transactionDate <= :fecha')
            ->setParameter('account', $account)
            ->setParameter('fecha', $fechaCorte)
            ->setParameter('deposito', 'DEPOSIT')
            ->setParameter('retiro', 'WITHDRAWAL')
            ->getQuery()
            ->getSingleScalarResult();

        return (float) ($resultado ?? 0);
    }
}
