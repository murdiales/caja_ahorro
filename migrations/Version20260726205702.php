<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260726205702 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE loan (id INT AUTO_INCREMENT NOT NULL, amount NUMERIC(12, 2) NOT NULL, term_months INT NOT NULL, interest_rate NUMERIC(5, 2) NOT NULL, monthly_fee NUMERIC(12, 2) NOT NULL, status VARCHAR(20) NOT NULL, requested_at DATETIME NOT NULL, approved_at DATETIME DEFAULT NULL, account_id INT NOT NULL, INDEX IDX_C5D30D039B6B5FBA (account_id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('ALTER TABLE loan ADD CONSTRAINT FK_C5D30D039B6B5FBA FOREIGN KEY (account_id) REFERENCES account (id)');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_7D3656A4B1A4D127 ON account (account_number)');
        $this->addSql('ALTER TABLE user DROP address, CHANGE identification_number identification_number VARCHAR(20) NOT NULL');
        $this->addSql('ALTER TABLE user RENAME INDEX uniq_identifier_email TO UNIQ_8D93D649E7927C74');
        $this->addSql('ALTER TABLE user RENAME INDEX uniq_identifier_cedula TO UNIQ_8D93D649347639A5');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE loan DROP FOREIGN KEY FK_C5D30D039B6B5FBA');
        $this->addSql('DROP TABLE loan');
        $this->addSql('DROP INDEX UNIQ_7D3656A4B1A4D127 ON account');
        $this->addSql('ALTER TABLE `user` ADD address VARCHAR(255) DEFAULT NULL, CHANGE identification_number identification_number VARCHAR(10) NOT NULL');
        $this->addSql('ALTER TABLE `user` RENAME INDEX uniq_8d93d649e7927c74 TO UNIQ_IDENTIFIER_EMAIL');
        $this->addSql('ALTER TABLE `user` RENAME INDEX uniq_8d93d649347639a5 TO UNIQ_IDENTIFIER_CEDULA');
    }
}
