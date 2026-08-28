<?php

namespace App\Controller;

use App\Form\LoanSimulationType;
use App\Service\LoanAmortizationService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class LoanSimulatorController extends AbstractController
{
    #[Route('/loans/simulator', name: 'loan_simulator')]
    public function index(
        Request $request,
        LoanAmortizationService $loanAmortizationService
    ): Response {
        $result = null;

        $form = $this->createForm(
            LoanSimulationType::class
        );

        $form->handleRequest($request);

        if (
            $form->isSubmitted()
            && $form->isValid()
        ) {
            $data = $form->getData();

            $result = $loanAmortizationService
                ->generateSchedule(
                    (float) $data['amount'],
                    (int) $data['termMonths'],
                    (float) $data['interestRate']
                );
        }

        return $this->render(
            'loan/simulator.html.twig',
            [
                'form' => $form->createView(),
                'result' => $result,
            ]
        );
    }
}
