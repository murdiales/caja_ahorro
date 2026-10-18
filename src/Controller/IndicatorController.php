<?php

namespace App\Controller;

use App\Repository\UserRepository;
use App\Repository\AccountRepository;
use App\Repository\LoanRepository;
use App\Repository\TransactionRepository;
use App\Repository\LoanInstallmentRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class IndicatorController extends AbstractController
{
    #[Route('/indicator', name: 'app_indicator')]
    public function index(
        UserRepository $userRepository,
        AccountRepository $accountRepository,
        LoanRepository $loanRepository,
        TransactionRepository $transactionRepository,
        LoanInstallmentRepository $loanInstallmentRepository
    ): Response {
        $movimientos = $transactionRepository->getTotalesPorTipo();
        $estadoPrestamos = $loanRepository->getEstadoPrestamos();
        // $depositosMensuales = $transactionRepository->getDepositosPorMes(); // COMENTADO TEMPORALMENTE

        // Métricas Financieras Básicas
        $totalSocios    = $userRepository->count([]);
        $totalAhorros   = $accountRepository->getTotalBalances();
        $totalDepositos = $transactionRepository->getTotalDepositos();
        $montoPrestado  = $loanRepository->getTotalLoanAmount();

        // Cálculo de Liquidez ($)
        $liquidez = $totalAhorros - $montoPrestado;

        // Cálculo de Morosidad (%)
        $cuotasVencidas = $loanInstallmentRepository->getCuotasVencidas();
        $totalCuotas    = $loanInstallmentRepository->getTotalCuotas();

        $morosidad = $totalCuotas > 0
            ? ($cuotasVencidas * 100) / $totalCuotas
            : 0;

        // Generación de Alertas Gerenciales Detección Crítica
        $alertas = [];

        if ($liquidez < 0) {
            $alertas[] = 'Liquidez negativa';
        }

        if ($cuotasVencidas > 0) {
            $alertas[] = sprintf(
                'Existen %d cuotas vencidas',
                $cuotasVencidas
            );
        }

        if ($morosidad >= 10) {
            $alertas[] = sprintf(
                'Morosidad alta: %.2f%%',
                $morosidad
            );
        }

        if ($montoPrestado > $totalAhorros) {
            $alertas[] = 'Capital prestado supera los ahorros';
        }

        return $this->render('indicator/index.html.twig', [
            'totalSocios'        => $totalSocios,
            'totalAhorros'       => $totalAhorros,
            'totalDepositos'     => $totalDepositos,
            'montoPrestado'      => $montoPrestado,
            'cuotasVencidas'     => $cuotasVencidas,
            'liquidez'           => $liquidez,
            'morosidad'          => $morosidad,

            'alertas'            => $alertas,

            'depositosGrafico'   => $movimientos['depositos'],
            'retirosGrafico'     => $movimientos['retiros'],

            'estadoPrestamos'    => $estadoPrestamos,
            // 'depositosMensuales' => $depositosMensuales,
        ]);
    }
}
