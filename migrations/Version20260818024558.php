<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260818024558 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE interest_accrual (id INT AUTO_INCREMENT NOT NULL, period VARCHAR(20) NOT NULL, capital_base NUMERIC(12, 2) NOT NULL, interest_rate NUMERIC(5, 2) NOT NULL, interest_amount NUMERIC(12, 2) NOT NULL, created_at DATETIME NOT NULL, account_id INT NOT NULL, INDEX IDX_44CB2AB19B6B5FBA (account_id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('ALTER TABLE interest_accrual ADD CONSTRAINT FK_44CB2AB19B6B5FBA FOREIGN KEY (account_id) REFERENCES account (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE interest_accrual DROP FOREIGN KEY FK_44CB2AB19B6B5FBA');
        $this->addSql('DROP TABLE interest_accrual');
    }
}
