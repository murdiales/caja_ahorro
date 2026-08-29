<?php

namespace App\Controller;

use App\Repository\LoanInstallmentRepository;
use App\Repository\LoanRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class LoanDetailController extends AbstractController
{
    #[Route(
        '/loans/{id}',
        name: 'loan_detail',
        requirements: ['id' => '\d+']
    )]
    public function show(
        int $id,
        LoanRepository $loanRepository,
        LoanInstallmentRepository $installmentRepository
    ): Response {

        $loan = $loanRepository->find($id);

        if (!$loan) {

            $this->addFlash(
                'danger',
                'El préstamo solicitado no existe.'
            );

            return $this->redirectToRoute(
                'loan_requests'
            );
        }

        $installments = $installmentRepository->findBy(
            [
                'loan' => $loan
            ],
            [
                'installmentNumber' => 'ASC'
            ]
        );

        return $this->render(
            'loan/detail.html.twig',
            [
                'loan' => $loan,
                'installments' => $installments,
            ]
        );
    }
}
