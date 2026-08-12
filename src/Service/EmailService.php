<?php

namespace App\Service;

use App\Entity\EmailLog;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;

class EmailService
{
    public function __construct(
        private MailerInterface $mailer,
        private EntityManagerInterface $em
    ) {}

    public function send(string $to, string $subject, string $htmlContent): bool
    {
        $log = new EmailLog();
        $log->setRecipient($to);
        $log->setSubject($subject);
        $log->setBody($htmlContent);

        try {
            $email = (new Email())
                ->from('no-reply@caja-ahorro.com')
                ->to($to)
                ->subject($subject)
                ->html($htmlContent);

            $this->mailer->send($email);
            $log->setStatus('ENVIADO');
            $success = true;
        } catch (\Exception $e) {
            $log->setStatus('FALLIDO: ' . $e->getMessage());
            $success = false;
        }

        $this->em->persist($log);
        $this->em->flush();

        return $success;
    }
}