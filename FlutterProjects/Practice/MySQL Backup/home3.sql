-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: flutter
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `advancesalaries`
--

DROP TABLE IF EXISTS `advancesalaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advancesalaries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `advance_amount` double NOT NULL,
  `advance_date` datetime(6) DEFAULT NULL,
  `is_paid` bit(1) NOT NULL,
  `paid_date` datetime(6) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `status` enum('APPROVED','PENDING','REJECTED') DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK406b69k38mx9uqob0iqh0dgo9` (`user_id`),
  CONSTRAINT `FK406b69k38mx9uqob0iqh0dgo9` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advancesalaries`
--

LOCK TABLES `advancesalaries` WRITE;
/*!40000 ALTER TABLE `advancesalaries` DISABLE KEYS */;
INSERT INTO `advancesalaries` VALUES (1,50000,'2024-11-21 09:43:12.223018',_binary '\0','2024-11-21 09:37:20.000000','Need','PENDING',3),(2,50000,'2024-11-21 09:43:42.445915',_binary '\0','2024-11-21 09:37:20.000000','Need','PENDING',3),(3,50000,'2024-11-21 09:44:41.052500',_binary '\0','2024-11-21 09:37:20.000000','Test','PENDING',3),(4,50000,'2024-11-21 10:08:09.631927',_binary '\0',NULL,'Test','PENDING',3);
/*!40000 ALTER TABLE `advancesalaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendances`
--

DROP TABLE IF EXISTS `attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendances` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `clock_in_time` datetime(6) DEFAULT NULL,
  `clock_out_time` datetime(6) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `late_check_in` bit(1) NOT NULL,
  `overtime_hours` double NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `over_time` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8o39cn3ghqwhccyrrqdesttr8` (`user_id`),
  KEY `FKtpdqb66gqhyi6wh42expj3sjh` (`over_time`),
  CONSTRAINT `FK8o39cn3ghqwhccyrrqdesttr8` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKtpdqb66gqhyi6wh42expj3sjh` FOREIGN KEY (`over_time`) REFERENCES `salaries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendances`
--

LOCK TABLES `attendances` WRITE;
/*!40000 ALTER TABLE `attendances` DISABLE KEYS */;
INSERT INTO `attendances` VALUES (2,'2024-11-21 10:21:53.815745',NULL,'2024-11-21',_binary '',0,3,NULL);
/*!40000 ALTER TABLE `attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bonuses`
--

DROP TABLE IF EXISTS `bonuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bonuses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bonus_amount` double NOT NULL,
  `bonus_date` datetime(6) DEFAULT NULL,
  `bonus_type` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `bonus_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbyghp6xxmqc4lnkoup4fsqhie` (`user_id`),
  KEY `FK19afokt49hc8b618wyjnty1x5` (`bonus_id`),
  CONSTRAINT `FK19afokt49hc8b618wyjnty1x5` FOREIGN KEY (`bonus_id`) REFERENCES `salaries` (`id`),
  CONSTRAINT `FKbyghp6xxmqc4lnkoup4fsqhie` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bonuses`
--

LOCK TABLES `bonuses` WRITE;
/*!40000 ALTER TABLE `bonuses` DISABLE KEYS */;
INSERT INTO `bonuses` VALUES (1,5000,'2024-11-21 09:35:33.000000','ANNUAL',3,NULL);
/*!40000 ALTER TABLE `bonuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaves`
--

DROP TABLE IF EXISTS `leaves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leaves` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `duration` int NOT NULL,
  `end_date` date DEFAULT NULL,
  `leave_type` enum('RESERVE','SICK','UNPAID') DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `request_date` datetime(6) DEFAULT NULL,
  `request_status` enum('APPROVED','PENDING','REJECTED') DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `leave_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKa3vfaevh5a44ccfq2wodxoxig` (`user_id`),
  KEY `FKqwhp573r0inihx6o3x48gjujk` (`leave_id`),
  CONSTRAINT `FKa3vfaevh5a44ccfq2wodxoxig` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKqwhp573r0inihx6o3x48gjujk` FOREIGN KEY (`leave_id`) REFERENCES `salaries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaves`
--

LOCK TABLES `leaves` WRITE;
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
INSERT INTO `leaves` VALUES (1,2,'2024-11-23','SICK','Feaver','2024-11-21 09:39:34.000000','PENDING','2024-11-22',3,NULL);
/*!40000 ALTER TABLE `leaves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_token`
--

DROP TABLE IF EXISTS `password_reset_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_token` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `expiry_date` datetime(6) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKf90ivichjaokvmovxpnlm5nin` (`user_id`),
  CONSTRAINT `FK83nsrttkwkb6ym0anu051mtxn` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_token`
--

LOCK TABLES `password_reset_token` WRITE;
/*!40000 ALTER TABLE `password_reset_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salaries`
--

DROP TABLE IF EXISTS `salaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salaries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `net_salary` double NOT NULL,
  `payment_date` datetime(6) DEFAULT NULL,
  `provident_fund` double NOT NULL,
  `salary_status` varchar(255) DEFAULT NULL,
  `tax` double NOT NULL,
  `advance_salary_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3500lw10qxryuigl4yu3ymc7t` (`advance_salary_id`),
  KEY `FKos57j8u42tdn3d132be45fsh9` (`user_id`),
  CONSTRAINT `FK3500lw10qxryuigl4yu3ymc7t` FOREIGN KEY (`advance_salary_id`) REFERENCES `advancesalaries` (`id`),
  CONSTRAINT `FKos57j8u42tdn3d132be45fsh9` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salaries`
--

LOCK TABLES `salaries` WRITE;
/*!40000 ALTER TABLE `salaries` DISABLE KEYS */;
INSERT INTO `salaries` VALUES (2,500000,'2024-11-21 09:36:26.000000',5000,'PAID',500,1,3);
/*!40000 ALTER TABLE `salaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_logged_out` bit(1) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKj8rfw4x0wjjyibfqq566j4qng` (`user_id`),
  CONSTRAINT `FKj8rfw4x0wjjyibfqq566j4qng` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhZEBtYWlsLmNvbSIsInJvbGUiOiJBRE1JTiIsImlhdCI6MTczMjEyNDI5NiwiZXhwIjoxNzMyMjEwNjk2fQ.TQYFkEI5ImLaDpo2VzLU14NAlSwXCa4oUfq2eCjeast58RiyoR13DDuhUjfdtw7J',3),(2,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzIxNTk1MzksImV4cCI6MTczMjI0NTkzOX0.yp_lb-h0WJ12g6QiYyru6R0-Hl95vuZE6Oi-eb2syf17PgIyd1ubkA0NTjjME-0F',3);
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_leave_balance`
--

DROP TABLE IF EXISTS `user_leave_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_leave_balance` (
  `user_id` bigint NOT NULL,
  `remaining_days` int DEFAULT NULL,
  `leave_type` tinyint NOT NULL,
  PRIMARY KEY (`user_id`,`leave_type`),
  CONSTRAINT `FKt31asw9okd6rxehiimfqeohx5` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_leave_balance_chk_1` CHECK ((`leave_type` between 0 and 2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_leave_balance`
--

LOCK TABLES `user_leave_balance` WRITE;
/*!40000 ALTER TABLE `user_leave_balance` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_leave_balance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` bit(1) NOT NULL,
  `address` varchar(255) NOT NULL,
  `basic_salary` double NOT NULL,
  `cell` varchar(255) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `is_lock` bit(1) DEFAULT NULL,
  `joined_date` date DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile_photo` varchar(255) NOT NULL,
  `role` enum('ADMIN','EMPLOYEE','MANAGER') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK3wfgv34acy32imea493ekogs5` (`cell`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,_binary '','ad',50000,'0170000000','2008-11-06','ad@mail.com','Male',_binary '\0','2024-11-20','Tamim','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731406440540_upload.jpg','ADMIN'),(2,_binary '','ad',50000,'0170000001','2008-11-06','man@mail.com','Male',_binary '\0','2024-11-20','Ahmed','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731406440540_upload.jpg','MANAGER'),(3,_binary '','ad',50000,'0170000002','2008-11-02','emp@mail.com','Male',_binary '\0','2024-11-20','Raju','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731406440540_upload.jpg','EMPLOYEE');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-21 10:48:13
