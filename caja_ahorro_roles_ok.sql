-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: caja_ahorro_db
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.3

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'CTA-26065195',0.00,'ACTIVE','2026-06-28 00:00:00',2),(2,'CTA-26062949',0.00,'ACTIVE','2026-06-28 00:00:00',3),(3,'CTA-26069372',0.00,'ACTIVE','2026-06-28 00:00:00',4),(4,'CTA-26065181',0.00,'ACTIVE','2026-06-28 00:00:00',5),(5,'CTA-26060750',0.00,'ACTIVE','2026-06-28 00:00:00',6),(6,'CTA-26062223',0.00,'ACTIVE','2026-06-28 00:00:00',7),(7,'CTA-26063723',0.00,'ACTIVE','2026-06-28 00:00:00',8),(8,'CTA-26063300',0.00,'ACTIVE','2026-06-28 00:00:00',9);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_log`
--

LOCK TABLES `email_log` WRITE;
/*!40000 ALTER TABLE `email_log` DISABLE KEYS */;
INSERT INTO `email_log` VALUES (1,'murdiales.ecu@gmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Marco Vinicio Urdiales Reinoso</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26065195</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 12:45:08'),(2,'guarderia_quito@yahoo.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Ruth Estela Pinto Pinto</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26062949</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 12:47:02'),(3,'jesireeabadia@gmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Jesiree Abadia Cisneros</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26069372</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:08:33'),(4,'maferedyfer@gmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>María Fernanda Cedeño Fernández</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26065181</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:09:31'),(5,'diazdolore83@gmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Luis Robinson Pinto Pinto</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26060750</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:10:32'),(6,'ep_pinto@hotmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Edison Edmundo Pinto Pinto</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26062223</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:11:38'),(7,'katygeo1408@gmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>Katy Geovanna Pinto Pinto</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26063723</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:14:26'),(8,'d4vidpinto@gmail.com','Bienvenido a la Caja de Ahorro - Activación de Cuenta','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>David Alexander Pinto Pinto</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26063300</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:15:29'),(9,'d4vidpinto1313@gmail.com','Caja de Ahorro - Notificación de Accesos','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>David Alexander Pinto Pinto</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26063300</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 22:30:24'),(10,'maferedyfer@gmail.com','Caja de Ahorro - Notificación de Accesos','<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n    <meta charset=\"UTF-8\">\n    <style>\n        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; color: #333; }\n        .container { max-width: 600px; background: #ffffff; margin: 0 auto; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }\n        .header { background-color: #0d6efd; color: #ffffff; text-align: center; padding: 15px; border-radius: 6px; }\n        .content { margin-top: 20px; line-height: 1.6; }\n        .account-box { background-color: #e9ecef; border-left: 5px solid #0d6efd; padding: 15px; margin: 20px 0; font-size: 16px; }\n        .btn { display: inline-block; background-color: #198754; color: #ffffff !important; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px; }\n        .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <div class=\"header\">\n            <h2 style=\"margin: 0;\">🏦 Caja de Ahorro</h2>\n        </div>\n\n        <div class=\"content\">\n            <p>Estimado(a) <strong>María Fernanda Cedeño Fernández</strong>,</p>\n\n            <p>Le damos una cordial bienvenida a nuestro sistema de <strong>Caja de Ahorro</strong>. Su usuario ha sido registrado exitosamente.</p>\n\n            <div class=\"account-box\">\n                <strong>📌 Su Número de Cuenta de Ahorros asignado es:</strong><br>\n                <span style=\"font-size: 22px; font-weight: bold; color: #0d6efd;\">CTA-26065181</span>\n            </div>\n\n            <p>Para garantizar la seguridad de su cuenta, le solicitamos establecer su contraseña personal haciendo clic en el siguiente enlace:</p>\n\n            <div style=\"text-align: center;\">\n                <a href=\"https://caja.benditotrabajo.com/login\" class=\"btn\">Establecer / Cambiar mi Contraseña</a>\n            </div>\n\n            <p style=\"margin-top: 25px; font-size: 13px; color: #555;\">\n                Si el botón anterior no funciona, copie y pegue el siguiente enlace en su navegador:<br>\n                <code>https://caja.benditotrabajo.com/login</code>\n            </p>\n        </div>\n\n        <div class=\"footer\">\n            Este es un correo automático generado por el Sistema de Caja de Ahorro. Por favor no responda a este mensaje.\n        </div>\n    </div>\n</body>\n</html>','ENVIADO','2026-08-15 23:21:01');
/*!40000 ALTER TABLE `email_log` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interest_rate_config`
--

LOCK TABLES `interest_rate_config` WRITE;
/*!40000 ALTER TABLE `interest_rate_config` DISABLE KEYS */;
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
  `monthly_fee` decimal(12,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `requested_at` datetime NOT NULL,
  `approved_at` datetime DEFAULT NULL,
  `account_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C5D30D039B6B5FBA` (`account_id`),
  CONSTRAINT `FK_C5D30D039B6B5FBA` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_config`
--

LOCK TABLES `system_config` WRITE;
/*!40000 ALTER TABLE `system_config` DISABLE KEYS */;
INSERT INTO `system_config` VALUES (1,'site_title','Caja de Ahorro Familiar'),(2,'hero_subtitle','Construyendo un futuro financiero sólido y seguro.'),(3,'about_us_text','Nuestra Caja de Ahorro Familiar se creó el 28 de junio del 2026, con la finalidad de fomentar el ahorro sistemático y ofrecer soluciones de crédito accesibles a todos los socios familiares.'),(4,'contact_info','Atención de Lunes a Viernes: 08:00 - 17:00 | Teléfono: 0991234567'),(5,'hero_banner','banner-familia-6a8063352eec9.jpg'),(6,'logo','logo-chiribank-6a8061f0048b1.png');
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
  PRIMARY KEY (`id`),
  KEY `IDX_723705D19B6B5FBA` (`account_id`),
  CONSTRAINT `FK_723705D19B6B5FBA` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'chiribanks@gmail.com','[\"ROLE_ADMIN\"]','$2y$13$TWbJbp9fDIRKYfTWish4C.Hewmb8IsZO7m6Vy7Py2N/9GSMdFzJ1u','Administrador','Principal','9999999999','0999999999'),(2,'murdiales.ecu@gmail.com','[\"ROLE_USER\"]','$2y$13$vUl6AKwSGa5ypFeJhQ/d.esAnyURZL6Ja8nUkDXucTp.0y.UP5IAy','Marco Vinicio','Urdiales Reinoso','1710525195',NULL),(3,'guarderia_quito@yahoo.com','[\"ROLE_USER\"]','$2y$13$CvT/yM8FJp/bMZMCu3FNxux2dt05yWeE2vY73.SN/8/SF.S2uXpqK','Ruth Estela','Pinto Pinto','1714882949',NULL),(4,'jesireeabadia@gmail.com','[\"ROLE_USER\"]','$2y$13$cDTZ2U5/H7mu73T8ZtDOZORLYmAMBEK3uCbvh/CCDeDi6pNPTNo5q','Jesiree','Abadia Cisneros','1758299372',NULL),(5,'maferedyfer@gmail.com','[\"ROLE_USER\"]','$2y$13$4zyObIKTc6UWeGYMkt/DmeHPnEssWdoa1LvlxpAHhgyxbZKOnVCgm','María Fernanda','Cedeño Fernández','1312275181',NULL),(6,'diazdolore83@gmail.com','[\"ROLE_USER\"]','$2y$13$yoxZJyFAhbMjJobujk7nsO.3CTx4Ye9t0N71fuXK2uyZP5m8.fnEO','Luis Robinson','Pinto Pinto','1718940750',NULL),(7,'ep_pinto@hotmail.com','[\"ROLE_USER\"]','$2y$13$bG5VtH1tkysArt3FIdMGNOBdWcrB.3Zettnfj6EKk5azuJ7T1jzEi','Edison Edmundo','Pinto Pinto','1721112223',NULL),(8,'katygeo1408@gmail.com','[\"ROLE_USER\"]','$2y$13$OJ/BmtbQX.BAO0QtROlPUORI7/c5CS2UshMxDufT1D94b4mUb3rma','Katy Geovanna','Pinto Pinto','1717443723',NULL),(9,'d4vidpinto1313@gmail.com','[\"ROLE_USER\"]','$2y$13$p.RdDzBbwCGbWaAztIhTy.tLBblUdiYpMu9vRCI/oyrOrWHV7m3fq','David Alexander','Pinto Pinto','1725373300',NULL);
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

-- Dump completed on 2026-08-16 16:16:11
