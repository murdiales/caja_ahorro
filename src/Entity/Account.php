<?php

namespace App\Entity;

use App\Repository\AccountRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use App\Entity\User;

#[ORM\Entity(repositoryClass: AccountRepository::class)]
class Account
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: User::class, inversedBy: 'accounts')]
    #[ORM\JoinColumn(nullable: false)]
    private ?User $user = null;

    #[ORM\Column(length: 20, unique: true)]
    private ?string $accountNumber = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 12, scale: 2)]
    private ?string $currentBalance = '0.00';

    #[ORM\Column(length: 20)]
    private ?string $status = 'ACTIVE';

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $openedAt = null;

    #[ORM\OneToMany(mappedBy: 'account', targetEntity: Transaction::class, orphanRemoval: true)]
    private Collection $transactions;

    /**
     * @var Collection<int, Loan>
     */
    #[ORM\OneToMany(targetEntity: Loan::class, mappedBy: 'account')]
    private Collection $loans;

    /**
     * @var Collection<int, InterestAccrual>
     */
    #[ORM\OneToMany(targetEntity: InterestAccrual::class, mappedBy: 'account')]
    private Collection $interestAccruals;

    public function __construct()
    {
        $this->openedAt = new \DateTime();
        $this->transactions = new ArrayCollection();
        $this->loans = new ArrayCollection();
        $this->interestAccruals = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUser(): ?User
    {
        return $this->user;
    }

    public function setUser(?User $user): static
    {
        $this->user = $user;
        return $this;
    }

    public function getAccountNumber(): ?string
    {
        return $this->accountNumber;
    }

    public function setAccountNumber(string $accountNumber): static
    {
        $this->accountNumber = $accountNumber;
        return $this;
    }

    public function getCurrentBalance(): ?string
    {
        return $this->currentBalance;
    }

    public function setCurrentBalance(string $currentBalance): static
    {
        $this->currentBalance = $currentBalance;
        return $this;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(string $status): static
    {
        $this->status = $status;
        return $this;
    }

    public function getOpenedAt(): ?\DateTimeInterface
    {
        return $this->openedAt;
    }

    public function setOpenedAt(\DateTimeInterface $openedAt): static
    {
        $this->openedAt = $openedAt;
        return $this;
    }

    /**
     * @return Collection<int, Transaction>
     */
    public function getTransactions(): Collection
    {
        return $this->transactions;
    }

    public function addTransaction(Transaction $transaction): static
    {
        if (!$this->transactions->contains($transaction)) {
            $this->transactions->add($transaction);
            $transaction->setAccount($this);
        }

        return $this;
    }

    public function removeTransaction(Transaction $transaction): static
    {
        if ($this->transactions->removeElement($transaction)) {
            if ($transaction->getAccount() === $this) {
                $transaction->setAccount(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Loan>
     */
    public function getLoans(): Collection
    {
        return $this->loans;
    }

    public function addLoan(Loan $loan): static
    {
        if (!$this->loans->contains($loan)) {
            $this->loans->add($loan);
            $loan->setAccount($this);
        }

        return $this;
    }

    public function removeLoan(Loan $loan): static
    {
        if ($this->loans->removeElement($loan)) {
            // set the owning side to null (unless already changed)
            if ($loan->getAccount() === $this) {
                $loan->setAccount(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, InterestAccrual>
     */
    public function getInterestAccruals(): Collection
    {
        return $this->interestAccruals;
    }

    public function addInterestAccrual(InterestAccrual $interestAccrual): static
    {
        if (!$this->interestAccruals->contains($interestAccrual)) {
            $this->interestAccruals->add($interestAccrual);
            $interestAccrual->setAccount($this);
        }

        return $this;
    }

    public function removeInterestAccrual(InterestAccrual $interestAccrual): static
    {
        if ($this->interestAccruals->removeElement($interestAccrual)) {
            // set the owning side to null (unless already changed)
            if ($interestAccrual->getAccount() === $this) {
                $interestAccrual->setAccount(null);
            }
        }

        return $this;
    }
}