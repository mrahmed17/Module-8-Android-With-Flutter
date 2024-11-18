-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: flutter
-- ------------------------------------------------------
-- Server version	8.0.37

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
  `advance_date` datetime(6) DEFAULT NULL,
  `advance_salary` double NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK406b69k38mx9uqob0iqh0dgo9` (`user_id`),
  CONSTRAINT `FK406b69k38mx9uqob0iqh0dgo9` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advancesalaries`
--

LOCK TABLES `advancesalaries` WRITE;
/*!40000 ALTER TABLE `advancesalaries` DISABLE KEYS */;
INSERT INTO `advancesalaries` VALUES (1,'2024-11-18 17:11:54.000000',50000,'SICK',3);
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
  `user_id` bigint NOT NULL,
  `over_time` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8o39cn3ghqwhccyrrqdesttr8` (`user_id`),
  KEY `FKtpdqb66gqhyi6wh42expj3sjh` (`over_time`),
  CONSTRAINT `FK8o39cn3ghqwhccyrrqdesttr8` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKtpdqb66gqhyi6wh42expj3sjh` FOREIGN KEY (`over_time`) REFERENCES `salaries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendances`
--

LOCK TABLES `attendances` WRITE;
/*!40000 ALTER TABLE `attendances` DISABLE KEYS */;
INSERT INTO `attendances` VALUES (1,'2024-11-18 17:12:26.000000','2024-11-18 22:12:28.000000','2024-11-18',3,NULL);
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
INSERT INTO `bonuses` VALUES (1,10000,'2024-11-18 17:20:17.000000',3,NULL);
/*!40000 ALTER TABLE `bonuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `branch_image` varchar(255) DEFAULT NULL,
  `cell` varchar(15) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKf2bbhy5pf3d7oqjc1ms90ncbr` (`cell`),
  UNIQUE KEY `UKko4isjnlqhfiubc4n3s5s2dfn` (`email`),
  UNIQUE KEY `UKhw68nd07qk3jrjfg70qxq9vb7` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,'adf','1731406440540_upload.jpg','012456456887','2024-11-18 17:21:16.000000','jlkajdfs@mail.com','adf','2024-11-18 17:21:29.000000');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cell` varchar(15) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `dep_image` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `employee_count` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `branch_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKd1glnk4tfjhab26gu0tucr5ax` (`cell`),
  UNIQUE KEY `UKddtdaeberog13f5n9tjtsabak` (`email`),
  UNIQUE KEY `UKj6cwks7xecs5jov19ro8ge3qk` (`name`),
  KEY `FKa1wtn2bsud212rdljgsc6xnb1` (`branch_id`),
  CONSTRAINT `FKa1wtn2bsud212rdljgsc6xnb1` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'01234567890','2024-11-18 17:22:28.000000','1731406440540_upload.jpg','jaklfj@mail.com',50,'afas','2024-11-18 17:22:50.000000',1);
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaves`
--

DROP TABLE IF EXISTS `leaves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leaves` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `end_date` date DEFAULT NULL,
  `leave_type` enum('RESERVE','SICK','UNPAID') DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `remaining_leave` int NOT NULL,
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
INSERT INTO `leaves` VALUES (1,'2024-11-21','SICK','Fever',22,'2024-11-18 17:23:44.000000','PENDING','2024-11-18',3,NULL);
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
-- Table structure for table `payslips`
--

DROP TABLE IF EXISTS `payslips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payslips` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `billing_date` datetime(6) NOT NULL,
  `payment_method` varchar(20) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `total_amount` double NOT NULL,
  `manager_id` bigint NOT NULL,
  `employee_id` bigint NOT NULL,
  `salary_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKid8vrvlhpmdybo33e1unr3rvg` (`salary_id`),
  KEY `FKcrn1yonlws3c5mau8ld26dqrl` (`manager_id`),
  KEY `FK3u2q4cfpg7d9feubiw2p8dhig` (`employee_id`),
  CONSTRAINT `FK3u2q4cfpg7d9feubiw2p8dhig` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKcrn1yonlws3c5mau8ld26dqrl` FOREIGN KEY (`manager_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKrpi4oh4l06t97t27cb0l7raqn` FOREIGN KEY (`salary_id`) REFERENCES `salaries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payslips`
--

LOCK TABLES `payslips` WRITE;
/*!40000 ALTER TABLE `payslips` DISABLE KEYS */;
INSERT INTO `payslips` VALUES (2,'2024-11-18 17:24:36.000000','CASH','PAID',50000,2,3,1);
/*!40000 ALTER TABLE `payslips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salaries`
--

DROP TABLE IF EXISTS `salaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salaries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `domestic_allowance` double NOT NULL,
  `insurance` double NOT NULL,
  `lunch_allowance` double NOT NULL,
  `medicare` double NOT NULL,
  `net_salary` double NOT NULL,
  `payment_date` datetime(6) DEFAULT NULL,
  `provident_fund` double NOT NULL,
  `tax` double NOT NULL,
  `telephone_subsidy` double NOT NULL,
  `transport_allowance` double NOT NULL,
  `utility_allowance` double NOT NULL,
  `advance_salary_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3500lw10qxryuigl4yu3ymc7t` (`advance_salary_id`),
  KEY `FKos57j8u42tdn3d132be45fsh9` (`user_id`),
  CONSTRAINT `FK3500lw10qxryuigl4yu3ymc7t` FOREIGN KEY (`advance_salary_id`) REFERENCES `advancesalaries` (`id`),
  CONSTRAINT `FKos57j8u42tdn3d132be45fsh9` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salaries`
--

LOCK TABLES `salaries` WRITE;
/*!40000 ALTER TABLE `salaries` DISABLE KEYS */;
INSERT INTO `salaries` VALUES (1,5000,5000,5000,5000,50000,'2024-11-18 17:25:47.000000',5000,500,500,500,500,1,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtcmFobWVkMTc5NkBnbWFpbC5jb20iLCJyb2xlIjoiQURNSU4iLCJpYXQiOjE3MzEzNDQxMjUsImV4cCI6MTczMTQzMDUyNX0.xZZfPwtouejxDYiB93APj69aRugcxqd4ZI-J0Jfhzqe2vdv0eLtRamM7S1lJx8BE',2),(2,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtcmFobWVkMTc5NkBnbWFpbC5jb20iLCJyb2xlIjoiQURNSU4iLCJpYXQiOjE3MzEzNDc2ODgsImV4cCI6MTczMTQzNDA4OH0.m0fIqYsiGyqdqkCS1p6s02F6yyQWRkkM_4W6_9MV76-QuYt6_UsDtizzhBBRNM1b',2),(3,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtcmFobWVkMTc5NkBnbWFpbC5jb20iLCJyb2xlIjoiTUFOQUdFUiIsImlhdCI6MTczMTM0Nzk2MCwiZXhwIjoxNzMxNDM0MzYwfQ.uNPdZ26DmfB11xRgdPBI7OklpfTsKnCCxoXOXDLl9Km3yo-Obp9Ca2yiYQ6sOyAC',2),(4,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtcmFobWVkMTc5NkBnbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzEzNDgwMDYsImV4cCI6MTczMTQzNDQwNn0.4hdaDiuhAWB07bD8ZnkyzABeNzkwVAWT3BCWyrb09n4j0Xcz21MeYta-89I4yjZv',2);
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
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
INSERT INTO `users` VALUES (1,_binary '','Lalbagh',50000,'123456789','2022-11-09','admin@mail.com','Male',_binary '','2024-11-11','Tamim','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731406440540_upload.jpg','ADMIN'),(2,_binary '','Lalbagh',50000,'01823456241','2000-02-02','manager@mail.com','Male',_binary '','2024-11-11','MRAhmed','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731406440540_upload.jpg','MANAGER'),(3,_binary '','Lalbagh',50000,'01912345678','1996-09-17','emp@mail.com','Male',_binary '','2024-11-12','Raju','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731406477345_upload.jpg','EMPLOYEE');
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

-- Dump completed on 2024-11-18 19:05:03
