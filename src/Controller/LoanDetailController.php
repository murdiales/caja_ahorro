<?php

namespace App\Controller;

use App\Entity\Loan;
use App\Repository\LoanInstallmentRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class LoanDetailController extends AbstractController
{
    #[Route('/loans/{id}', name: 'loan_detail')]
    public function show(
        Loan $loan,
        LoanInstallmentRepository $installmentRepository
    ): Response {

        $installments = $installmentRepository->findBy(
            ['loan' => $loan],
            ['installmentNumber' => 'ASC']
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
