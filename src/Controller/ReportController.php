<?php

namespace App\Controller;

use App\Entity\User;
use App\Repository\MonthlyBalanceLogRepository;
use Dompdf\Dompdf;
use Dompdf\Options;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/reportes")
 */
#[Route('/reportes')]
class ReportController extends AbstractController
{
    /**
     * @Route("/socio/{id}/estado-cuenta", name="app_report_statement")
     */
    #[Route('/socio/{id}/estado-cuenta', name: 'app_report_statement')]
    public function statement(User $user, Request $request, MonthlyBalanceLogRepository $logRepo): Response
    {
        $startDate = $request->query->get('start_date', date('Y-01-01'));
        $endDate = $request->query->get('end_date', date('Y-12-31'));

        $start = new \DateTimeImmutable($startDate);
        $end = new \DateTimeImmutable($endDate);

        $logs = $logRepo->createQueryBuilder('m')
            ->where('m.user = :user')
            ->andWhere('m.year >= :startYear AND m.year <= :endYear')
            ->setParameter('user', $user)
            ->setParameter('startYear', (int)$start->format('Y'))
            ->setParameter('endYear', (int)$end->format('Y'))
            ->orderBy('m.year', 'ASC')
            ->addOrderBy('m.month', 'ASC')
            ->getQuery()
            ->getResult();

        return $this->render('report/statement.html.twig', [
            'user' => $user,
            'logs' => $logs,
            'startDate' => $startDate,
            'endDate' => $endDate,
        ]);
    }

    /**
     * @Route("/socio/{id}/estado-cuenta/pdf", name="app_report_statement_pdf")
     */
    #[Route('/socio/{id}/estado-cuenta/pdf', name: 'app_report_statement_pdf')]
    public function exportPdf(User $user, Request $request, MonthlyBalanceLogRepository $logRepo): Response
    {
        $startDate = $request->query->get('start_date', date('Y-01-01'));
        $endDate = $request->query->get('end_date', date('Y-12-31'));

        $start = new \DateTimeImmutable($startDate);
        $end = new \DateTimeImmutable($endDate);

        $logs = $logRepo->createQueryBuilder('m')
            ->where('m.user = :user')
            ->andWhere('m.year >= :startYear AND m.year <= :endYear')
            ->setParameter('user', $user)
            ->setParameter('startYear', (int)$start->format('Y'))
            ->setParameter('endYear', (int)$end->format('Y'))
            ->orderBy('m.year', 'ASC')
            ->addOrderBy('m.month', 'ASC')
            ->getQuery()
            ->getResult();

        $pdfOptions = new Options();
        $pdfOptions->set('defaultFont', 'Arial');
        $dompdf = new Dompdf($pdfOptions);

        $html = $this->renderView('report/pdf_statement.html.twig', [
            'user' => $user,
            'logs' => $logs,
            'startDate' => $startDate,
            'endDate' => $endDate,
        ]);

        $dompdf->loadHtml($html);
        $dompdf->setPaper('A4', 'portrait');
        $dompdf->render();

        return new Response($dompdf->output(), 200, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'inline; filename="Estado_Cuenta_'.$user->getIdentificationNumber().'.pdf"',
        ]);
    }
}