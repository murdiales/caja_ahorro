<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260827025252 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE loan_installment (id INT AUTO_INCREMENT NOT NULL, interest_amount NUMERIC(12, 2) NOT NULL, late_fee_amount NUMERIC(12, 2) NOT NULL, installment_amount NUMERIC(12, 2) NOT NULL, closing_balance NUMERIC(12, 2) NOT NULL, status VARCHAR(20) NOT NULL, paid_at DATETIME DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME DEFAULT NULL, installment_number INT NOT NULL, due_date DATE NOT NULL, opening_balance NUMERIC(12, 2) NOT NULL, principal_amount NUMERIC(12, 2) NOT NULL, loan_id INT NOT NULL, INDEX IDX_EFB6D589CE73868F (loan_id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('ALTER TABLE loan_installment ADD CONSTRAINT FK_EFB6D589CE73868F FOREIGN KEY (loan_id) REFERENCES loan (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE loan_installment DROP FOREIGN KEY FK_EFB6D589CE73868F');
        $this->addSql('DROP TABLE loan_installment');
    }
}
