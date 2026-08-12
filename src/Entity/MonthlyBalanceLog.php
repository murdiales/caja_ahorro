<?php

namespace App\Entity;

use App\Repository\MonthlyBalanceLogRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: MonthlyBalanceLogRepository::class)]
class MonthlyBalanceLog
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(inversedBy: 'monthlyBalanceLogs')]
    #[ORM\JoinColumn(nullable: false)]
    private ?User $user = null;

    #[ORM\Column]
    private ?int $year = null;

    #[ORM\Column]
    private ?int $month = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2)]
    private ?string $baseCapital = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2)]
    private ?string $newDeposits = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 5, scale: 2)]
    private ?string $appliedRate = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2)]
    private ?string $earnedInterest = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2)]
    private ?string $totalAccumulated = null;

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

    public function getYear(): ?int
    {
        return $this->year;
    }

    public function setYear(int $year): static
    {
        $this->year = $year;

        return $this;
    }

    public function getMonth(): ?int
    {
        return $this->month;
    }

    public function setMonth(int $month): static
    {
        $this->month = $month;

        return $this;
    }

    public function getBaseCapital(): ?string
    {
        return $this->baseCapital;
    }

    public function setBaseCapital(string $baseCapital): static
    {
        $this->baseCapital = $baseCapital;

        return $this;
    }

    public function getNewDeposits(): ?string
    {
        return $this->newDeposits;
    }

    public function setNewDeposits(string $newDeposits): static
    {
        $this->newDeposits = $newDeposits;

        return $this;
    }

    public function getAppliedRate(): ?string
    {
        return $this->appliedRate;
    }

    public function setAppliedRate(string $appliedRate): static
    {
        $this->appliedRate = $appliedRate;

        return $this;
    }

    public function getEarnedInterest(): ?string
    {
        return $this->earnedInterest;
    }

    public function setEarnedInterest(string $earnedInterest): static
    {
        $this->earnedInterest = $earnedInterest;

        return $this;
    }

    public function getTotalAccumulated(): ?string
    {
        return $this->totalAccumulated;
    }

    public function setTotalAccumulated(string $totalAccumulated): static
    {
        $this->totalAccumulated = $totalAccumulated;

        return $this;
    }
}
