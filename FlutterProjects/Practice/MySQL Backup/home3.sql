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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advancesalaries`
--

LOCK TABLES `advancesalaries` WRITE;
/*!40000 ALTER TABLE `advancesalaries` DISABLE KEYS */;
INSERT INTO `advancesalaries` VALUES (1,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 11:51:01.469569','Test','APPROVED',3),(2,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 11:49:41.385452','Test','APPROVED',5),(3,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 11:49:42.519735','Test','APPROVED',3),(4,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 11:49:43.359467','Test','APPROVED',6),(5,10000,'2024-11-21 18:15:58.000000',_binary '\0',NULL,'Test','REJECTED',7),(6,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 11:49:44.813609','Test','APPROVED',6),(7,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 11:49:45.392733','Test','APPROVED',7),(8,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 11:49:45.891678','Test','APPROVED',6),(13,33333,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 11:49:46.348540','Test','APPROVED',8),(16,1000,'2024-11-25 11:40:36.387785',_binary '','2024-11-25 11:48:30.678088','lasjfdlkasf','APPROVED',3),(17,5000,'2024-11-25 11:57:49.836014',_binary '\0',NULL,'adfasdfasf','REJECTED',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendances`
--

LOCK TABLES `attendances` WRITE;
/*!40000 ALTER TABLE `attendances` DISABLE KEYS */;
INSERT INTO `attendances` VALUES (1,'2024-11-21 14:16:38.000000','2024-11-21 18:16:40.000000','2024-11-21',_binary '\0',NULL,3),(11,'2024-11-21 12:36:40.000000','2024-11-21 18:36:44.000000','2024-11-21',_binary '\0',NULL,5),(13,'2024-11-21 12:36:40.000000','2024-11-21 18:36:44.000000','2024-11-21',_binary '\0',NULL,7),(14,'2024-11-21 12:36:40.000000','2024-11-21 18:36:44.000000','2024-11-21',_binary '\0',NULL,8),(15,'2024-11-21 12:36:40.000000','2024-11-21 18:36:44.000000','2024-11-21',_binary '\0',NULL,8),(21,'2024-11-21 19:05:24.005079','2024-11-21 19:05:56.790470','2024-11-21',_binary '',NULL,6),(22,'2024-11-23 11:02:51.875919','2024-11-23 11:03:52.486442','2024-11-23',_binary '',NULL,3),(23,'2024-11-24 10:30:49.706728','2024-11-24 10:31:38.066048','2024-11-24',_binary '',NULL,3),(24,'2024-11-25 11:34:11.558595','2024-11-25 11:40:04.048857','2024-11-25',_binary '',NULL,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaves`
--

LOCK TABLES `leaves` WRITE;
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
INSERT INTO `leaves` VALUES (1,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,3),(2,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,5),(3,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,6),(4,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,5),(5,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','REJECTED','2024-11-22',NULL,6),(6,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,7),(8,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,8),(11,'2024-11-23','SICK','SICK','2024-11-22 15:40:36.404817','APPROVED','2024-11-22',NULL,7),(12,'2024-11-28','SICK','asfdjlka','2024-11-24 10:33:28.400781','APPROVED','2024-11-25',NULL,3),(13,'2024-11-30','SICK','sdfasdf','2024-11-25 11:56:55.810921','REJECTED','2024-11-28',NULL,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlMkBtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjE5MjM2NCwiZXhwIjoxNzMyMjc4NzY0fQ.aHGKtdDT4NXPz1uWv_exHxi0IqgB6vVZeVV1Nq3SNZ9bLGMBnH8QuTRSW9ShCE1E',6),(2,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlNEBtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjIwNjA0MCwiZXhwIjoxNzMyMjkyNDQwfQ.-cbnrB0xSjfDBV6-XjN9DoJKaOZk1IljoksG9jl6M2OUji2NURlozwO1Zdwo8iR0',8),(3,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMjUzMzAzLCJleHAiOjE3MzIzMzk3MDN9.mXKGJ3qX6x0o-12gdtrby95ZQ9aM-Pz4Me0f3HjFjJEARh4t7EmdIqtANSN68iV6',3),(4,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlM0BtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjI1NDI0MSwiZXhwIjoxNzMyMzQwNjQxfQ.MnFbupzp4mZnwAr4PEekEhZAq6Pvrj-DkaNOGyNYwXxMyR0me31Jdol_pVjqsQzc',7),(5,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMzM4MDc0LCJleHAiOjE3MzI0MjQ0NzR9.0CcbttZTt7FHYGZ4sXI9vG6VqGsAWbcqXLw17PNITgBP-W0rxed2TzHJTssK4x-z',3),(6,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzIzNDEwMzcsImV4cCI6MTczMjQyNzQzN30.Agyy_ghqm9VficOjBQRy58PdjFvRy8wE-hA_mz-BENqwQVDXhR3xFUPLMHUUEoRG',2),(7,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMzQxMTQwLCJleHAiOjE3MzI0Mjc1NDB9.hr9dt9s3FrzLyCBpY2aT8tWs_KSxDt34yQstHTxqqsH9MnxZEZ6U8lfIHcqemLuc',3),(8,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMzQzMjg3LCJleHAiOjE3MzI0Mjk2ODd9.LC9ALpJ0ORFIwfK9HfyirXYhewSRKiLb7uo9m1Hgz4_J95MeQON4UYglpjBPx-VD',3),(9,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MTYwNTEsImV4cCI6MTczMjUwMjQ1MX0.5ESZJ4KyfzU1kWA9z79dL6te3QaQlHwJ0-jPEcqu5wvEmuD01d_1XgHuujRFwIlM',3),(10,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MTYwNzAsImV4cCI6MTczMjUwMjQ3MH0.Xznc76WALDAvotCl5tCm4woUlRtn2ic5hcvJRV8rtuRXPTwmBWd_E4CmTfPfpAvI',3),(11,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjIyODIsImV4cCI6MTczMjUwODY4Mn0.LJb24cJqaLT5hOj4DTAnmUUHaP38xVFlrbMorAVY4mHgkcIiuXlnXlcaaQ0hrSK7',3),(12,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjI2NDUsImV4cCI6MTczMjUwOTA0NX0.GwCNAoWB0WQ93VyOU0IpYLVhW1wETP2B30Vky_JEQC_J4BtrHMdtWQlZrfuYk9oi',3),(13,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjQxNjgsImV4cCI6MTczMjUxMDU2OH0.SacQ9KpPhmSXCBUWAz60V0dayWCGZ7nDbn59JIUIwVO3TXKSbJg7KLKPmEJoDWvb',3),(14,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjUzNTMsImV4cCI6MTczMjUxMTc1M30.CkBtjPHJZzWQiFe2qtrorKplRwYSHkAnlOfEpRNy1xqtfDXoUFDEKQeaJF2LHEUR',3),(15,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjU1NzAsImV4cCI6MTczMjUxMTk3MH0.wauOagu-2ORBWOM_lMIy_hMrk6LzhXi9Dr6-OmlZ3R3rPp7-wrtykERjzDqJ_DT3',3),(16,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjU2MTQsImV4cCI6MTczMjUxMjAxNH0.Dh7UiSNbjchaYgBTpnRYga_ScjsI5GJvHpr3tU2Sg4OnQ7Ho22FWZ0SSlnJ_jpNk',3),(17,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjU5OTQsImV4cCI6MTczMjUxMjM5NH0.XggkqLoRExp73z0tfvbjtGbV6saArEAPiGtODlKkbDJspdtfkuAq_5mDqgYM0yQ-',3),(18,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjYyODAsImV4cCI6MTczMjUxMjY4MH0.B3b4YXpwL-CETrYrCEU8cS8Pj57EBdhlELF7hTc-mRwZFmvNnVxdPj_81WSTqk27',3),(19,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjY0OTYsImV4cCI6MTczMjUxMjg5Nn0.-Cto_zcoJUym473KzIm1_UVNQ03U8R1P0cpPn3tl-T02kD4vpcPj5CHYY-AUKgTB',3),(20,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjY1NTMsImV4cCI6MTczMjUxMjk1M30.OqUBiBxkjqhIWIt--OxW4f1jvX6pweX8UqYZwZzoZqe3y68GsYWVKqTbKd7GQoB3',3),(21,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjY1ODMsImV4cCI6MTczMjUxMjk4M30.-07dsp-qeCKfdFRJ6ssKB0nmsIVahq4HutvvmGrYUVSn8jXlszuo_ZbNb7HD9Lxx',3),(22,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjY4NjYsImV4cCI6MTczMjUxMzI2Nn0.O5G9zPJqrbi6ZPIaNRVAeEhfHGIkmQHmfETFvWODB_eVmoRWLBsoEzbHUimqaiF2',3),(23,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjY4NzgsImV4cCI6MTczMjUxMzI3OH0.idBLsLOQCUk-H2gqZuRdgr_ttmkxyMLJ1QzgF6h3W_qVlOKYJi1FcslMQIpi0nCO',3),(24,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjY5OTEsImV4cCI6MTczMjUxMzM5MX0.8OPg0xY09f2hu8UpEFu72H1BSIHR8eMzi19IH9yajgcdab9jgd48UGlrIJonKBMu',3),(25,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjcxMzEsImV4cCI6MTczMjUxMzUzMX0.G0lvGTwmOiJk5djDfe_fd_9TBOjHgO8RHbGPBnfjC0Mdb6EQN4fmOUt20wVBEeGa',3),(26,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjczNzUsImV4cCI6MTczMjUxMzc3NX0.DFE_N7bby-iivaqSVp0GpjQT4hUHoz9GrRkhUQhJNgtv7qfDQ5AfDw86LY7z6sUd',3),(27,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0Mjc4MDQsImV4cCI6MTczMjUxNDIwNH0.T7n2uWa-4vui-B-kQM5zlpu19rLAMpHf-VO8JVeCcTl1li5MSdcXP0ElViEHOw_v',3),(28,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhQG1haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDI3ODEyLCJleHAiOjE3MzI1MTQyMTJ9.qgVZXsq6WUFSekO9yxRlzWN-ickDNB_efQzoPcoHBJV0-_YcHrDFSy7Hp6nKN30L',1),(29,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0Mjc4MjMsImV4cCI6MTczMjUxNDIyM30.-IoYeeCnCKRxasC9OQb9R8cNv1zmXJNdMNJQNBRCnupf6Tq3W-cLR6w9w1RwfpaP',3),(30,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0Mjc5NzAsImV4cCI6MTczMjUxNDM3MH0.CWMZmGbRpIB6fUbEwVkk_ZnbsiEQv4P59vo5-eGLMNDbqGQ-KRU0jgXwOsVtYLT4',3),(31,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjgwODIsImV4cCI6MTczMjUxNDQ4Mn0._88vOOUosKiQGq05Pg-RxVLgc9UpWsN64HP_UPQyk8_3ku1JB3JT3jFgxIsjnviF',3),(32,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjgxMjQsImV4cCI6MTczMjUxNDUyNH0.yr_cnZk91t8p_QRB5u3UcGSYjns8WsSXrKuPeXvgVi-XM-l_LYhI9RbD6hG1qeiU',3),(33,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhQG1haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDI4NjY3LCJleHAiOjE3MzI1MTUwNjd9.ihSAZuE2PfUUoTjzNjqLUAbs4XuTC1pVXhrDd4epn0ARjs2yxpiGC0-p3NlDIWl5',1),(34,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhQG1haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDI4ODk5LCJleHAiOjE3MzI1MTUyOTl9.1YBZpTygXLA7ImWL6VWQqcbVURErz8GG4HagN1M3sS75ihpjIabVxTV9GWn0858G',1),(35,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0Mjg5MjEsImV4cCI6MTczMjUxNTMyMX0.vc45ios-2N6ahghUB9fp9GOCi_M05NLb7JjeuZRCv04jhTE2JPnAVzERWxhpBprT',3),(36,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0MjkxMjEsImV4cCI6MTczMjUxNTUyMX0.aM-mk_FjXL7jKP2FKW7pPH3FYiHPXppChC9LGo7W3vCWSfj0ZqDRZ6RumMI85jdg',3),(37,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0NjkyNjAsImV4cCI6MTczMjU1NTY2MH0.eAU6_EjjT6zwY8Xtqvta-uo-ls1PSUfY5emNGXR-dbL-IfHlj70p5c0WAKewnK_q',3),(38,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI0NzA5MjgsImV4cCI6MTczMjU1NzMyOH0.4nEZUpHKmQGGx2Dzd2R8TIILtfufOYHo61B_M1TUTdlsoe3aCqD7vnYdBvuCKqxn',2),(39,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI0NzI1MTYsImV4cCI6MTczMjU1ODkxNn0.Yp5_WJioA0b0SyfRSII6vMsJmpCcWuVCu7M-8LV7RcfrXk5GT1n-o5BXoxq904On',2),(40,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI0NzM4NTgsImV4cCI6MTczMjU2MDI1OH0.4ihmPdy4xrDbsrueuoF0YzrB2qI4yvnjQqZjjtlF3KXFEL7ItdO5NRjiygnB69z4',2),(41,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI0NzUxMzgsImV4cCI6MTczMjU2MTUzOH0.0g8MfM7aMviaJyGEihwD-E25qW3uo_bIQ_8dPzYJ8nHG0Faw-dDj6MAIcqR9OL8O',2),(42,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI1MTI4MzYsImV4cCI6MTczMjU5OTIzNn0.jZU-J17ub5qwL2lTBGZ28XgvztXEg5iHOpByGl9tDLjafM8ujsO81wWBfKG4K1_E',3),(43,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI1MTMyMDAsImV4cCI6MTczMjU5OTYwMH0.gCVRjKRaUPGD_zY2ID-u_-VPpI9pxTZJ4nUbXr-x0gFZXOnn341gevar_JzhqZtN',3),(44,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI1MTM2OTksImV4cCI6MTczMjYwMDA5OX0.I4ynDpSi31XqTo4YDB8m0Y-gaAgKy3ylehVW2tMx304lV74srk8ga0Aic11mDtE2',2),(45,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI1MTM4NTMsImV4cCI6MTczMjYwMDI1M30.TEvRZd0OiAKb7y60HkQpyue8T6HJP-bXxrXt5UwS9GirhSGc3zCsbJ5cX5ezQj3C',2),(46,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI1MTQwNDQsImV4cCI6MTczMjYwMDQ0NH0.PM3Mr_eCIGXcCwiMY-B--UQUl8vrdYYpvSs-bhAdC-veNMkfY_ycA5Nmco5ZKDI-',3),(47,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI1MTQyMjUsImV4cCI6MTczMjYwMDYyNX0.sjj6GQLAfgZkaM2r09V1TCTqC-d9Vbu-rzLAvpiaHRbZILLESKEBR7qo2H6DRXm3',2),(48,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI1MTQyNjAsImV4cCI6MTczMjYwMDY2MH0.yCej1-jRsqXDCrAptQZUQcD6AnK0nMYeMLZt0QHRqYhbRwk6gCQPZhsEjK501viP',3),(49,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI1MTQyODYsImV4cCI6MTczMjYwMDY4Nn0.CvKOcgovfi3QPHRjXWiVffoGZrFFyAmtN1Y5cI3zbjfSUVQDQmhFTNT2beIeaqS8',2),(50,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI1MTg0MDIsImV4cCI6MTczMjYwNDgwMn0.XKESdECWAtuW2sQSZbnmy6hI0nYODf-RLk6P22zqerwHol3j2ZoGo-eOKZ1TOsgf',2);
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
INSERT INTO `user_leave_balance` VALUES (1,25,2),(2,25,0),(3,18,0),(5,25,0),(6,25,0),(7,25,0),(8,25,0);
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
INSERT INTO `users` VALUES (1,_binary '','Dhaka',50000,'017000000','2006-11-02','a@mail.com','Male',_binary '\0','2024-11-13','Tamim','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','ADMIN'),(2,_binary '','Dhaka',50000,'017000001','2006-11-02','m@mail.com','Male',_binary '\0','2024-11-13','Ahmed','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','MANAGER'),(3,_binary '','Dhaka',50000,'017000002','2006-11-02','emp@mail.com','Male',_binary '\0','2024-11-13','Raju','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(5,_binary '','Dhaka',50000,'017000003','2006-11-02','emp1@mail.com','Male',_binary '\0','2024-11-13','Rezvi','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(6,_binary '','Dhaka',50000,'017000004','2006-11-02','emp2@mail.com','Male',_binary '\0','2024-11-13','Nusrat','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(7,_binary '','Dhaka',50000,'017000005','2006-11-02','emp3@mail.com','Male',_binary '\0','2024-11-13','Shabab','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(8,_binary '','Dhaka',50000,'017000006','2006-11-02','emp4@mail.com','Male',_binary '\0','2024-11-13','Sanaullah','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE');
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

-- Dump completed on 2024-11-25 13:16:37
