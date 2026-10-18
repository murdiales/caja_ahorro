<?php

namespace App\Repository;

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

    /**
     * Obtiene los totales acumulados por tipo de transacción (Depósitos y Retiros).
     */
    public function getTotalesPorTipo(): array
    {
        $qb = $this->createQueryBuilder('t')
            ->select('t.type, SUM(t.amount) as total')
            ->groupBy('t.type');

        $result = $qb->getQuery()->getResult();

        $totales = [
            'depositos' => 0.0,
            'retiros'   => 0.0,
        ];

        foreach ($result as $row) {
            if ($row['type'] === 'DEPOSIT') {
                $totales['depositos'] = (float) $row['total'];
            } elseif ($row['type'] === 'WITHDRAWAL') {
                $totales['retiros'] = (float) $row['total'];
            }
        }

        return $totales;
    }

    /**
     * Obtiene el total general acumulado de depósitos.
     */
    public function getTotalDepositos(): float
    {
        $result = $this->createQueryBuilder('t')
            ->select('SUM(t.amount)')
            ->where('t.type = :type')
            ->setParameter('type', 'DEPOSIT')
            ->getQuery()
            ->getSingleScalarResult();

        return (float) ($result ?? 0.0);
    }

    /**
     * Obtiene el total de depósitos agrupados por mes para el gráfico de evolución.
     */
    public function getDepositosPorMes(): array
    {
        $resultado = $this->createQueryBuilder('t')
            ->select(
                'MONTH(t.transactionDate) AS mes',
                'SUM(t.amount) AS total'
            )
            ->where('t.type = :tipo')
            ->setParameter('tipo', 'DEPOSIT')
            ->groupBy('mes')
            ->orderBy('mes', 'ASC')
            ->getQuery()
            ->getResult();

        $meses = [
            'Ene' => 0, 'Feb' => 0, 'Mar' => 0, 'Abr' => 0,
            'May' => 0, 'Jun' => 0, 'Jul' => 0, 'Ago' => 0,
            'Sep' => 0, 'Oct' => 0, 'Nov' => 0, 'Dic' => 0,
        ];

        $nombresMeses = [
            1 => 'Ene', 2 => 'Feb', 3 => 'Mar', 4 => 'Abr',
            5 => 'May', 6 => 'Jun', 7 => 'Jul', 8 => 'Ago',
            9 => 'Sep', 10 => 'Oct', 11 => 'Nov', 12 => 'Dic'
        ];

        foreach ($resultado as $fila) {
            $indice = (int) $fila['mes'];
            if (isset($nombresMeses[$indice])) {
                $meses[$nombresMeses[$indice]] = (float) $fila['total'];
            }
        }

        return $meses;
    }
}
