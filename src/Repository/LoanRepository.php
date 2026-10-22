<?php

namespace App\Repository;

use App\Entity\Loan;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Loan>
 */
class LoanRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Loan::class);
    }

    public function getTotalLoanAmount(): float
    {
        $resultado = $this->createQueryBuilder('l')
            ->select('SUM(l.amount)')
            ->getQuery()
            ->getSingleScalarResult();

        return (float) ($resultado ?? 0);
    }

    public function getEstadoPrestamos(): array
    {
        $activos = $this->count([
            'status' => 'ACTIVO'
        ]);

        $cerrados = $this->count([
            'status' => 'PAGADO'
        ]);

        $vencidos = $this->count([
            'status' => 'VENCIDO'
        ]);

        return [
            'activos'  => $activos,
            'cerrados' => $cerrados,
            'vencidos' => $vencidos,
        ];
    }
}
