<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260827013817 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE loan ADD number VARCHAR(30) NOT NULL, ADD disbursement_date DATETIME DEFAULT NULL, ADD total_amount NUMERIC(12, 2) NOT NULL, ADD remarks LONGTEXT DEFAULT NULL, ADD created_at DATETIME NOT NULL, ADD updated_at DATETIME DEFAULT NULL, CHANGE requested_at request_date DATETIME NOT NULL, CHANGE approved_at approval_date DATETIME DEFAULT NULL, CHANGE monthly_fee total_interest NUMERIC(12, 2) NOT NULL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE loan ADD monthly_fee NUMERIC(12, 2) NOT NULL, ADD requested_at DATETIME NOT NULL, ADD approved_at DATETIME DEFAULT NULL, DROP number, DROP request_date, DROP approval_date, DROP disbursement_date, DROP total_interest, DROP total_amount, DROP remarks, DROP created_at, DROP updated_at');
    }
}
