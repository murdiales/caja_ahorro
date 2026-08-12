<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class EmailLog
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $recipient = null;

    #[ORM\Column(length: 255)]
    private ?string $subject = null;

    #[ORM\Column(type: 'text')]
    private ?string $body = null;

    #[ORM\Column(length: 50)]
    private ?string $status = null;

    #[ORM\Column]
    private ?\DateTime $sentAt = null;

    public function __construct() {
        $this->sentAt = new \DateTime();
    }

    public function getId(): ?int { return $this->id; }
    public function getRecipient(): ?string { return $this->recipient; }
    public function setRecipient(string $recipient): self { $this->recipient = $recipient; return $this; }
    public function getSubject(): ?string { return $this->subject; }
    public function setSubject(string $subject): self { $this->subject = $subject; return $this; }
    public function getBody(): ?string { return $this->body; }
    public function setBody(string $body): self { $this->body = $body; return $this; }
    public function getStatus(): ?string { return $this->status; }
    public function setStatus(string $status): self { $this->status = $status; return $this; }
    public function getSentAt(): ?\DateTime { return $this->sentAt; }
}