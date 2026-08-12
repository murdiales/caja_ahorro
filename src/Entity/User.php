<?php

namespace App\Entity;

use App\Repository\UserRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\UserInterface;

#[ORM\Entity(repositoryClass: UserRepository::class)]
#[ORM\Table(name: '`user`')]
class User implements UserInterface, PasswordAuthenticatedUserInterface
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 180, unique: true)]
    private ?string $email = null;

    #[ORM\Column]
    private array $roles = [];

    #[ORM\Column]
    private ?string $password = null;

    #[ORM\Column(length: 100)]
    private ?string $firstName = null;

    #[ORM\Column(length: 100)]
    private ?string $lastName = null;

    #[ORM\Column(length: 20, unique: true)]
    private ?string $identificationNumber = null;

    #[ORM\Column(length: 20, nullable: true)]
    private ?string $phone = null;

    #[ORM\OneToMany(mappedBy: 'user', targetEntity: Account::class)]
    private Collection $accounts;

    /**
     * @var Collection<int, MonthlyBalanceLog>
     */
    #[ORM\OneToMany(targetEntity: MonthlyBalanceLog::class, mappedBy: 'user')]
    private Collection $monthlyBalanceLogs;

    public function __construct()
    {
        $this->accounts = new ArrayCollection();
        $this->monthlyBalanceLogs = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): static
    {
        $this->email = $email;
        return $this;
    }

    public function getUserIdentifier(): string
    {
        return (string) $this->email;
    }

    public function getRoles(): array
    {
        $roles = $this->roles;
        $roles[] = 'ROLE_USER';
        return array_unique($roles);
    }

    public function setRoles(array $roles): static
    {
        $this->roles = $roles;
        return $this;
    }

    public function getPassword(): string
    {
        return $this->password;
    }

    public function setPassword(string $password): static
    {
        $this->password = $password;
        return $this;
    }

    public function eraseCredentials(): void
    {
    }

    public function getFirstName(): ?string
    {
        return $this->firstName;
    }

    public function setFirstName(string $firstName): static
    {
        $this->firstName = $firstName;
        return $this;
    }

    public function getLastName(): ?string
    {
        return $this->lastName;
    }

    public function setLastName(string $lastName): static
    {
        $this->lastName = $lastName;
        return $this;
    }

    public function getIdentificationNumber(): ?string
    {
        return $this->identificationNumber;
    }

    public function setIdentificationNumber(string $identificationNumber): static
    {
        $this->identificationNumber = $identificationNumber;
        return $this;
    }

    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(?string $phone): static
    {
        $this->phone = $phone;
        return $this;
    }

    /**
     * @return Collection<int, Account>
     */
    public function getAccounts(): Collection
    {
        return $this->accounts;
    }

    /**
     * @return Collection<int, MonthlyBalanceLog>
     */
    public function getMonthlyBalanceLogs(): Collection
    {
        return $this->monthlyBalanceLogs;
    }

    public function addMonthlyBalanceLog(MonthlyBalanceLog $monthlyBalanceLog): static
    {
        if (!$this->monthlyBalanceLogs->contains($monthlyBalanceLog)) {
            $this->monthlyBalanceLogs->add($monthlyBalanceLog);
            $monthlyBalanceLog->setUser($this);
        }

        return $this;
    }

    public function removeMonthlyBalanceLog(MonthlyBalanceLog $monthlyBalanceLog): static
    {
        if ($this->monthlyBalanceLogs->removeElement($monthlyBalanceLog)) {
            // set the owning side to null (unless already changed)
            if ($monthlyBalanceLog->getUser() === $this) {
                $monthlyBalanceLog->setUser(null);
            }
        }

        return $this;
    }
}