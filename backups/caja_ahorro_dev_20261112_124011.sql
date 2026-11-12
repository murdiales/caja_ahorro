-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: caja_ahorro_dev
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.5

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_number` varchar(20) NOT NULL,
  `current_balance` decimal(12,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `opened_at` datetime NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_7D3656A4B1A4D127` (`account_number`),
  KEY `IDX_7D3656A4A76ED395` (`user_id`),
  CONSTRAINT `FK_7D3656A4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'CTA-26065195',6019.00,'ACTIVE','2026-06-28 00:00:00',2),(2,'CTA-26062949',1000.00,'ACTIVE','2026-06-28 00:00:00',3),(3,'CTA-26069372',0.00,'ACTIVE','2026-06-28 00:00:00',4),(4,'CTA-26065181',1000.00,'ACTIVE','2026-06-28 00:00:00',5),(5,'CTA-26060750',0.00,'ACTIVE','2026-06-28 00:00:00',6),(6,'CTA-26062223',0.00,'ACTIVE','2026-06-28 00:00:00',7),(7,'CTA-26063723',0.00,'ACTIVE','2026-06-28 00:00:00',8),(8,'CTA-26063300',0.00,'ACTIVE','2026-06-28 00:00:00',9),(9,'CTA-26065196',100.00,'ACTIVE','2026-06-28 00:00:00',10);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine_migration_versions`
--

LOCK TABLES `doctrine_migration_versions` WRITE;
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` VALUES ('DoctrineMigrations\\Version20260726024508',NULL,NULL),('DoctrineMigrations\\Version20260726151410',NULL,NULL),('DoctrineMigrations\\Version20260726170816',NULL,NULL),('DoctrineMigrations\\Version20260726171032',NULL,NULL),('DoctrineMigrations\\Version20260726171231',NULL,NULL),('DoctrineMigrations\\Version20260726205702',NULL,NULL),('DoctrineMigrations\\Version20260807004830',NULL,NULL),('DoctrineMigrations\\Version20260807032154',NULL,NULL),('DoctrineMigrations\\Version20260812005008',NULL,NULL),('DoctrineMigrations\\Version20260816225551',NULL,NULL),('DoctrineMigrations\\Version20260818024558',NULL,NULL),('DoctrineMigrations\\Version20260823031807',NULL,NULL),('DoctrineMigrations\\Version20260823033056','2026-08-23 03:32:48',46),('DoctrineMigrations\\Version20260827013817','2026-08-27 01:41:04',119),('DoctrineMigrations\\Version20260827025252','2026-08-27 02:54:10',114),('DoctrineMigrations\\Version20260829034824','2026-08-29 03:48:45',29),('DoctrineMigrations\\Version20261107121347','2026-11-07 12:14:36',231);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `category` varchar(50) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_at` datetime NOT NULL,
  `uploaded_by_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D8698A76A2B28FE8` (`uploaded_by_id`),
  CONSTRAINT `FK_D8698A76A2B28FE8` FOREIGN KEY (`uploaded_by_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_log`
--

DROP TABLE IF EXISTS `email_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `recipient` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  `status` varchar(50) NOT NULL,
  `sent_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_log`
--

LOCK TABLES `email_log` WRITE;
/*!40000 ALTER TABLE `email_log` DISABLE KEYS */;
INSERT INTO `email_log` VALUES (1,'murdiales.ecu@gmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Marco Vinicio Urdiales Reinoso</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26065195</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 12:45:08'),(2,'guarderia_quito@yahoo.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Ruth Estela Pinto Pinto</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26062949</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 12:47:02'),(3,'jesireeabadia@gmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Jesiree Abadia Cisneros</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26069372</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:08:33'),(4,'maferedyfer@gmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>María Fernanda Cedeño Fernández</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26065181</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:09:31'),(5,'diazdolore83@gmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Luis Robinson Pinto Pinto</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26060750</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:10:32'),(6,'ep_pinto@hotmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Edison Edmundo Pinto Pinto</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26062223</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:11:38'),(7,'katygeo1408@gmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Katy Geovanna Pinto Pinto</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26063723</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:14:26'),(8,'d4vidpinto@gmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>David Alexander Pinto Pinto</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26063300</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:15:29'),(9,'d4vidpinto1313@gmail.com','Caja de Ahorro - Notificación de Accesos','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>David Alexander Pinto Pinto</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26063300</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:30:24'),(10,'maferedyfer@gmail.com','Caja de Ahorro - Notificación de Accesos','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>María Fernanda Cedeño Fernández</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26065181</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 23:21:01'),(11,'murdiales_ecu@hotmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Prueba Sistema</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26065196</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-17 00:23:20');
/*!40000 ALTER TABLE `email_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interest_accrual`
--

DROP TABLE IF EXISTS `interest_accrual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interest_accrual` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `period` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `capital_base` decimal(12,2) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `interest_amount` decimal(12,2) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_44CB2AB19B6B5FBA` (`account_id`),
  CONSTRAINT `FK_44CB2AB19B6B5FBA` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interest_accrual`
--

LOCK TABLES `interest_accrual` WRITE;
/*!40000 ALTER TABLE `interest_accrual` DISABLE KEYS */;
INSERT INTO `interest_accrual` VALUES (1,9,'2026-08',100.00,1.00,1.00,'2026-08-18 02:53:47');
/*!40000 ALTER TABLE `interest_accrual` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interest_generation_log`
--

DROP TABLE IF EXISTS `interest_generation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interest_generation_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `period` varchar(50) NOT NULL,
  `execution_date` datetime NOT NULL,
  `accounts_processed` int NOT NULL,
  `interests_generated` int NOT NULL,
  `status` varchar(30) NOT NULL,
  `notes` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interest_generation_log`
--

LOCK TABLES `interest_generation_log` WRITE;
/*!40000 ALTER TABLE `interest_generation_log` DISABLE KEYS */;
INSERT INTO `interest_generation_log` VALUES (1,'2026-08','2026-08-23 03:46:10',0,0,'SKIPPED','Proceso omitido. Día actual: 23. Día de corte: 30.'),(2,'2026-08','2026-08-23 03:57:35',0,0,'SKIPPED','Proceso omitido. Día actual: 23. Día de corte: 30.'),(3,'2026-08','2026-08-23 03:58:35',0,0,'SKIPPED','Proceso omitido. Día actual: 23. Día de corte: 30.'),(4,'2026-08','2026-08-23 04:01:38',0,0,'SKIPPED','Proceso omitido. Día actual: 23. Día de corte: 30.'),(5,'2026-08','2026-08-23 04:10:02',0,0,'SKIPPED','Proceso omitido. Día actual: 23. Día de corte: 30.'),(6,'2026-08','2026-08-23 04:13:00',0,0,'SKIPPED','Proceso omitido. Día actual: 23. Día de corte: 30.'),(7,'2026-08','2026-08-23 04:14:01',0,0,'SKIPPED','Proceso omitido. Día actual: 23. Día de corte: 30.'),(8,'2026-08','2026-08-23 04:15:37',0,0,'SKIPPED','Proceso omitido. Día actual: 23. Día de corte: 30.'),(9,'2026-08','2026-08-23 06:00:02',0,0,'SKIPPED','Proceso omitido. Día actual: 23. Día de corte: 30.'),(10,'2026-08','2026-08-24 06:00:02',0,0,'SKIPPED','Proceso omitido. Día actual: 24. Día de corte: 30.'),(11,'2026-08','2026-08-25 06:00:02',0,0,'SKIPPED','Proceso omitido. Día actual: 25. Día de corte: 30.'),(12,'2026-08','2026-08-26 06:00:02',0,0,'SKIPPED','Proceso omitido. Día actual: 26. Día de corte: 30.'),(13,'2026-08','2026-08-27 00:58:01',0,0,'SKIPPED','Proceso omitido. Día actual: 27. Día de corte: 30.'),(14,'2026-08','2026-08-27 06:00:01',0,0,'SKIPPED','Proceso omitido. Día actual: 27. Día de corte: 30.'),(15,'2026-08','2026-08-28 06:00:02',0,0,'SKIPPED','Proceso omitido. Día actual: 28. Día de corte: 30.'),(16,'2026-08','2026-08-29 06:00:02',0,0,'SKIPPED','Proceso omitido. Día actual: 29. Día de corte: 30.'),(17,'2026-08','2026-08-30 06:00:02',9,0,'COMPLETED','Proceso ejecutado correctamente. 0 intereses generados.'),(18,'2026-08','2026-08-31 06:00:02',9,0,'COMPLETED','Proceso ejecutado correctamente. 0 intereses generados.');
/*!40000 ALTER TABLE `interest_generation_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interest_rate_config`
--

DROP TABLE IF EXISTS `interest_rate_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interest_rate_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rate` decimal(5,2) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interest_rate_config`
--

LOCK TABLES `interest_rate_config` WRITE;
/*!40000 ALTER TABLE `interest_rate_config` DISABLE KEYS */;
INSERT INTO `interest_rate_config` VALUES (1,1.00,'2026-08-20 00:00:00',NULL,'Tasa oficial mensual');
/*!40000 ALTER TABLE `interest_rate_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(12,2) NOT NULL,
  `term_months` int NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `total_interest` decimal(12,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `request_date` datetime NOT NULL,
  `approval_date` datetime DEFAULT NULL,
  `account_id` int NOT NULL,
  `number` varchar(30) NOT NULL,
  `disbursement_date` datetime DEFAULT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `remarks` longtext,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `approved_by` varchar(255) DEFAULT NULL,
  `rejection_date` datetime DEFAULT NULL,
  `rejected_by` varchar(255) DEFAULT NULL,
  `rejection_reason` longtext,
  PRIMARY KEY (`id`),
  KEY `IDX_C5D30D039B6B5FBA` (`account_id`),
  CONSTRAINT `FK_C5D30D039B6B5FBA` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (1,1000.00,10,1.00,55.00,'APROBADO','2026-08-27 03:12:39',NULL,1,'TEST-0001',NULL,1055.00,NULL,'2026-08-27 03:12:39',NULL,NULL,NULL,NULL,NULL),(2,1000.00,10,1.00,55.00,'APROBADO','2026-08-27 03:15:17',NULL,1,'TEST-0001',NULL,1055.00,NULL,'2026-08-27 03:15:17',NULL,NULL,NULL,NULL,NULL),(3,1000.00,10,1.00,55.00,'APROBADO','2026-08-27 03:16:27',NULL,1,'TEST-0001',NULL,1055.00,NULL,'2026-08-27 03:16:27',NULL,NULL,NULL,NULL,NULL),(4,1000.00,10,1.00,55.00,'APROBADO','2026-08-27 03:18:18',NULL,1,'TEST-0001',NULL,1055.00,NULL,'2026-08-27 03:18:18',NULL,NULL,NULL,NULL,NULL),(5,1000.00,10,1.00,55.00,'APROBADO','2026-08-27 03:20:34',NULL,1,'TEST-0001',NULL,1055.00,NULL,'2026-08-27 03:20:34',NULL,NULL,NULL,NULL,NULL),(6,1000.00,10,1.00,55.00,'APROBADO','2026-08-27 03:26:59',NULL,1,'TEST-0001',NULL,1055.00,NULL,'2026-08-27 03:26:59',NULL,NULL,NULL,NULL,NULL),(7,1000.00,10,1.00,55.00,'APROBADO','2026-08-27 03:28:44',NULL,1,'TEST-0001',NULL,1055.00,NULL,'2026-08-27 03:28:44',NULL,NULL,NULL,NULL,NULL),(8,1000.00,10,1.00,55.00,'APROBADO','2026-08-27 03:29:47',NULL,1,'TEST-0001',NULL,1055.00,NULL,'2026-08-27 03:29:47',NULL,NULL,NULL,NULL,NULL),(9,1000.00,10,1.00,55.00,'APROBADO','2026-08-27 03:33:09',NULL,1,'TEST-0001',NULL,1055.00,NULL,'2026-08-27 03:33:09',NULL,NULL,NULL,NULL,NULL),(10,1000.00,10,1.00,55.00,'APROBADO','2026-08-27 03:33:17',NULL,1,'TEST-0001',NULL,1055.00,NULL,'2026-08-27 03:33:17',NULL,NULL,NULL,NULL,NULL),(11,1000.00,10,1.00,55.00,'APROBADO','2026-08-27 03:36:05',NULL,1,'TEST-0001',NULL,1055.00,NULL,'2026-08-27 03:36:05',NULL,NULL,NULL,NULL,NULL),(12,1000.00,10,1.00,55.00,'APROBADO','2026-08-28 02:29:31','2026-10-23 02:47:13',1,'PRE-2026-000012',NULL,1055.00,NULL,'2026-08-28 02:29:31',NULL,NULL,NULL,NULL,NULL),(13,1000.00,10,1.00,55.00,'APROBADO','2026-08-29 03:10:51','2026-10-23 02:49:09',1,'PRE-2026-000013',NULL,1055.00,NULL,'2026-08-29 03:10:51','2026-08-29 03:10:51',NULL,NULL,NULL,NULL),(14,1000.00,10,1.00,55.00,'APROBADO','2026-08-29 03:15:16','2026-10-19 02:17:04',1,'PRE-2026-000014',NULL,1055.00,NULL,'2026-08-29 03:15:16','2026-10-19 02:17:04','ADMINISTRADOR',NULL,NULL,NULL),(15,1000.00,10,12.00,660.00,'APROBADO','2026-10-25 17:10:57','2026-11-02 02:53:18',1,'PRE-2026-000015',NULL,1660.00,NULL,'2026-10-25 17:10:57','2026-10-25 17:10:57',NULL,NULL,NULL,NULL),(16,1000.00,2,12.00,180.00,'RECHAZADO','2026-10-25 21:18:19',NULL,1,'PRE-2026-000016',NULL,1180.00,NULL,'2026-10-25 21:18:19','2026-10-25 21:18:19',NULL,NULL,NULL,NULL),(17,1000.00,10,12.00,660.00,'APROBADO','2026-10-25 21:47:22','2026-11-02 02:50:16',1,'PRE-2026-000017',NULL,1660.00,NULL,'2026-10-25 21:47:22','2026-10-25 21:47:22',NULL,NULL,NULL,NULL),(18,200.00,2,12.00,36.00,'RECHAZADO','2026-10-25 21:49:37',NULL,3,'PRE-2026-000018',NULL,236.00,NULL,'2026-10-25 21:49:37','2026-10-25 21:49:37',NULL,NULL,NULL,NULL),(19,1000.00,4,12.00,300.00,'APROBADO','2026-10-25 22:14:13','2026-11-02 02:49:46',2,'PRE-2026-000019',NULL,1300.00,NULL,'2026-10-25 22:14:13','2026-10-25 22:14:13',NULL,NULL,NULL,NULL),(20,1000.00,5,12.00,360.00,'APROBADO','2026-10-25 22:21:34','2026-10-25 22:21:51',4,'PRE-2026-000020',NULL,1360.00,NULL,'2026-10-25 22:21:34','2026-10-25 22:21:34',NULL,NULL,NULL,NULL),(21,1000.00,10,12.00,660.00,'APROBADO','2026-11-02 02:56:23','2026-11-02 02:56:34',1,'PRE-2026-000021',NULL,1660.00,NULL,'2026-11-02 02:56:23','2026-11-02 02:56:23',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_installment`
--

DROP TABLE IF EXISTS `loan_installment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan_installment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `interest_amount` decimal(12,2) NOT NULL,
  `late_fee_amount` decimal(12,2) NOT NULL,
  `installment_amount` decimal(12,2) NOT NULL,
  `closing_balance` decimal(12,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `paid_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `installment_number` int NOT NULL,
  `due_date` date NOT NULL,
  `opening_balance` decimal(12,2) NOT NULL,
  `principal_amount` decimal(12,2) NOT NULL,
  `loan_id` int NOT NULL,
  `paid_amount` varchar(15) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `IDX_EFB6D589CE73868F` (`loan_id`),
  CONSTRAINT `FK_EFB6D589CE73868F` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan_installment`
--

LOCK TABLES `loan_installment` WRITE;
/*!40000 ALTER TABLE `loan_installment` DISABLE KEYS */;
INSERT INTO `loan_installment` VALUES (1,10.00,0.00,110.00,900.00,'PENDIENTE',NULL,'2026-08-27 03:16:27',NULL,1,'2026-09-30',1000.00,100.00,3,'0.00'),(2,9.00,0.00,109.00,800.00,'PENDIENTE',NULL,'2026-08-27 03:16:27',NULL,2,'2026-10-30',900.00,100.00,3,'0.00'),(3,8.00,0.00,108.00,700.00,'PENDIENTE',NULL,'2026-08-27 03:16:27',NULL,3,'2026-11-30',800.00,100.00,3,'0.00'),(4,7.00,0.00,107.00,600.00,'PENDIENTE',NULL,'2026-08-27 03:16:27',NULL,4,'2026-12-30',700.00,100.00,3,'0.00'),(5,6.00,0.00,106.00,500.00,'PENDIENTE',NULL,'2026-08-27 03:16:27',NULL,5,'2027-01-30',600.00,100.00,3,'0.00'),(6,5.00,0.00,105.00,400.00,'PENDIENTE',NULL,'2026-08-27 03:16:27',NULL,6,'2027-03-02',500.00,100.00,3,'0.00'),(7,4.00,0.00,104.00,300.00,'PENDIENTE',NULL,'2026-08-27 03:16:27',NULL,7,'2027-03-30',400.00,100.00,3,'0.00'),(8,3.00,0.00,103.00,200.00,'PENDIENTE',NULL,'2026-08-27 03:16:27',NULL,8,'2027-04-30',300.00,100.00,3,'0.00'),(9,2.00,0.00,102.00,100.00,'PENDIENTE',NULL,'2026-08-27 03:16:27',NULL,9,'2027-05-30',200.00,100.00,3,'0.00'),(10,1.00,0.00,101.00,0.00,'PENDIENTE',NULL,'2026-08-27 03:16:27',NULL,10,'2027-06-30',100.00,100.00,3,'0.00'),(11,10.00,0.00,110.00,900.00,'PENDIENTE',NULL,'2026-08-27 03:18:18',NULL,1,'2026-09-30',1000.00,100.00,4,'0.00'),(12,9.00,0.00,109.00,800.00,'PENDIENTE',NULL,'2026-08-27 03:18:18',NULL,2,'2026-10-30',900.00,100.00,4,'0.00'),(13,8.00,0.00,108.00,700.00,'PENDIENTE',NULL,'2026-08-27 03:18:18',NULL,3,'2026-11-30',800.00,100.00,4,'0.00'),(14,7.00,0.00,107.00,600.00,'PENDIENTE',NULL,'2026-08-27 03:18:18',NULL,4,'2026-12-30',700.00,100.00,4,'0.00'),(15,6.00,0.00,106.00,500.00,'PENDIENTE',NULL,'2026-08-27 03:18:18',NULL,5,'2027-01-30',600.00,100.00,4,'0.00'),(16,5.00,0.00,105.00,400.00,'PENDIENTE',NULL,'2026-08-27 03:18:18',NULL,6,'2027-03-02',500.00,100.00,4,'0.00'),(17,4.00,0.00,104.00,300.00,'PENDIENTE',NULL,'2026-08-27 03:18:18',NULL,7,'2027-03-30',400.00,100.00,4,'0.00'),(18,3.00,0.00,103.00,200.00,'PENDIENTE',NULL,'2026-08-27 03:18:18',NULL,8,'2027-04-30',300.00,100.00,4,'0.00'),(19,2.00,0.00,102.00,100.00,'PENDIENTE',NULL,'2026-08-27 03:18:18',NULL,9,'2027-05-30',200.00,100.00,4,'0.00'),(20,1.00,0.00,101.00,0.00,'PENDIENTE',NULL,'2026-08-27 03:18:18',NULL,10,'2027-06-30',100.00,100.00,4,'0.00'),(21,10.00,0.00,110.00,900.00,'PENDIENTE',NULL,'2026-08-27 03:20:34',NULL,1,'2026-09-30',1000.00,100.00,5,'0.00'),(22,9.00,0.00,109.00,800.00,'PENDIENTE',NULL,'2026-08-27 03:20:34',NULL,2,'2026-10-30',900.00,100.00,5,'0.00'),(23,8.00,0.00,108.00,700.00,'PENDIENTE',NULL,'2026-08-27 03:20:34',NULL,3,'2026-11-30',800.00,100.00,5,'0.00'),(24,7.00,0.00,107.00,600.00,'PENDIENTE',NULL,'2026-08-27 03:20:34',NULL,4,'2026-12-30',700.00,100.00,5,'0.00'),(25,6.00,0.00,106.00,500.00,'PENDIENTE',NULL,'2026-08-27 03:20:34',NULL,5,'2027-01-30',600.00,100.00,5,'0.00'),(26,5.00,0.00,105.00,400.00,'PENDIENTE',NULL,'2026-08-27 03:20:34',NULL,6,'2027-03-02',500.00,100.00,5,'0.00'),(27,4.00,0.00,104.00,300.00,'PENDIENTE',NULL,'2026-08-27 03:20:34',NULL,7,'2027-03-30',400.00,100.00,5,'0.00'),(28,3.00,0.00,103.00,200.00,'PENDIENTE',NULL,'2026-08-27 03:20:34',NULL,8,'2027-04-30',300.00,100.00,5,'0.00'),(29,2.00,0.00,102.00,100.00,'PENDIENTE',NULL,'2026-08-27 03:20:34',NULL,9,'2027-05-30',200.00,100.00,5,'0.00'),(30,1.00,0.00,101.00,0.00,'PENDIENTE',NULL,'2026-08-27 03:20:34',NULL,10,'2027-06-30',100.00,100.00,5,'0.00'),(31,10.00,0.00,110.00,900.00,'PENDIENTE',NULL,'2026-08-27 03:33:09','2026-08-27 03:33:09',1,'2026-09-30',1000.00,100.00,9,'0.00'),(32,9.00,0.00,109.00,800.00,'PENDIENTE',NULL,'2026-08-27 03:33:09','2026-08-27 03:33:09',2,'2026-10-30',900.00,100.00,9,'0.00'),(33,8.00,0.00,108.00,700.00,'PENDIENTE',NULL,'2026-08-27 03:33:09','2026-08-27 03:33:09',3,'2026-11-30',800.00,100.00,9,'0.00'),(34,7.00,0.00,107.00,600.00,'PENDIENTE',NULL,'2026-08-27 03:33:09','2026-08-27 03:33:09',4,'2026-12-30',700.00,100.00,9,'0.00'),(35,6.00,0.00,106.00,500.00,'PENDIENTE',NULL,'2026-08-27 03:33:09','2026-08-27 03:33:09',5,'2027-01-30',600.00,100.00,9,'0.00'),(36,5.00,0.00,105.00,400.00,'PENDIENTE',NULL,'2026-08-27 03:33:09','2026-08-27 03:33:09',6,'2027-02-28',500.00,100.00,9,'0.00'),(37,4.00,0.00,104.00,300.00,'PENDIENTE',NULL,'2026-08-27 03:33:09','2026-08-27 03:33:09',7,'2027-03-30',400.00,100.00,9,'0.00'),(38,3.00,0.00,103.00,200.00,'PENDIENTE',NULL,'2026-08-27 03:33:09','2026-08-27 03:33:09',8,'2027-04-30',300.00,100.00,9,'0.00'),(39,2.00,0.00,102.00,100.00,'PENDIENTE',NULL,'2026-08-27 03:33:09','2026-08-27 03:33:09',9,'2027-05-30',200.00,100.00,9,'0.00'),(40,1.00,0.00,101.00,0.00,'PENDIENTE',NULL,'2026-08-27 03:33:09','2026-08-27 03:33:09',10,'2027-06-30',100.00,100.00,9,'0.00'),(41,10.00,0.00,110.00,900.00,'PENDIENTE',NULL,'2026-08-27 03:33:17','2026-08-27 03:33:17',1,'2026-09-30',1000.00,100.00,10,'0.00'),(42,9.00,0.00,109.00,800.00,'PENDIENTE',NULL,'2026-08-27 03:33:17','2026-08-27 03:33:17',2,'2026-10-30',900.00,100.00,10,'0.00'),(43,8.00,0.00,108.00,700.00,'PENDIENTE',NULL,'2026-08-27 03:33:17','2026-08-27 03:33:17',3,'2026-11-30',800.00,100.00,10,'0.00'),(44,7.00,0.00,107.00,600.00,'PENDIENTE',NULL,'2026-08-27 03:33:17','2026-08-27 03:33:17',4,'2026-12-30',700.00,100.00,10,'0.00'),(45,6.00,0.00,106.00,500.00,'PENDIENTE',NULL,'2026-08-27 03:33:17','2026-08-27 03:33:17',5,'2027-01-30',600.00,100.00,10,'0.00'),(46,5.00,0.00,105.00,400.00,'PENDIENTE',NULL,'2026-08-27 03:33:17','2026-08-27 03:33:17',6,'2027-02-28',500.00,100.00,10,'0.00'),(47,4.00,0.00,104.00,300.00,'PENDIENTE',NULL,'2026-08-27 03:33:17','2026-08-27 03:33:17',7,'2027-03-30',400.00,100.00,10,'0.00'),(48,3.00,0.00,103.00,200.00,'PENDIENTE',NULL,'2026-08-27 03:33:17','2026-08-27 03:33:17',8,'2027-04-30',300.00,100.00,10,'0.00'),(49,2.00,0.00,102.00,100.00,'PENDIENTE',NULL,'2026-08-27 03:33:17','2026-08-27 03:33:17',9,'2027-05-30',200.00,100.00,10,'0.00'),(50,1.00,0.00,101.00,0.00,'PENDIENTE',NULL,'2026-08-27 03:33:17','2026-08-27 03:33:17',10,'2027-06-30',100.00,100.00,10,'0.00'),(51,10.00,0.00,110.00,900.00,'PENDIENTE',NULL,'2026-08-27 03:36:05','2026-08-27 03:36:05',1,'2026-09-30',1000.00,100.00,11,'0.00'),(52,9.00,0.00,109.00,800.00,'PENDIENTE',NULL,'2026-08-27 03:36:05','2026-08-27 03:36:05',2,'2026-10-30',900.00,100.00,11,'0.00'),(53,8.00,0.00,108.00,700.00,'PENDIENTE',NULL,'2026-08-27 03:36:05','2026-08-27 03:36:05',3,'2026-11-30',800.00,100.00,11,'0.00'),(54,7.00,0.00,107.00,600.00,'PENDIENTE',NULL,'2026-08-27 03:36:05','2026-08-27 03:36:05',4,'2026-12-30',700.00,100.00,11,'0.00'),(55,6.00,0.00,106.00,500.00,'PENDIENTE',NULL,'2026-08-27 03:36:05','2026-08-27 03:36:05',5,'2027-01-30',600.00,100.00,11,'0.00'),(56,5.00,0.00,105.00,400.00,'PENDIENTE',NULL,'2026-08-27 03:36:05','2026-08-27 03:36:05',6,'2027-02-28',500.00,100.00,11,'0.00'),(57,4.00,0.00,104.00,300.00,'PENDIENTE',NULL,'2026-08-27 03:36:05','2026-08-27 03:36:05',7,'2027-03-30',400.00,100.00,11,'0.00'),(58,3.00,0.00,103.00,200.00,'PENDIENTE',NULL,'2026-08-27 03:36:05','2026-08-27 03:36:05',8,'2027-04-30',300.00,100.00,11,'0.00'),(59,2.00,0.00,102.00,100.00,'PENDIENTE',NULL,'2026-08-27 03:36:05','2026-08-27 03:36:05',9,'2027-05-30',200.00,100.00,11,'0.00'),(60,1.00,0.00,101.00,0.00,'PENDIENTE',NULL,'2026-08-27 03:36:05','2026-08-27 03:36:05',10,'2027-06-30',100.00,100.00,11,'0.00'),(61,10.00,0.00,110.00,10.00,'PAGADO','2026-11-12 13:36:35','2026-08-29 03:10:51','2026-08-29 03:10:51',1,'2026-08-01',1000.00,100.00,13,'110.00'),(62,9.00,0.00,109.00,800.00,'PENDIENTE',NULL,'2026-08-29 03:10:51','2026-08-29 03:10:51',2,'2026-09-01',900.00,100.00,13,'0.00'),(63,8.00,0.00,108.00,700.00,'PENDIENTE',NULL,'2026-08-29 03:10:51','2026-08-29 03:10:51',3,'2026-10-01',800.00,100.00,13,'0.00'),(64,7.00,0.00,107.00,600.00,'PENDIENTE',NULL,'2026-08-29 03:10:51','2026-08-29 03:10:51',4,'2026-11-01',700.00,100.00,13,'0.00'),(65,6.00,0.00,106.00,500.00,'PENDIENTE',NULL,'2026-08-29 03:10:51','2026-08-29 03:10:51',5,'2026-12-01',600.00,100.00,13,'0.00'),(66,5.00,0.00,105.00,400.00,'PENDIENTE',NULL,'2026-08-29 03:10:51','2026-08-29 03:10:51',6,'2027-01-01',500.00,100.00,13,'0.00'),(67,4.00,0.00,104.00,300.00,'PENDIENTE',NULL,'2026-08-29 03:10:51','2026-08-29 03:10:51',7,'2027-02-01',400.00,100.00,13,'0.00'),(68,3.00,0.00,103.00,200.00,'PENDIENTE',NULL,'2026-08-29 03:10:51','2026-08-29 03:10:51',8,'2027-03-01',300.00,100.00,13,'0.00'),(69,2.00,0.00,102.00,100.00,'PENDIENTE',NULL,'2026-08-29 03:10:51','2026-08-29 03:10:51',9,'2027-04-01',200.00,100.00,13,'0.00'),(70,1.00,0.00,101.00,0.00,'PENDIENTE',NULL,'2026-08-29 03:10:51','2026-08-29 03:10:51',10,'2027-05-01',100.00,100.00,13,'0.00'),(71,10.00,0.00,110.00,900.00,'PENDIENTE',NULL,'2026-08-29 03:15:16','2026-08-29 03:15:16',1,'2026-08-01',1000.00,100.00,14,'0.00'),(72,9.00,0.00,109.00,800.00,'PENDIENTE',NULL,'2026-08-29 03:15:16','2026-08-29 03:15:16',2,'2026-09-01',900.00,100.00,14,'0.00'),(73,8.00,0.00,108.00,700.00,'PENDIENTE',NULL,'2026-08-29 03:15:16','2026-08-29 03:15:16',3,'2026-10-01',800.00,100.00,14,'0.00'),(74,7.00,0.00,107.00,600.00,'PENDIENTE',NULL,'2026-08-29 03:15:16','2026-08-29 03:15:16',4,'2026-11-01',700.00,100.00,14,'0.00'),(75,6.00,0.00,106.00,500.00,'PENDIENTE',NULL,'2026-08-29 03:15:16','2026-08-29 03:15:16',5,'2026-12-01',600.00,100.00,14,'0.00'),(76,5.00,0.00,105.00,400.00,'PENDIENTE',NULL,'2026-08-29 03:15:16','2026-08-29 03:15:16',6,'2027-01-01',500.00,100.00,14,'0.00'),(77,4.00,0.00,104.00,300.00,'PENDIENTE',NULL,'2026-08-29 03:15:16','2026-08-29 03:15:16',7,'2027-02-01',400.00,100.00,14,'0.00'),(78,3.00,0.00,103.00,200.00,'PENDIENTE',NULL,'2026-08-29 03:15:16','2026-08-29 03:15:16',8,'2027-03-01',300.00,100.00,14,'0.00'),(79,2.00,0.00,102.00,100.00,'PENDIENTE',NULL,'2026-08-29 03:15:16','2026-08-29 03:15:16',9,'2027-04-01',200.00,100.00,14,'0.00'),(80,1.00,0.00,101.00,0.00,'PENDIENTE',NULL,'2026-08-29 03:15:16','2026-08-29 03:15:16',10,'2027-05-01',100.00,100.00,14,'0.00'),(81,120.00,0.00,220.00,900.00,'PARCIAL',NULL,'2026-10-25 17:10:57','2026-10-25 17:10:57',1,'2026-11-25',1000.00,100.00,15,'100.00'),(82,108.00,0.00,208.00,800.00,'PENDIENTE',NULL,'2026-10-25 17:10:57','2026-10-25 17:10:57',2,'2026-12-25',900.00,100.00,15,'0.00'),(83,96.00,0.00,196.00,700.00,'PENDIENTE',NULL,'2026-10-25 17:10:57','2026-10-25 17:10:57',3,'2027-01-25',800.00,100.00,15,'0.00'),(84,84.00,0.00,184.00,600.00,'PENDIENTE',NULL,'2026-10-25 17:10:57','2026-10-25 17:10:57',4,'2027-02-25',700.00,100.00,15,'0.00'),(85,72.00,0.00,172.00,500.00,'PENDIENTE',NULL,'2026-10-25 17:10:57','2026-10-25 17:10:57',5,'2027-03-25',600.00,100.00,15,'0.00'),(86,60.00,0.00,160.00,400.00,'PENDIENTE',NULL,'2026-10-25 17:10:57','2026-10-25 17:10:57',6,'2027-04-25',500.00,100.00,15,'0.00'),(87,48.00,0.00,148.00,300.00,'PENDIENTE',NULL,'2026-10-25 17:10:57','2026-10-25 17:10:57',7,'2027-05-25',400.00,100.00,15,'0.00'),(88,36.00,0.00,136.00,200.00,'PENDIENTE',NULL,'2026-10-25 17:10:57','2026-10-25 17:10:57',8,'2027-06-25',300.00,100.00,15,'0.00'),(89,24.00,0.00,124.00,100.00,'PENDIENTE',NULL,'2026-10-25 17:10:57','2026-10-25 17:10:57',9,'2027-07-25',200.00,100.00,15,'0.00'),(90,12.00,0.00,112.00,0.00,'PENDIENTE',NULL,'2026-10-25 17:10:57','2026-10-25 17:10:57',10,'2027-08-25',100.00,100.00,15,'0.00'),(91,120.00,0.00,620.00,500.00,'PENDIENTE',NULL,'2026-10-25 21:18:19','2026-10-25 21:18:19',1,'2026-11-25',1000.00,500.00,16,'0.00'),(92,60.00,0.00,560.00,0.00,'PENDIENTE',NULL,'2026-10-25 21:18:19','2026-10-25 21:18:19',2,'2026-12-25',500.00,500.00,16,'0.00'),(93,120.00,0.00,220.00,120.00,'PARCIAL',NULL,'2026-10-25 21:47:22','2026-10-25 21:47:22',1,'2026-11-25',1000.00,100.00,17,'100.00'),(94,108.00,0.00,208.00,800.00,'PENDIENTE',NULL,'2026-10-25 21:47:22','2026-10-25 21:47:22',2,'2026-12-25',900.00,100.00,17,'0.00'),(95,96.00,0.00,196.00,700.00,'PENDIENTE',NULL,'2026-10-25 21:47:22','2026-10-25 21:47:22',3,'2027-01-25',800.00,100.00,17,'0.00'),(96,84.00,0.00,184.00,600.00,'PENDIENTE',NULL,'2026-10-25 21:47:22','2026-10-25 21:47:22',4,'2027-02-25',700.00,100.00,17,'0.00'),(97,72.00,0.00,172.00,500.00,'PENDIENTE',NULL,'2026-10-25 21:47:22','2026-10-25 21:47:22',5,'2027-03-25',600.00,100.00,17,'0.00'),(98,60.00,0.00,160.00,400.00,'PENDIENTE',NULL,'2026-10-25 21:47:22','2026-10-25 21:47:22',6,'2027-04-25',500.00,100.00,17,'0.00'),(99,48.00,0.00,148.00,300.00,'PENDIENTE',NULL,'2026-10-25 21:47:22','2026-10-25 21:47:22',7,'2027-05-25',400.00,100.00,17,'0.00'),(100,36.00,0.00,136.00,200.00,'PENDIENTE',NULL,'2026-10-25 21:47:22','2026-10-25 21:47:22',8,'2027-06-25',300.00,100.00,17,'0.00'),(101,24.00,0.00,124.00,100.00,'PENDIENTE',NULL,'2026-10-25 21:47:22','2026-10-25 21:47:22',9,'2027-07-25',200.00,100.00,17,'0.00'),(102,12.00,0.00,112.00,0.00,'PENDIENTE',NULL,'2026-10-25 21:47:22','2026-10-25 21:47:22',10,'2027-08-25',100.00,100.00,17,'0.00'),(103,24.00,0.00,124.00,100.00,'PENDIENTE',NULL,'2026-10-25 21:49:37','2026-10-25 21:49:37',1,'2026-11-25',200.00,100.00,18,'0.00'),(104,12.00,0.00,112.00,0.00,'PENDIENTE',NULL,'2026-10-25 21:49:37','2026-10-25 21:49:37',2,'2026-12-25',100.00,100.00,18,'0.00'),(105,120.00,0.00,370.00,750.00,'PENDIENTE',NULL,'2026-10-25 22:14:13','2026-10-25 22:14:13',1,'2026-11-25',1000.00,250.00,19,'0.00'),(106,90.00,0.00,340.00,500.00,'PENDIENTE',NULL,'2026-10-25 22:14:13','2026-10-25 22:14:13',2,'2026-12-25',750.00,250.00,19,'0.00'),(107,60.00,0.00,310.00,250.00,'PENDIENTE',NULL,'2026-10-25 22:14:13','2026-10-25 22:14:13',3,'2027-01-25',500.00,250.00,19,'0.00'),(108,30.00,0.00,280.00,0.00,'PENDIENTE',NULL,'2026-10-25 22:14:13','2026-10-25 22:14:13',4,'2027-02-25',250.00,250.00,19,'0.00'),(109,120.00,0.00,320.00,800.00,'PENDIENTE',NULL,'2026-10-25 22:21:34','2026-10-25 22:21:34',1,'2026-11-25',1000.00,200.00,20,'0.00'),(110,96.00,0.00,296.00,600.00,'PENDIENTE',NULL,'2026-10-25 22:21:34','2026-10-25 22:21:34',2,'2026-12-25',800.00,200.00,20,'0.00'),(111,72.00,0.00,272.00,400.00,'PENDIENTE',NULL,'2026-10-25 22:21:34','2026-10-25 22:21:34',3,'2027-01-25',600.00,200.00,20,'0.00'),(112,48.00,0.00,248.00,200.00,'PENDIENTE',NULL,'2026-10-25 22:21:34','2026-10-25 22:21:34',4,'2027-02-25',400.00,200.00,20,'0.00'),(113,24.00,0.00,224.00,0.00,'PENDIENTE',NULL,'2026-10-25 22:21:34','2026-10-25 22:21:34',5,'2027-03-25',200.00,200.00,20,'0.00'),(114,120.00,0.00,220.00,900.00,'PARCIAL',NULL,'2026-11-02 02:56:23','2026-11-02 02:56:23',1,'2026-12-02',1000.00,100.00,21,'200.00'),(115,108.00,0.00,208.00,800.00,'PENDIENTE',NULL,'2026-11-02 02:56:23','2026-11-02 02:56:23',2,'2027-01-02',900.00,100.00,21,'0.00'),(116,96.00,0.00,196.00,700.00,'PENDIENTE',NULL,'2026-11-02 02:56:23','2026-11-02 02:56:23',3,'2027-02-02',800.00,100.00,21,'0.00'),(117,84.00,0.00,184.00,600.00,'PENDIENTE',NULL,'2026-11-02 02:56:23','2026-11-02 02:56:23',4,'2027-03-02',700.00,100.00,21,'0.00'),(118,72.00,0.00,172.00,500.00,'PENDIENTE',NULL,'2026-11-02 02:56:23','2026-11-02 02:56:23',5,'2027-04-02',600.00,100.00,21,'0.00'),(119,60.00,0.00,160.00,400.00,'PENDIENTE',NULL,'2026-11-02 02:56:23','2026-11-02 02:56:23',6,'2027-05-02',500.00,100.00,21,'0.00'),(120,48.00,0.00,148.00,300.00,'PENDIENTE',NULL,'2026-11-02 02:56:23','2026-11-02 02:56:23',7,'2027-06-02',400.00,100.00,21,'0.00'),(121,36.00,0.00,136.00,200.00,'PENDIENTE',NULL,'2026-11-02 02:56:23','2026-11-02 02:56:23',8,'2027-07-02',300.00,100.00,21,'0.00'),(122,24.00,0.00,124.00,100.00,'PENDIENTE',NULL,'2026-11-02 02:56:23','2026-11-02 02:56:23',9,'2027-08-02',200.00,100.00,21,'0.00'),(123,12.00,0.00,112.00,0.00,'PENDIENTE',NULL,'2026-11-02 02:56:23','2026-11-02 02:56:23',10,'2027-09-02',100.00,100.00,21,'0.00');
/*!40000 ALTER TABLE `loan_installment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0E3BD61CE16BA31DBBF396750` (`queue_name`,`available_at`,`delivered_at`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messenger_messages`
--

LOCK TABLES `messenger_messages` WRITE;
/*!40000 ALTER TABLE `messenger_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messenger_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthly_balance_log`
--

DROP TABLE IF EXISTS `monthly_balance_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monthly_balance_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `base_capital` decimal(10,2) NOT NULL,
  `new_deposits` decimal(10,2) NOT NULL,
  `applied_rate` decimal(5,2) NOT NULL,
  `earned_interest` decimal(10,2) NOT NULL,
  `total_accumulated` decimal(10,2) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_813C5553A76ED395` (`user_id`),
  CONSTRAINT `FK_813C5553A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monthly_balance_log`
--

LOCK TABLES `monthly_balance_log` WRITE;
/*!40000 ALTER TABLE `monthly_balance_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `monthly_balance_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reset_password_request`
--

DROP TABLE IF EXISTS `reset_password_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reset_password_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `selector` varchar(20) NOT NULL,
  `hashed_token` varchar(100) NOT NULL,
  `requested_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7CE748AA76ED395` (`user_id`),
  CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reset_password_request`
--

LOCK TABLES `reset_password_request` WRITE;
/*!40000 ALTER TABLE `reset_password_request` DISABLE KEYS */;
INSERT INTO `reset_password_request` VALUES (1,'dv8JbxZ72V1KRRuHQdSL','F4mi9QaB42H3LInAft4ldzslvpBYho3ybtY0Buk2cUw=','2026-08-14 20:40:03','2026-08-14 21:40:03',1),(2,'4ZcfHGlWMF0yW647Bz5T','05bdRJetNVKse23sJfDKMocfm3ho8+U2DkKqneHon/w=','2026-08-15 12:41:36','2026-08-15 13:41:36',1);
/*!40000 ALTER TABLE `reset_password_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_config`
--

DROP TABLE IF EXISTS `system_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `config_key` varchar(100) NOT NULL,
  `config_value` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C4049ABD95D1CAA6` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_config`
--

LOCK TABLES `system_config` WRITE;
/*!40000 ALTER TABLE `system_config` DISABLE KEYS */;
INSERT INTO `system_config` VALUES (1,'site_title','Caja de Ahorro Familiar'),(2,'hero_subtitle','Construyendo un futuro financiero sólido y seguro.'),(3,'about_us_text','Nuestra Caja de Ahorro Familiar se creó el 28 de junio del 2026, con la finalidad de fomentar el ahorro sistemático y ofrecer soluciones de crédito accesibles a todos los socios familiares.'),(4,'contact_info','Atención de Lunes a Viernes: 08:00 - 17:00 | Teléfono: 0991234567'),(5,'hero_banner','banner-familia-6a8063352eec9.jpg'),(6,'logo','logo-chiribank-6a8061f0048b1.png'),(7,'interest_cutoff_day','30'),(8,'interest_eligibility_rule','PREVIOUS_MONTH'),(9,'interest_auto_generation','1'),(10,'interest_accrual_mode','MONTHLY_CYCLE');
/*!40000 ALTER TABLE `system_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `account_id` int NOT NULL,
  `transaction_date` date DEFAULT NULL,
  `effective_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_723705D19B6B5FBA` (`account_id`),
  CONSTRAINT `FK_723705D19B6B5FBA` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,'DEPOSIT',100.00,'101-Aporte ordinario','2026-08-17 00:37:27',9,'2026-06-27','2026-06-28'),(2,'DEPOSIT',1000.00,'Desembolso por Aprobación de Préstamo #12','2026-10-23 02:47:13',1,'2026-10-23','2026-10-28'),(3,'DEPOSIT',1000.00,'Desembolso por Aprobación de Préstamo #13','2026-10-23 02:49:09',1,'2026-10-23','2026-10-28'),(4,'DEPOSIT',1000.00,'Desembolso por Aprobación de Préstamo #20','2026-10-25 22:21:51',4,'2026-10-25','2026-10-28'),(5,'DEPOSIT',1000.00,'Desembolso por Aprobación de Préstamo #19','2026-11-02 02:49:46',2,'2026-11-02','2026-11-28'),(6,'DEPOSIT',1000.00,'Desembolso por Aprobación de Préstamo #17','2026-11-02 02:50:16',1,'2026-11-02','2026-11-28'),(7,'DEPOSIT',1000.00,'Desembolso por Aprobación de Préstamo #15','2026-11-02 02:53:18',1,'2026-11-02','2026-11-28'),(8,'DEPOSIT',1000.00,'Desembolso por Aprobación de Préstamo #21','2026-11-02 02:56:34',1,'2026-11-02','2026-11-28'),(9,'DEPOSIT',100.00,'301-Pago cuota préstamo','2026-11-02 04:50:38',1,'2026-11-01','2026-11-28'),(10,'DEPOSIT',10.00,'301-Pago cuota préstamo','2026-11-07 03:13:49',1,'2026-10-25','2026-10-28'),(11,'DEPOSIT',100.00,'301-Pago cuota préstamo','2026-11-07 04:38:25',1,'2026-11-07','2026-11-28'),(12,'DEPOSIT',100.00,'301-Pago cuota préstamo','2026-11-07 12:28:12',1,'2026-11-07','2026-11-28'),(13,'DEPOSIT',100.00,'301-Pago cuota préstamo','2026-11-07 12:35:41',1,'2026-08-29','2026-08-28'),(14,'DEPOSIT',100.00,'301-Pago cuota préstamo','2026-11-10 17:05:10',1,'2026-11-10','2026-11-28'),(15,'DEPOSIT',100.00,'301-Pago cuota préstamo','2026-11-11 14:01:43',1,'2026-11-11','2026-11-28'),(16,'DEPOSIT',100.00,'301-Pago cuota préstamo','2026-11-12 13:20:19',1,'2026-11-12','2026-11-28'),(17,'DEPOSIT',109.00,'301-Pago cuota préstamo','2026-11-12 13:36:35',1,'2026-11-12','2026-11-28'),(18,'DEPOSIT',100.00,'301-Pago cuota préstamo','2026-11-12 13:56:57',1,'2026-11-12','2026-11-28'),(19,'DEPOSIT',100.00,'301-Pago cuota préstamo','2026-11-12 17:35:41',1,'2026-11-12','2026-11-28');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `identification_number` varchar(20) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`),
  UNIQUE KEY `UNIQ_8D93D649347639A5` (`identification_number`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'chiribanks@gmail.com','[\"ROLE_ADMIN\"]','$2y$13$TWbJbp9fDIRKYfTWish4C.Hewmb8IsZO7m6Vy7Py2N/9GSMdFzJ1u','Administrador','Principal','9999999999','0999999999'),(2,'murdiales.ecu@gmail.com','[\"ROLE_USER\"]','$2y$13$vUl6AKwSGa5ypFeJhQ/d.esAnyURZL6Ja8nUkDXucTp.0y.UP5IAy','Marco Vinicio','Urdiales Reinoso','1710525195',NULL),(3,'guarderia_quito@yahoo.com','[\"ROLE_USER\"]','$2y$13$CvT/yM8FJp/bMZMCu3FNxux2dt05yWeE2vY73.SN/8/SF.S2uXpqK','Ruth Estela','Pinto Pinto','1714882949',NULL),(4,'jesireeabadia@gmail.com','[\"ROLE_USER\"]','$2y$13$cDTZ2U5/H7mu73T8ZtDOZORLYmAMBEK3uCbvh/CCDeDi6pNPTNo5q','Jesiree','Abadia Cisneros','1758299372',NULL),(5,'maferedyfer@gmail.com','[\"ROLE_USER\"]','$2y$13$2LtyF48YqGnZySYAZXSDo.wJLMHaZDFEX6QFzW.WZ/t1EuRSkxIau','María Fernanda','Cedeño Fernández','1312275181',NULL),(6,'diazdolore83@gmail.com','[\"ROLE_USER\"]','$2y$13$yoxZJyFAhbMjJobujk7nsO.3CTx4Ye9t0N71fuXK2uyZP5m8.fnEO','Luis Robinson','Pinto Pinto','1718940750',NULL),(7,'ep_pinto@hotmail.com','[\"ROLE_USER\"]','$2y$13$bG5VtH1tkysArt3FIdMGNOBdWcrB.3Zettnfj6EKk5azuJ7T1jzEi','Edison Edmundo','Pinto Pinto','1721112223',NULL),(8,'katygeo1408@gmail.com','[\"ROLE_USER\"]','$2y$13$OJ/BmtbQX.BAO0QtROlPUORI7/c5CS2UshMxDufT1D94b4mUb3rma','Katy Geovanna','Pinto Pinto','1717443723',NULL),(9,'d4vidpinto1313@gmail.com','[\"ROLE_USER\"]','$2y$13$p.RdDzBbwCGbWaAztIhTy.tLBblUdiYpMu9vRCI/oyrOrWHV7m3fq','David Alexander','Pinto Pinto','1725373300',NULL),(10,'murdiales_ecu@hotmail.com','[\"ROLE_USER\"]','$2y$13$Ebg4yHQEK4Npb9FSmAAkQeLNK3o5sWUAXVK6IR5Obyvz8p0ohTk6i','Prueba','Sistema','1710525196',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-12 12:40:18
