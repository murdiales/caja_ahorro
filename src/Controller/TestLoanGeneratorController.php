<?php

namespace App\Controller;

use App\Entity\Account;
use App\Entity\Loan;
use App\Repository\AccountRepository;
use App\Repository\LoanInstallmentRepository;
use App\Service\LoanInstallmentGeneratorService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class TestLoanGeneratorController extends AbstractController
{
    #[Route('/test-loan-generator', name: 'app_test_loan_generator')]
    public function index(
        EntityManagerInterface $entityManager,
        LoanInstallmentGeneratorService $generator,
        LoanInstallmentRepository $installmentRepository,
        AccountRepository $accountRepository
    ): Response {

        $account = $accountRepository->findOneBy([]);

        if (!$account) {
            return new Response('No existe la cuenta de prueba.');
        }

        $loan = new Loan();
        $loan->setAccount($account);
        $loan->setNumber('TEST-0001');
        $loan->setAmount('1000.00');
        $loan->setTermMonths(10);
        $loan->setInterestRate('1.00');
        $loan->setStatus('ACTIVE');

        $loan->setRequestDate(
            new \DateTimeImmutable()
        );

        $loan->setCreatedAt(
            new \DateTimeImmutable()
        );

        $loan->setTotalInterest('55.00');
        $loan->setTotalAmount('1055.00');

        $entityManager->persist($loan);
        $entityManager->flush();

        $generator->generate(
            $loan,
            new \DateTimeImmutable('2026-09-30')
        );

        $installments = $installmentRepository->findBy(
            ['loan' => $loan],
            ['installmentNumber' => 'ASC']
        );

        $html = '<h1>Generación de Tabla de Amortización</h1>';
        $html .= '<p><strong>Préstamo:</strong> ' . $loan->getNumber() . '</p>';
        $html .= '<p><strong>Monto:</strong> $' . $loan->getAmount() . '</p>';
        $html .= '<p><strong>Plazo:</strong> ' . $loan->getTermMonths() . ' meses</p>';

        $html .= '<table border="1" cellpadding="5" cellspacing="0">';
        $html .= '<tr>
                    <th>#</th>
                    <th>Vencimiento</th>
                    <th>Saldo Inicial</th>
                    <th>Capital</th>
                    <th>Interés</th>
                    <th>Cuota Total</th>
                    <th>Saldo Final</th>
                    <th>Estado</th>
                  </tr>';

        foreach ($installments as $item) {
            $html .= '<tr>';
            $html .= '<td>' . $item->getInstallmentNumber() . '</td>';
            $html .= '<td>' . $item->getDueDate()->format('Y-m-d') . '</td>';
            $html .= '<td>$' . $item->getOpeningBalance() . '</td>';
            $html .= '<td>$' . $item->getPrincipalAmount() . '</td>';
            $html .= '<td>$' . $item->getInterestAmount() . '</td>';
            $html .= '<td>$' . $item->getInstallmentAmount() . '</td>';
            $html .= '<td>$' . $item->getClosingBalance() . '</td>';
            $html .= '<td>' . $item->getStatus() . '</td>';
            $html .= '</tr>';
        }

        $html .= '</table>';

        return new Response($html);
    }
}
