<?php

namespace App\Service;

use App\Entity\Account;
use App\Entity\Transaction;
use Doctrine\ORM\EntityManagerInterface;
use Exception;

class TransactionService
{
    public function __construct(private EntityManagerInterface $entityManager)
    {
    }

    /**
     * Registra un Depósito en la Cuenta
     */
    public function deposit(Account $account, float $amount, ?string $description = null, ?\DateTimeInterface $transactionDate = null): Transaction
        {
        if ($amount <= 0) {
            throw new Exception('El monto a depositar debe ser mayor a cero.');
        }

        $this->entityManager->beginTransaction();
        try {
            $newBalance = (float) $account->getCurrentBalance() + $amount;
            $account->setCurrentBalance((string) $newBalance);

            if (!$transactionDate) {$transactionDate = new \DateTime();
            }

            $effectiveDate = new \DateTime($transactionDate->format('Y-m') . '-28'
            );

            $transaction = new Transaction();
            $transaction->setAccount($account);
            $transaction->setType('DEPOSIT');
            $transaction->setAmount((string) $amount);
            $transaction->setDescription($description ?? 'Depósito a cuenta');

            $transaction->setTransactionDate($transactionDate
            );

            $transaction->setEffectiveDate($effectiveDate
            );

            $this->entityManager->persist($transaction);
            $this->entityManager->flush();
            $this->entityManager->commit();

            return $transaction;
        } catch (Exception $e) {
            $this->entityManager->rollback();
            throw $e;
        }
    }

    /**
     * Registra un Retiro de la Cuenta
     */
    public function withdraw(Account $account, float $amount, ?string $description = null): Transaction
    {
        if ($amount <= 0) {
            throw new Exception('El monto a retirar debe ser mayor a cero.');
        }

        $currentBalance = (float) $account->getCurrentBalance();
        if ($amount > $currentBalance) {
            throw new Exception('Saldo insuficiente para realizar el retiro.');
        }

        $this->entityManager->beginTransaction();
        try {
            $newBalance = $currentBalance - $amount;
            $account->setCurrentBalance((string) $newBalance);

            $transaction = new Transaction();
            $transaction->setAccount($account);
            $transaction->setType('WITHDRAWAL');
            $transaction->setAmount((string) $amount);
            $transaction->setDescription($description ?? 'Retiro de cuenta');

            $this->entityManager->persist($transaction);
            $this->entityManager->flush();
            $this->entityManager->commit();

            return $transaction;
        } catch (Exception $e) {
            $this->entityManager->rollback();
            throw $e;
        }
    }
}
