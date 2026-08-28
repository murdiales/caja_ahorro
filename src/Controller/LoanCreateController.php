<?php

namespace App\Controller;

use App\Repository\AccountRepository;
use App\Service\LoanRequestService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Attribute\Route;

class LoanCreateController extends AbstractController
{
    #[Route('/loans/create', name: 'loan_create', methods: ['POST'])]
    public function create(
        Request $request,
        AccountRepository $accountRepository,
        LoanRequestService $loanRequestService
    ): RedirectResponse {

        $account = $accountRepository->find(1);

        if (!$account) {

            throw $this->createNotFoundException(
                'No existe la cuenta de prueba.'
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

        $this->addFlash(
            'success',
            'Solicitud registrada correctamente.'
        );

        return $this->redirectToRoute(
            'loan_detail',
            [
                'id' => $loan->getId()
       
]

);

}

}
