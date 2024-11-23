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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advancesalaries`
--

LOCK TABLES `advancesalaries` WRITE;
/*!40000 ALTER TABLE `advancesalaries` DISABLE KEYS */;
INSERT INTO `advancesalaries` VALUES (1,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-21 18:16:03.000000','Test','PENDING',3),(2,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-21 18:16:03.000000','Test','PENDING',5),(3,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-21 18:16:03.000000','Test','PENDING',3),(4,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-21 18:16:03.000000','Test','PENDING',6),(5,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-21 18:16:03.000000','Test','PENDING',7),(6,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-21 18:16:03.000000','Test','PENDING',6),(7,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-21 18:16:03.000000','Test','PENDING',7),(8,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-21 18:16:03.000000','Test','PENDING',6),(13,33333,'2024-11-21 18:15:58.000000',_binary '\0','2024-11-21 18:16:03.000000','Test','PENDING',8);
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
  `salary_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7f87sy697hma8gq2f0qo3clw4` (`salary_id`),
  KEY `FK8o39cn3ghqwhccyrrqdesttr8` (`user_id`),
  CONSTRAINT `FK7f87sy697hma8gq2f0qo3clw4` FOREIGN KEY (`salary_id`) REFERENCES `salaries` (`id`),
  CONSTRAINT `FK8o39cn3ghqwhccyrrqdesttr8` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendances`
--

LOCK TABLES `attendances` WRITE;
/*!40000 ALTER TABLE `attendances` DISABLE KEYS */;
INSERT INTO `attendances` VALUES (1,'2024-11-21 14:16:38.000000','2024-11-21 18:16:40.000000','2024-11-21',_binary '\0',NULL,3),(11,'2024-11-21 12:36:40.000000','2024-11-21 18:36:44.000000','2024-11-21',_binary '\0',NULL,5),(13,'2024-11-21 12:36:40.000000','2024-11-21 18:36:44.000000','2024-11-21',_binary '\0',NULL,7),(14,'2024-11-21 12:36:40.000000','2024-11-21 18:36:44.000000','2024-11-21',_binary '\0',NULL,8),(15,'2024-11-21 12:36:40.000000','2024-11-21 18:36:44.000000','2024-11-21',_binary '\0',NULL,8),(21,'2024-11-21 19:05:24.005079','2024-11-21 19:05:56.790470','2024-11-21',_binary '',NULL,6),(22,'2024-11-23 11:02:51.875919','2024-11-23 11:03:52.486442','2024-11-23',_binary '',NULL,3);
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
  `salary_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKpnb8fhgpp16jk62ud7tpq4w53` (`salary_id`),
  KEY `FKbyghp6xxmqc4lnkoup4fsqhie` (`user_id`),
  CONSTRAINT `FKbyghp6xxmqc4lnkoup4fsqhie` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKpnb8fhgpp16jk62ud7tpq4w53` FOREIGN KEY (`salary_id`) REFERENCES `salaries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bonuses`
--

LOCK TABLES `bonuses` WRITE;
/*!40000 ALTER TABLE `bonuses` DISABLE KEYS */;
INSERT INTO `bonuses` VALUES (1,5000,'2024-11-21 18:17:31.000000','ANNUAL',NULL,6),(2,5000,'2024-11-21 18:17:31.000000','ANNUAL',NULL,5),(3,5000,'2024-11-21 18:17:31.000000','ANNUAL',NULL,7),(4,5000,'2024-11-21 18:17:31.000000','ANNUAL',NULL,8),(5,5000,'2024-11-21 18:17:31.000000','ANNUAL',NULL,5),(6,5000,'2024-11-21 18:17:31.000000','ANNUAL',NULL,6),(7,5000,'2024-11-21 18:17:31.000000','ANNUAL',NULL,3),(8,5000,'2024-11-21 18:17:31.000000','ANNUAL',NULL,7),(9,7070,'2024-11-22 11:30:59.652214','ANNUAL',NULL,8),(10,7070,'2024-11-22 11:31:31.086156','ANNUAL',NULL,8),(11,7000,'2024-11-22 20:09:02.000000','Performance',NULL,7);
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
  `end_date` date DEFAULT NULL,
  `leave_type` enum('RESERVE','SICK','UNPAID') DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `request_date` datetime(6) DEFAULT NULL,
  `request_status` enum('APPROVED','PENDING','REJECTED') DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `salary_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKq5mpe92s1cuo1ybftfy6hdgxu` (`salary_id`),
  KEY `FKa3vfaevh5a44ccfq2wodxoxig` (`user_id`),
  CONSTRAINT `FKa3vfaevh5a44ccfq2wodxoxig` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKq5mpe92s1cuo1ybftfy6hdgxu` FOREIGN KEY (`salary_id`) REFERENCES `salaries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaves`
--

LOCK TABLES `leaves` WRITE;
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
INSERT INTO `leaves` VALUES (1,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','PENDING','2024-11-22',NULL,3),(2,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,5),(3,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','PENDING','2024-11-22',NULL,6),(4,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','PENDING','2024-11-22',NULL,5),(5,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','REJECTED','2024-11-22',NULL,6),(6,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,7),(8,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','PENDING','2024-11-22',NULL,8),(11,'2024-11-23','SICK','SICK','2024-11-22 15:40:36.404817','PENDING','2024-11-22',NULL,7);
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
  `salary_status` tinyint DEFAULT NULL,
  `tax` double NOT NULL,
  `advance_salary_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKkd1rd8bfxddt73oyuk0x5y5tr` (`advance_salary_id`),
  KEY `FKos57j8u42tdn3d132be45fsh9` (`user_id`),
  CONSTRAINT `FK3500lw10qxryuigl4yu3ymc7t` FOREIGN KEY (`advance_salary_id`) REFERENCES `advancesalaries` (`id`),
  CONSTRAINT `FKos57j8u42tdn3d132be45fsh9` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `salaries_chk_1` CHECK ((`salary_status` between 0 and 2))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salaries`
--

LOCK TABLES `salaries` WRITE;
/*!40000 ALTER TABLE `salaries` DISABLE KEYS */;
INSERT INTO `salaries` VALUES (1,50000,'2024-11-21 18:19:14.000000',5000,1,5000,1,3),(3,50000,'2024-11-21 18:19:14.000000',5000,1,5000,2,5),(4,50000,'2024-11-21 18:19:14.000000',5000,0,5000,3,6),(5,50000,'2024-11-21 18:19:14.000000',5000,1,5000,4,7),(6,50000,'2024-11-21 18:19:14.000000',5000,0,5000,5,8);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlMkBtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjE5MjM2NCwiZXhwIjoxNzMyMjc4NzY0fQ.aHGKtdDT4NXPz1uWv_exHxi0IqgB6vVZeVV1Nq3SNZ9bLGMBnH8QuTRSW9ShCE1E',6),(2,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlNEBtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjIwNjA0MCwiZXhwIjoxNzMyMjkyNDQwfQ.-cbnrB0xSjfDBV6-XjN9DoJKaOZk1IljoksG9jl6M2OUji2NURlozwO1Zdwo8iR0',8),(3,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMjUzMzAzLCJleHAiOjE3MzIzMzk3MDN9.mXKGJ3qX6x0o-12gdtrby95ZQ9aM-Pz4Me0f3HjFjJEARh4t7EmdIqtANSN68iV6',3),(4,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlM0BtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjI1NDI0MSwiZXhwIjoxNzMyMzQwNjQxfQ.MnFbupzp4mZnwAr4PEekEhZAq6Pvrj-DkaNOGyNYwXxMyR0me31Jdol_pVjqsQzc',7),(5,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMzM4MDc0LCJleHAiOjE3MzI0MjQ0NzR9.0CcbttZTt7FHYGZ4sXI9vG6VqGsAWbcqXLw17PNITgBP-W0rxed2TzHJTssK4x-z',3);
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
INSERT INTO `user_leave_balance` VALUES (1,25,2),(2,25,0),(3,25,0),(5,25,0),(6,25,0),(7,25,0),(8,25,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,_binary '','Dhaka',50000,'017000000','2006-11-02','a@mail.com','Male',_binary '\0','2024-11-13','Tamim','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','ADMIN'),(2,_binary '','Dhaka',50000,'017000001','2006-11-02','m@mail.com','Male',_binary '\0','2024-11-13','Ahmed','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','MANAGER'),(3,_binary '','Dhaka',50000,'017000002','2006-11-02','e@mail.com','Male',_binary '\0','2024-11-13','Raju','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(5,_binary '','Dhaka',50000,'017000003','2006-11-02','e1@mail.com','Male',_binary '\0','2024-11-13','Rezvi','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(6,_binary '','Dhaka',50000,'017000004','2006-11-02','e2@mail.com','Male',_binary '\0','2024-11-13','Nusrat','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(7,_binary '','Dhaka',50000,'017000005','2006-11-02','e3@mail.com','Male',_binary '\0','2024-11-13','Shabab','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(8,_binary '','Dhaka',50000,'017000006','2006-11-02','e4@mail.com','Male',_binary '\0','2024-11-13','Sanaullah','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE');
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

-- Dump completed on 2024-11-23 11:07:03
