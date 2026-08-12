<?php

namespace App\Controller;

use App\Entity\Transaction;
use App\Repository\AccountRepository;
use App\Repository\TransactionRepository;
use App\Service\TransactionService;
use Exception;
use Dompdf\Dompdf;
use Dompdf\Options;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/transaction')]
final class TransactionController extends AbstractController
{
    #[Route('/deposit', name: 'app_transaction_deposit', methods: ['GET', 'POST'])]
    public function deposit(
        Request $request,
        TransactionService $transactionService,
        AccountRepository $accountRepository
    ): Response {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        $selectedAccountId = $request->query->get('account_id');

        $reasons = [
            'Aporte ordinario',
            'Aporte extraordinario',
            'Ingreso de intereses',
            'Donación-otros',
            'Amortización de préstamo-otros',
            'Comisión-otros',
            'Multa-otros',
            'Cobro libreta-otros',
            'Venta-otros',
            'Ingreso corriente',
            'Ingreso capital',
            'Ingreso financiero',
            'Actividades sociales-otros',
        ];

        $accounts = $accountRepository->findAll();

        if ($request->isMethod('POST')) {
            $accountId = $request->request->get('account_id');
            $amount = (float) $request->request->get('amount');
            $description = $request->request->get('description');

            $selectedAccount = $accountRepository->find($accountId);

            if (!$selectedAccount) {
                $this->addFlash('danger', 'La cuenta seleccionada no existe.');
            } else {
                try {
                    $transaction = $transactionService->deposit($selectedAccount, $amount, $description);
                    $this->addFlash('success', '¡Depósito realizado con éxito!');
                    return $this->redirectToRoute('app_transaction_receipt', ['id' => $transaction->getId()]);
                } catch (Exception $e) {
                    $this->addFlash('danger', $e->getMessage());
                }
            }
        }

        return $this->render('transaction/deposit.html.twig', [
            'accounts' => $accounts,
            'reasons' => $reasons,
            'selectedAccountId' => $selectedAccountId,
        ]);
    }

    #[Route('/withdraw', name: 'app_transaction_withdraw', methods: ['GET', 'POST'])]
    public function withdraw(
        Request $request,
        TransactionService $transactionService,
        AccountRepository $accountRepository
    ): Response {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        $selectedAccountId = $request->query->get('account_id');

        $reasons = [
            'Retiro',
            'Retiro ordinario',
            'Retiro extraordinario',
            'Pago de servicios',
            'Gasto de intereses y otros',
            'Préstamo',
            'Pago solicitud crédito',
            'Pago caja chica',
            'Pago comisiones',
            'Pago proveedores',
            'Compra',
            'Gasto corriente',
            'Gasto capital',
            'Amortización de pasivo',
            'Liquidación de cuenta',
        ];

        $accounts = $accountRepository->findAll();

        if ($request->isMethod('POST')) {
            $accountId = $request->request->get('account_id');
            $amount = (float) $request->request->get('amount');
            $description = $request->request->get('description');

            $selectedAccount = $accountRepository->find($accountId);

            if (!$selectedAccount) {
                $this->addFlash('danger', 'La cuenta seleccionada no existe.');
            } else {
                try {
                    $transaction = $transactionService->withdraw($selectedAccount, $amount, $description);
                    $this->addFlash('success', '¡Retiro realizado con éxito!');
                    return $this->redirectToRoute('app_transaction_receipt', ['id' => $transaction->getId()]);
                } catch (Exception $e) {
                    $this->addFlash('danger', $e->getMessage());
                }
            }
        }

        return $this->render('transaction/withdraw.html.twig', [
            'accounts' => $accounts,
            'reasons' => $reasons,
            'selectedAccountId' => $selectedAccountId,
        ]);
    }

    /**
     * Muestra el Comprobante Imprimible de Transacción
     */
    #[Route('/receipt/{id}', name: 'app_transaction_receipt', methods: ['GET'])]
    public function receipt(Transaction $transaction): Response
    {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        return $this->render('transaction/receipt.html.twig', [
            'transaction' => $transaction,
        ]);
    }

    /**
     * Descargar Comprobante en PDF
     */
    #[Route('/receipt/{id}/pdf', name: 'app_transaction_receipt_pdf', methods: ['GET'])]
    public function downloadPdf(Transaction $transaction): Response
    {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        $options = new Options();
        $options->set('isHtml5ParserEnabled', true);
        $options->set('isRemoteEnabled', true);

        $dompdf = new Dompdf($options);
        $html = $this->renderView('transaction/receipt_pdf.html.twig', [
            'transaction' => $transaction,
        ]);

        $dompdf->loadHtml($html);
        $dompdf->setPaper('A5', 'portrait');
        $dompdf->render();

        return new Response(
            $dompdf->output(),
            200,
            [
                'Content-Type' => 'application/pdf',
                'Content-Disposition' => sprintf('attachment; filename="Comprobante_%s.pdf"', $transaction->getId()),
            ]
        );
    }

    /**
     * Enviar Comprobante por Correo Electrónico
     */
    #[Route('/receipt/{id}/email', name: 'app_transaction_receipt_email', methods: ['GET'])]
    public function sendEmail(Transaction $transaction, MailerInterface $mailer): Response
    {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        $user = $transaction->getAccount()->getUser();
        $userEmail = $user->getEmail();

        try {
            $emailBody = $this->renderView('transaction/receipt_pdf.html.twig', [
                'transaction' => $transaction,
            ]);

            $email = (new Email())
                ->from('no-reply@caja-ahorro.com')
                ->to($userEmail)
                ->subject(sprintf('Comprobante de Transacción #%d - Caja de Ahorro', $transaction->getId()))
                ->html($emailBody);

            $mailer->send($email);
            $this->addFlash('success', sprintf('¡Comprobante enviado exitosamente al correo %s!', $userEmail));
        } catch (Exception $e) {
            $this->addFlash('danger', 'No se pudo enviar el correo: ' . $e->getMessage());
        }

        return $this->redirectToRoute('app_transaction_receipt', ['id' => $transaction->getId()]);
    }
}