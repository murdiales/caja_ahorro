<?php

namespace App\Entity;

use App\Repository\LoanRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: LoanRepository::class)]
class Loan
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(inversedBy: 'loans')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Account $account = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 12, scale: 2)]
    private ?string $amount = null;

    #[ORM\Column]
    private ?int $termMonths = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 5, scale: 2)]
    private ?string $interestRate = null;

    #[ORM\Column(length: 20)]
    private ?string $status = null;

    #[ORM\Column(length: 30)]
    private ?string $number = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $requestDate = null;

    #[ORM\Column(nullable: true)]
    private ?\DateTimeImmutable $approvalDate = null;

    #[ORM\Column(nullable: true)]
    private ?\DateTimeImmutable $disbursementDate = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 12, scale: 2)]
    private ?string $totalInterest = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 12, scale: 2)]
    private ?string $totalAmount = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $remarks = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $createdAt = null;

    #[ORM\Column(nullable: true)]
    private ?\DateTimeImmutable $updatedAt = null;

    /**
     * @var Collection<int, LoanInstallment>
     */
    #[ORM\OneToMany(targetEntity: LoanInstallment::class, mappedBy: 'loan')]
    private Collection $installments;

    public function __construct()
    {
        $this->installments = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getAccount(): ?Account
    {
        return $this->account;
    }

    public function setAccount(?Account $account): static
    {
        $this->account = $account;

        return $this;
    }

    public function getAmount(): ?string
    {
        return $this->amount;
    }

    public function setAmount(string $amount): static
    {
        $this->amount = $amount;

        return $this;
    }

    public function getTermMonths(): ?int
    {
        return $this->termMonths;
    }

    public function setTermMonths(int $termMonths): static
    {
        $this->termMonths = $termMonths;

        return $this;
    }

    public function getInterestRate(): ?string
    {
        return $this->interestRate;
    }

    public function setInterestRate(string $interestRate): static
    {
        $this->interestRate = $interestRate;

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

    public function getNumber(): ?string
    {
        return $this->number;
    }

    public function setNumber(string $number): static
    {
        $this->number = $number;

        return $this;
    }

    public function getRequestDate(): ?\DateTimeImmutable
    {
        return $this->requestDate;
    }

    public function setRequestDate(\DateTimeImmutable $requestDate): static
    {
        $this->requestDate = $requestDate;

        return $this;
    }

    public function getApprovalDate(): ?\DateTimeImmutable
    {
        return $this->approvalDate;
    }

    public function setApprovalDate(?\DateTimeImmutable $approvalDate): static
    {
        $this->approvalDate = $approvalDate;

        return $this;
    }

    public function getDisbursementDate(): ?\DateTimeImmutable
    {
        return $this->disbursementDate;
    }

    public function setDisbursementDate(?\DateTimeImmutable $disbursementDate): static
    {
        $this->disbursementDate = $disbursementDate;

        return $this;
    }

    public function getTotalInterest(): ?string
    {
        return $this->totalInterest;
    }

    public function setTotalInterest(string $totalInterest): static
    {
        $this->totalInterest = $totalInterest;

        return $this;
    }

    public function getTotalAmount(): ?string
    {
        return $this->totalAmount;
    }

    public function setTotalAmount(string $totalAmount): static
    {
        $this->totalAmount = $totalAmount;

        return $this;
    }

    public function getRemarks(): ?string
    {
        return $this->remarks;
    }

    public function setRemarks(?string $remarks): static
    {
        $this->remarks = $remarks;

        return $this;
    }

    public function getCreatedAt(): ?\DateTimeImmutable
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeImmutable $createdAt): static
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getUpdatedAt(): ?\DateTimeImmutable
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(?\DateTimeImmutable $updatedAt): static
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    /**
     * @return Collection<int, LoanInstallment>
     */
    public function getInstallments(): Collection
    {
        return $this->installments;
    }

    public function addInstallment(LoanInstallment $installment): static
    {
        if (!$this->installments->contains($installment)) {
            $this->installments->add($installment);
            $installment->setLoan($this);
        }

        return $this;
    }

    public function removeInstallment(LoanInstallment $installment): static
    {
        if ($this->installments->removeElement($installment)) {
            // set the owning side to null (unless already changed)
            if ($installment->getLoan() === $this) {
                $installment->setLoan(null);
            }
        }

        return $this;
    }
}
