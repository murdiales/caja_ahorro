<?php

namespace App\Controller;

use App\Repository\AccountRepository;
use App\Service\LoanRequestService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class LoanCreateController extends AbstractController
{
    #[Route('/loans/create', name: 'loan_create', methods: ['POST'])]
    public function create(
        Request $request,
        AccountRepository $accountRepository,
        LoanRequestService $loanRequestService
    ): Response
    {
        try {

            $account = $accountRepository->find(1);

            if (!$account) {

                return new Response(
                    '<h1>Error</h1><pre>No existe Account ID 1.</pre>'
                );
            }

            $loan = $loanRequestService->create(
                $account,
                (float) $request->request->get('amount'),
                (int) $request->request->get('termMonths'),
                (float) $request->request->get('interestRate'),
                new \DateTimeImmutable(
                    $request->request->get('firstDueDate')
                )
            );

            dd($loan);

        } catch (\Throwable $e) {

            return new Response(
                '<h1>Error al crear préstamo</h1>'
                . '<hr>'
                . '<h3>Mensaje</h3>'
                . '<pre>'
                . $e->getMessage()
                . '</pre>'
                . '<h3>Archivo</h3>'
                . '<pre>'
                . $e->getFile()
                . '</pre>'
                . '<h3>Línea</h3>'
                . '<pre>'
                . $e->getLine()
                . '</pre>'
                . '<h3>Trace</h3>'
                . '<pre>'
                . $e->getTraceAsString()
                . '</pre>'
            );
        }
    }
}
