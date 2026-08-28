<?php

namespace App\Controller;

use App\Repository\LoanRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class LoanRequestController extends AbstractController
{
    #[Route('/loans/requests', name: 'loan_requests')]
    public function index(
        LoanRepository $loanRepository
    ): Response {

        $loans = $loanRepository->findBy(
            [],
            ['id' => 'DESC']
        );

        return $this->render(
            'loan/requests.html.twig',
            [
                'loans' => $loans,
            ]
        );
    }
}
