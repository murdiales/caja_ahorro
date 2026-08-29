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
    ): Response {

        $amount = (float) $request->request->get('amount');
        $termMonths = (int) $request->request->get('termMonths');
        $interestRate = (float) $request->request->get('interestRate');
        $firstDueDateRaw = $request->request->get('firstDueDate');

        if (
            !$amount ||
            !$termMonths ||
            !$interestRate ||
            !$firstDueDateRaw
        ) {

            $this->addFlash(
                'danger',
                'Todos los campos son obligatorios para procesar la solicitud.'
            );

            return $this->redirectToRoute(
                'loan_simulator'
            );
        }

        $firstDueDate = new \DateTimeImmutable(
            $firstDueDateRaw
        );

        $account = $accountRepository->findOneBy([]);

        if (!$account) {

            $this->addFlash(
                'danger',
                'No se encontró una cuenta asociada para registrar la solicitud.'
            );

            return $this->redirectToRoute(
                'loan_simulator'
            );
        }

        $loan = $loanRequestService->create(
            $account,
            $amount,
            $termMonths,
            $interestRate,
            $firstDueDate
        );

        $this->addFlash(
            'success',
            sprintf(
                'Solicitud de préstamo %s registrada correctamente.',
                $loan->getNumber()
            )
        );

        return $this->redirectToRoute(
            'loan_detail',
            [
                'id' => $loan->getId()
            ]
        );
    }
}
