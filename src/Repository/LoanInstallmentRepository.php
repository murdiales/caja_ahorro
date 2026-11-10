<?php

namespace App\Repository;

use App\Entity\LoanInstallment;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<LoanInstallment>
 */
class LoanInstallmentRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, LoanInstallment::class);
    }

    /**
     * Devuelve el total numérico de cuotas vencidas y no pagadas a la fecha actual.
     */
    public function getCuotasVencidas(): int
    {
        return (int) $this->createQueryBuilder('i')
            ->select('COUNT(i.id)')
            ->where('i.dueDate < :hoy')
            ->andWhere('i.paidAt IS NULL')
            ->setParameter('hoy', new \DateTimeImmutable())
            ->getQuery()
            ->getSingleScalarResult();
    }

    /**
     * Devuelve el conteo total de todas las cuotas registradas en la base de datos.
     */
    public function getTotalCuotas(): int
    {
        return $this->count([]);
    }

    public function findNextPendingInstallment(int $loanId): ?LoanInstallment
    {
        return $this->createQueryBuilder("i")
            ->andWhere("i.loan = :loan")
            ->andWhere("i.status IN (:statuses)")
            ->setParameter("loan", $loanId)
            ->setParameter("statuses", ["PENDIENTE", "PARCIAL"])
            ->orderBy("i.installmentNumber", "ASC")
            ->setMaxResults(1)
            ->getQuery()
            ->getOneOrNullResult();
    }

    }
