<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260807004830 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE interest_rate_config (id INT AUTO_INCREMENT NOT NULL, rate NUMERIC(5, 2) NOT NULL, start_date DATETIME NOT NULL, end_date DATETIME DEFAULT NULL, description VARCHAR(255) DEFAULT NULL, PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('CREATE TABLE monthly_balance_log (id INT AUTO_INCREMENT NOT NULL, year INT NOT NULL, month INT NOT NULL, base_capital NUMERIC(10, 2) NOT NULL, new_deposits NUMERIC(10, 2) NOT NULL, applied_rate NUMERIC(5, 2) NOT NULL, earned_interest NUMERIC(10, 2) NOT NULL, total_accumulated NUMERIC(10, 2) NOT NULL, user_id INT NOT NULL, INDEX IDX_813C5553A76ED395 (user_id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('ALTER TABLE monthly_balance_log ADD CONSTRAINT FK_813C5553A76ED395 FOREIGN KEY (user_id) REFERENCES `user` (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE monthly_balance_log DROP FOREIGN KEY FK_813C5553A76ED395');
        $this->addSql('DROP TABLE interest_rate_config');
        $this->addSql('DROP TABLE monthly_balance_log');
    }
}
