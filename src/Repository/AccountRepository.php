<?php

namespace App\Repository;

use App\Entity\Account;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Account>
 */
class AccountRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Account::class);
    }

    /**
     * Obtiene la suma total de los saldos acumulados en todas las cuentas activas.
     */
    public function getTotalBalances(): float
    {
        $resultado = $this->createQueryBuilder('a')
            ->select('SUM(a.currentBalance)')
            ->getQuery()
            ->getSingleScalarResult();

        return (float) ($resultado ?? 0);
    }
}
