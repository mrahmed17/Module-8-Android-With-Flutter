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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advancesalaries`
--

LOCK TABLES `advancesalaries` WRITE;
/*!40000 ALTER TABLE `advancesalaries` DISABLE KEYS */;
INSERT INTO `advancesalaries` VALUES (1,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 15:54:12.267920','Test','APPROVED',3),(2,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 15:54:13.422167','Test','APPROVED',5),(3,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 15:54:16.596897','Test','APPROVED',3),(4,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 15:54:14.527594','Test','APPROVED',6),(5,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 15:54:15.429729','Test','APPROVED',7),(6,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 15:54:18.439352','Test','APPROVED',6),(7,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 15:54:17.598897','Test','APPROVED',7),(8,10000,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 15:54:19.131158','Test','APPROVED',6),(13,33333,'2024-11-21 18:15:58.000000',_binary '','2024-11-25 15:54:19.789355','Test','APPROVED',8),(16,5000,'2024-11-24 17:56:57.521564',_binary '','2024-11-25 15:54:20.486002','Urgent Need','APPROVED',3),(17,10000,'2024-11-24 18:02:10.275932',_binary '','2024-11-25 15:54:21.227593','alksjdflkasd;klfj','APPROVED',5),(18,54564,'2024-11-24 18:47:53.700174',_binary '','2024-11-25 15:54:09.371968','asfoisadfosjif','APPROVED',7),(19,5000,'2024-11-26 15:21:18.921057',_binary '','2024-11-26 16:03:29.867722','asdfasoidf','APPROVED',3),(20,5000,'2024-11-26 16:02:15.193213',_binary '','2024-11-26 16:03:32.102400','asdfasdf','APPROVED',9),(21,5000,'2024-11-26 16:42:21.802071',_binary '','2024-11-26 16:42:36.816300','asfda','APPROVED',8),(22,5000,'2024-11-27 15:15:16.538069',_binary '','2024-11-27 15:15:44.412181','asdfasdf','APPROVED',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendances`
--

LOCK TABLES `attendances` WRITE;
/*!40000 ALTER TABLE `attendances` DISABLE KEYS */;
INSERT INTO `attendances` VALUES (1,'2024-11-21 14:16:38.000000','2024-11-21 18:16:40.000000','2024-11-21',_binary '\0',NULL,3),(11,'2024-11-21 12:36:40.000000','2024-11-21 18:36:44.000000','2024-11-21',_binary '\0',NULL,5),(13,'2024-11-21 12:36:40.000000','2024-11-21 18:36:44.000000','2024-11-21',_binary '\0',NULL,7),(14,'2024-11-21 12:36:40.000000','2024-11-21 18:36:44.000000','2024-11-21',_binary '\0',NULL,8),(15,'2024-11-21 12:36:40.000000','2024-11-21 18:36:44.000000','2024-11-21',_binary '\0',NULL,8),(21,'2024-11-21 19:05:24.005079','2024-11-21 19:05:56.790470','2024-11-21',_binary '',NULL,6),(22,'2024-11-23 11:02:51.875919','2024-11-23 11:03:52.486442','2024-11-23',_binary '',NULL,3),(23,'2024-11-23 16:09:52.395513','2024-11-23 16:10:02.748148','2024-11-23',_binary '',NULL,5),(24,'2024-11-23 16:16:58.257186','2024-11-23 19:06:55.936322','2024-11-23',_binary '',NULL,7),(25,'2024-11-23 17:36:37.555285','2024-11-23 17:36:41.038234','2024-11-23',_binary '',NULL,8),(26,'2024-11-24 17:56:39.732601','2024-11-24 18:04:03.185451','2024-11-24',_binary '',NULL,3),(27,'2024-11-24 18:01:34.278476','2024-11-24 18:55:07.826864','2024-11-24',_binary '',NULL,5);
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaves`
--

LOCK TABLES `leaves` WRITE;
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
INSERT INTO `leaves` VALUES (1,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,3),(2,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,5),(3,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,6),(4,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,5),(5,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','REJECTED','2024-11-22',NULL,6),(6,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,7),(8,'2024-11-23','SICK','SICK','2024-11-21 18:18:31.000000','APPROVED','2024-11-22',NULL,8),(11,'2024-11-23','SICK','SICK','2024-11-22 15:40:36.404817','APPROVED','2024-11-22',NULL,7),(12,'2024-11-24','SICK','TEST','2024-11-23 16:45:00.625764','REJECTED','2024-11-22',NULL,7),(13,'2024-11-24','SICK','TEST 45','2024-11-23 16:50:18.551038','REJECTED','2024-11-23',NULL,5),(14,'2024-11-26','SICK','adsfadfadf','2024-11-23 17:03:28.449738','REJECTED','2024-11-24',NULL,3),(15,'2024-11-28','RESERVE','RESERVE LEAVE ','2024-11-23 17:05:35.155269','APPROVED','2024-11-25',NULL,3),(16,'2024-11-29','SICK','adsfas','2024-11-24 18:01:59.097998','APPROVED','2024-11-25',NULL,5),(17,'2024-11-30','RESERVE','adfasdf','2024-11-24 18:55:29.571331','APPROVED','2024-11-26',NULL,8),(18,'2024-11-26','SICK','asdfasd','2024-11-26 15:21:11.020648','APPROVED','2024-11-26',NULL,3),(19,'2024-11-30','UNPAID','adsfasdf','2024-11-26 16:02:03.461900','APPROVED','2024-11-27',NULL,9),(20,'2024-12-03','SICK','asdfa','2024-11-26 16:05:36.776324','APPROVED','2024-11-27',NULL,9),(21,'2024-11-29','SICK','adf','2024-11-26 16:42:12.395214','APPROVED','2024-11-27',NULL,8),(22,'2024-11-30','SICK','asdfasdf','2024-11-27 15:14:25.564764','APPROVED','2024-11-28',NULL,3),(23,'2024-12-01','RESERVE','asdfas','2024-11-27 15:15:02.248167','APPROVED','2024-11-30',NULL,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlMkBtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjE5MjM2NCwiZXhwIjoxNzMyMjc4NzY0fQ.aHGKtdDT4NXPz1uWv_exHxi0IqgB6vVZeVV1Nq3SNZ9bLGMBnH8QuTRSW9ShCE1E',6),(2,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlNEBtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjIwNjA0MCwiZXhwIjoxNzMyMjkyNDQwfQ.-cbnrB0xSjfDBV6-XjN9DoJKaOZk1IljoksG9jl6M2OUji2NURlozwO1Zdwo8iR0',8),(3,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMjUzMzAzLCJleHAiOjE3MzIzMzk3MDN9.mXKGJ3qX6x0o-12gdtrby95ZQ9aM-Pz4Me0f3HjFjJEARh4t7EmdIqtANSN68iV6',3),(4,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlM0BtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjI1NDI0MSwiZXhwIjoxNzMyMzQwNjQxfQ.MnFbupzp4mZnwAr4PEekEhZAq6Pvrj-DkaNOGyNYwXxMyR0me31Jdol_pVjqsQzc',7),(5,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMzM4MDc0LCJleHAiOjE3MzI0MjQ0NzR9.0CcbttZTt7FHYGZ4sXI9vG6VqGsAWbcqXLw17PNITgBP-W0rxed2TzHJTssK4x-z',3),(6,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMzU1NjI2LCJleHAiOjE3MzI0NDIwMjZ9.2Q1wZiNdmD_bHvkYChl6iatyu-ptcygLhuwvZkASp-DkD9xCOT2tLazBMlPmf9Da',3),(7,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlMUBtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjM1NjQ3NywiZXhwIjoxNzMyNDQyODc3fQ.9HryTTdLHfDrfCOAgAbM91OJLkYwUSLuHamSilpzNMwyggxY-aO6AJR7z5qBml9-',5),(8,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlMUBtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjM1NjU4OSwiZXhwIjoxNzMyNDQyOTg5fQ.RL4SlggxpGgQSYqmRCZ5xe4bu1Wz3QFEG8hh-uZdHZFHW4dBWu3HNL2HneOJIY50',5),(9,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlM0BtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjM1NzAxNSwiZXhwIjoxNzMyNDQzNDE1fQ.zqtRyr3qKoj7Gwpng46f7duQ46aqPxb2URwR3kf4reHVzOMDb4Irff6LAh7xKuuw',7),(10,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlMUBtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjM1NzM4MiwiZXhwIjoxNzMyNDQzNzgyfQ.pGJv57iaTqyCacpdJ-uP_EKAYSSBFNNo4yiJKSEvxg3ecgoDOmRXYSfQhIJj1dD3',5),(11,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlMUBtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjM1Nzg5NCwiZXhwIjoxNzMyNDQ0Mjk0fQ.HQ4IdAjmJrnepYPkd4lybF1aSMZLfB4ZLRH4zG2gIW-CarhfYrL2dgERf8n_wz-a',5),(12,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlMUBtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjM1ODIzNywiZXhwIjoxNzMyNDQ0NjM3fQ.4wNuaHFTKTyGNRlWIDRCTldawpSeAr_NZnDg26JCTqsAgu1TAazztMjyvv_tdCeL',5),(13,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlMUBtYWlsLmNvbSIsInJvbGUiOiJFTVBMT1lFRSIsImlhdCI6MTczMjM1ODM5MCwiZXhwIjoxNzMyNDQ0NzkwfQ.fXbH-xF660Dk3fg25onPa2XBWIHBRJaBzr-iSZo1GSB1shuvPpSR92WF7e7k39Ax',5),(14,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzIzNTk2MTYsImV4cCI6MTczMjQ0NjAxNn0.kwoyYOeK6gZxjUcs0Oap0FhI4yMS9bWzHdoFb6RfqyzWYw79u3AesycsmrZctEDj',3),(15,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzIzNjAxMDcsImV4cCI6MTczMjQ0NjUwN30.vZBT76ihYkTlgNIPf8fiW7MQ2xsWOiHSQAozD9McLQx8NXGVL-UQ176LS-JiBqV3',2),(16,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzIzNjAxMjQsImV4cCI6MTczMjQ0NjUyNH0.7FLyPt57JzdTZ9CSCr_kLWCayqjCb9AdnWQA8tcSpJv3G0oYtAJ93vBZWu_T_30x',2),(17,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzIzNjAxODMsImV4cCI6MTczMjQ0NjU4M30.sCWCdRZ-2uzE75JEplCqWmn1ekhqLBvWTiSxfMncxI0pb8Ft1WijrFMkell7_gzD',3),(18,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzIzNjA0MzMsImV4cCI6MTczMjQ0NjgzM30.Ac59BkN14yqZaUwNvkDZ0eZqa2ZdX-njlcpgt2nGKNEgdVBwQL2PQj6PbPvy5S_a',3),(19,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzIzNjE1NDEsImV4cCI6MTczMjQ0Nzk0MX0.5v194tCWf-0issQK3_Ikx7_ZTC5VZRdUOe7HYoPz0iOpGvrYl-sldT2jT7srbKHi',3),(20,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzIzNjE1NTQsImV4cCI6MTczMjQ0Nzk1NH0._5OfMKFWWFopUnBV_mqeM2yj4CqjkwcmlGb1ypfsmqW55uorIfwH_-xl0-RIU064',2),(21,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzIzNjE1ODQsImV4cCI6MTczMjQ0Nzk4NH0.jlsuIE7SOr8eOcQnnCYdtHU30r678yuxXQyT52dQLFYQV0iBnNM9wvkUj9E_u701',2),(22,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzIzNjE2MzksImV4cCI6MTczMjQ0ODAzOX0.4hPPYOV0k4covKSU-zdLe1jJ_uYS56w5R_b47-34bw_fzcHTDpqpC-7Wp7O6jhx_',2),(23,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzIzNjE3NDAsImV4cCI6MTczMjQ0ODE0MH0.U9NIktDO5LXsRKewFpF5ERxOjO96Vwh7b9BjupherCIpTFi62JW6CMbp8UT5TG9U',3),(24,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXA0QG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMzYxNzk0LCJleHAiOjE3MzI0NDgxOTR9.jUfu2NBGJC8EvNxBWr9Mz1oWhgUlrY6cNjUw4yfFFa3RrgB6VS3fL_qHNUkd1S6a',8),(25,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzIzNjMzNTEsImV4cCI6MTczMjQ0OTc1MX0.hvfoE5WFO2H4KNLfaLvnOlKYcWy_iJWjWBS_SkDT8GotkNdtkI6Pwhm5Jjq-zkzZ',3),(26,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXA0QG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMzYzNzQyLCJleHAiOjE3MzI0NTAxNDJ9.gToeYgGpOAaUG_6EEJNavdvUe2PryFKc1FYnRVYaK73dv1s6_f_M-1OocGbsDR_w',8),(27,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhQG1haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzY0ODcwLCJleHAiOjE3MzI0NTEyNzB9.4uBnhKoFOmkJiP4gYyCwOwT5pbfxfTVJtm2PQ41qmL6WrQN3tVqBfqYytLz4-5WE',1),(28,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzIzNjU0NDQsImV4cCI6MTczMjQ1MTg0NH0.F_9RlbnWsUs5a0d2rrM1vLS70OZHOITaFtFGsoNdAwwrawHcydF4BKyBIzdo_UKc',2),(29,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhQG1haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzY1NTU0LCJleHAiOjE3MzI0NTE5NTR9.JQZ9CUQukhdwBYu8MvyFt8KoGitF3vWnthMEQ2H7G7QWT674vaOshM2mJAQ957j2',1),(30,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhQG1haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzY1NjgzLCJleHAiOjE3MzI0NTIwODN9.iBfUDozx02GyL7tUplFyBCq-JtvLdt6y-6__Duu2x32zfernFPBZBaWF5rsUGc50',1),(31,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzIzNjU5MTcsImV4cCI6MTczMjQ1MjMxN30.D-54yAhJoOs_6kVJ02EpZB1glx5a7-evmvz8l4mA59wHmuUc-QOPVN3YQxwxVxuu',3),(32,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzIzNjY0NjksImV4cCI6MTczMjQ1Mjg2OX0.JB04V3pGXEuHZJDjoewb_mI5oQGyLSwwB1lgbi7oDEdSRarUuhjlqJEKZZrH1zA_',2),(33,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzIzNjY1MTIsImV4cCI6MTczMjQ1MjkxMn0.1rsJQbfNGn1L-UrxFb4btmWXrsdGHuESL0E4pGiJVLQjyGlL6YHG0faFAIDtNlNp',2),(34,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzIzNjY1MjMsImV4cCI6MTczMjQ1MjkyM30.xnjFtCUmMa2MJRtPqn_I4fuhc5YoYyzAtZ4_KfV8BpP8SnudaEz-dwqRKMMUlvWX',2),(35,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhQG1haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzY2NTg0LCJleHAiOjE3MzI0NTI5ODR9.sdoWSDWCRcWykBOH9sKn21458C68qbUchLLoktVtVfGlLXoNcNuEArlNfYGK98M-',1),(36,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzIzNjY5NjYsImV4cCI6MTczMjQ1MzM2Nn0.X-TKjhRZAYqUaWR_L1_S3VsIbzRLpNndO4d1mnqYG5kpBOw0n3nqu7u4dwK_LlaI',2),(37,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzIzNjcwOTAsImV4cCI6MTczMjQ1MzQ5MH0.LFrgkjVhyn6i45vDPHS6hELC4-5UNJg78RJDXDU0vMfq1BlhbyFh9Cu31F9eIExH',3),(38,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzIzNjcxOTYsImV4cCI6MTczMjQ1MzU5Nn0.pg4uVHnQHz6rWpSP24KtBlhO-n81Hmoj-CkFoahWun15m_SfMr8uv4-9ohReYuLr',3),(39,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXAzQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMzY3MjExLCJleHAiOjE3MzI0NTM2MTF9.N4rtjnwnVWl2sa7m6QTpwtTPtG0Ex1ngzNcjw35LDV2rkamZdzrsoLf5eHMbQQIg',7),(40,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXAyQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMzY3MjQ3LCJleHAiOjE3MzI0NTM2NDd9.sX1zDvGIzaEsrxfbkyzyg0Xar7wgll4g3t9L13NrQ6pGAAb-6YRaWXZ5YsAvVcba',6),(41,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXA0QG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyMzY3MjU2LCJleHAiOjE3MzI0NTM2NTZ9.Vf-zIB9y8RcqDSy80Ld4OpwNJx3g5AOKPGpG9xuWt_B4v9bgAceFSjymM6-7hW8Z',8),(42,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0NDkzODQsImV4cCI6MTczMjUzNTc4NH0.eV-EetBZoRMH6b6lVS32SwvWvFqNEmFllNlsbznCn70oKt-bB33Ggs4czCmK5k2U',3),(43,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0NDk2ODEsImV4cCI6MTczMjUzNjA4MX0.yQGzLEt9-Zs0W18QLC_LXg9xvbuaD1qY3vG7rcLmY44gUm1SsuHCjrnuP0WbCOHu',3),(44,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXAxQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyNDQ5NjkxLCJleHAiOjE3MzI1MzYwOTF9.z8SRkyz9gyas7AUpcEswU50MksKUXfeKfyckkmJhFPScr6OdCeOBWkzlUphpOUq6',5),(45,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI0NDk3NTksImV4cCI6MTczMjUzNjE1OX0.-MIVii0vCIM5uMeOLCGRgdaATaIckHaDy7dWstBeXsdSSqsPyf7n9XLVbjMiS87d',2),(46,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhQG1haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDQ5NzkxLCJleHAiOjE3MzI1MzYxOTF9.YdVogADeWQruGu9Z4OhRmP3lvn8Jp4C-L6ggnkd5ZwRh5Q-srvnO6CtOoNoJ6ybJ',1),(47,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0NDk4MDEsImV4cCI6MTczMjUzNjIwMX0.Tm3iGhKnwlnSQ3PE7Qae3gYCmrQsZZBRIV0Dk6aYDxLQoA5CRQrF-h63vFnXz41P',3),(48,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhQG1haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDQ5ODEzLCJleHAiOjE3MzI1MzYyMTN9.XkIufNLCKYDYPfc0fTFv4o4uN75izptNk6wpXHWJsByPCjUrWEBVmy0u0wjR0R4C',1),(49,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI0NDk4MjEsImV4cCI6MTczMjUzNjIyMX0.s52s13YOL0J_XD2JS3iJetMjO_bvbjmH5DvaSEFhM8GewXYalO3v_1d5M95mxR3t',2),(50,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0NDk4MzgsImV4cCI6MTczMjUzNjIzOH0.Np2csKdRJO7NX1tmdGkKGpkpzPBeUYwxtMadT47ONH3GbAJf_kqpLlI3cXMxkTEb',3),(51,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI0NDk5ODcsImV4cCI6MTczMjUzNjM4N30.uYFJull6Xc0hcJKxYYUD1qnBqqKgltnfk4IlYw8fqrKOdaacFPnk17NW0HfxhTX0',2),(52,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhQG1haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDUwMDA2LCJleHAiOjE3MzI1MzY0MDZ9.c-E5VRVrtMYGBOCaoj6ups4g_4k8k2SN0qNzW6putJJORAzFYKEWdbZ70aql_Hi6',1),(53,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI0NTAyNzQsImV4cCI6MTczMjUzNjY3NH0.ZJtBna12ZTXLC7vOMrB1r3XQg52nFGpoOynEZA4XgeVzDbeazabqBVEsiiMnbcHN',2),(54,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI0NTE2MjgsImV4cCI6MTczMjUzODAyOH0.uNm_Mign-S5dH1yTxX8CW-u5ST-oS4UK0ZtJlwr5CHxgIblhNaS5ey3vRpgSsEI3',2),(55,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI0NTIzNjAsImV4cCI6MTczMjUzODc2MH0.EAxw_AaGV1muoEkcACfP-wH9hhHAfeyQwOBrOrrZXdNIxry2BSmpy0wiy0AEGQ4d',2),(56,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0NTI0NTMsImV4cCI6MTczMjUzODg1M30.XMjUPjGDgIW1itLaizkw8C0vh2bgLmPOZ0wuMol_GGg716CBUuH_vDptCLNZnZH1',3),(57,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXAzQG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyNDUyNDY0LCJleHAiOjE3MzI1Mzg4NjR9.dW9MdjTCikrBvfaALnKweGEqNFZBm8zU6VOGhd4gHUm3Povo_5VWj3c6yr5zNr2Y',7),(58,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI0NTI0ODIsImV4cCI6MTczMjUzODg4Mn0.vzi82DWQTKA8eFDn6maorqI_fcNZeFc_q19THz9kbk_-scZEDy4S4JniOlIpz8dR',2),(59,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI0NTI4ODYsImV4cCI6MTczMjUzOTI4Nn0.vEHPvYJYL87tEWXSXKYlSe2_jbYBD5wqiAKOLmJTeeWuJ9rNKTlaChStegqaRgou',3),(60,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXA0QG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyNDUyOTAxLCJleHAiOjE3MzI1MzkzMDF9.1A8vfmdzwOmk346K59n5SsMJY5JouVIwgDPmPwfQigdtqFmHpQZPP3pdgp3rtGMz',8),(61,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI0NTI5MzgsImV4cCI6MTczMjUzOTMzOH0.0SfJGbkebb_YYBMJnBc9X3J_vVFOSxFG56nObRYHgOMMHdlydFmviFOR1kbitqXI',2),(62,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI1MjYxNTMsImV4cCI6MTczMjYxMjU1M30.8fXWNbu1yrGTEEUYiB8Nx38Eu7R9rHaHdkUaR6a-shUk9UMQJcGnvwR0MbI-Jqr9',3),(63,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI1MjYxODgsImV4cCI6MTczMjYxMjU4OH0.We9qA4yA-iQXJTgGN_-eCWZL9Cvnm3JM6g841If5DjCZ730kwGvmt57MXPFNl7rD',2),(64,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI1Mjc2OTYsImV4cCI6MTczMjYxNDA5Nn0.d6lhxc-X5xzBoT7kAb0VbIKx_Z5wKPVtxA90TtDrM-NTZhMnMpGTTit4uzQkdNTl',2),(65,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI1MjgwNDQsImV4cCI6MTczMjYxNDQ0NH0.whaBC0-jWiETBrHil7UivOJpBHF3kxV-bWN_eBcgs-dJxrWrIJ3oSDnegCWO9Mcg',2),(66,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI1MzA4OTMsImV4cCI6MTczMjYxNzI5M30.zmocNvElM7beSo8Y03gTdF5x4WCQm0U5guF0Ou2YHwu3deLXOS83bWmkxDfDnsOy',2),(67,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI1MzEyMDAsImV4cCI6MTczMjYxNzYwMH0.EBUFVOaFMHPKsABvPWF4YoR1zRFzwx1-XKAlXljenY5k-R3u1nBGOMYKOJsawiGH',2),(68,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI1MzIwNjUsImV4cCI6MTczMjYxODQ2NX0.RPue1Y8h-xpa-ZEpWhPfTQLsFs_vgFDBAotUqzjOsFoUbMzHH_Zw9YKImm--H_o5',2),(69,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI1MzIwODMsImV4cCI6MTczMjYxODQ4M30.ELYMfTeDA9xDtWMuiJvE1Ap09EqKrARhxd-vfKcj4li01x5qH_QpStMZKPWXXZ7a',2),(70,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTI4NTcsImV4cCI6MTczMjY5OTI1N30.fAhRCadCd4QSr2s3x4V9W39s0SdzPufRjLFESoQFc-hUUAarxviLsOSgamitFb0b',3),(71,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTI5NDUsImV4cCI6MTczMjY5OTM0NX0.imPT5X0Sr3Ims1La5uDuzBQQ6p8Y_5YU1dAwWd_VeEwv3FQxG5V2CzyYk5dSyRc7',3),(72,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI2MTI5NTUsImV4cCI6MTczMjY5OTM1NX0.oypy3Z4hFme21CGzm-BCTmJUdFa2t3T-L-NmHSmi8W_x2-y9xtr3oA6gOoTiNKL_',2),(73,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtcmFobWVkMTc5NkBnbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTUwNzksImV4cCI6MTczMjcwMTQ3OX0.A32g_XOF0C4kUFm3H4Z0_qRnZzUvIVUgbAcp8N0N5mZVqACYZZ2P4kPeJP32MVfH',9),(74,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtcmFobWVkMTc5NkBnbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTUzMDAsImV4cCI6MTczMjcwMTcwMH0.ReoFkvBnp9wRTnflMakIT5Fm5_R5kf8zPiW7IRYjxHWAS0qoZJcFZ1_hQTUDCE1I',9),(75,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI2MTUzODksImV4cCI6MTczMjcwMTc4OX0.1I63OW2LwIFUW9uHuCVuAJ9r5r26pgIef8jIR6bTOsTbT3uQMzcTSyqT3WkJl3kJ',2),(76,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTU0MjgsImV4cCI6MTczMjcwMTgyOH0.vcTOhwCGd0rJ4trLiyXdbJMI13uUL-iJhEdyfKNNUuOnxBbv14xDiEWX69jNWh8a',3),(77,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtcmFobWVkMTc5NkBnbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTU1MTUsImV4cCI6MTczMjcwMTkxNX0.dTeMmhexO3tSFEsCktB7fjJDYJ6yW0cOMSk9xj8w96MOFU0pl1zvyDh7Q8MGizbn',9),(78,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI2MTU1NDIsImV4cCI6MTczMjcwMTk0Mn0.-LWrXXNEAgfcKi4IZzF25IuMar07ujWDrlqeGEm03HjqrYOj4aoH5jB431jCt1Ui',2),(79,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTY3MDksImV4cCI6MTczMjcwMzEwOX0.MKM7nOr3xqn-Yy7teBUKe3pXEvqijhMTcCUKHA8wsHT2TmRDxMAeX30YYRJeg48z',3),(80,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTcxMTEsImV4cCI6MTczMjcwMzUxMX0.uT5l2GoSGkPAPhill8pUYyW4TqqmkVVbf8lqS3M6B0kad2-U2OgbsQC2YZu5wkC9',3),(81,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI2MTczMDksImV4cCI6MTczMjcwMzcwOX0.CCcfmo653One8EVb_9zpEY22FOZLvhHMBK9OxIn1KLp9HEMYzHRzwoaZbJIBsKV8',2),(82,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhQG1haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNjE3MzE5LCJleHAiOjE3MzI3MDM3MTl9.Zgcgag5xIBjiwFCh0Z3HlYcq0Rkyuz6SB_IHvqvGm4KFemP5OTZjqdwO1Dojmey9',1),(83,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTc0MTUsImV4cCI6MTczMjcwMzgxNX0.O162ahRmZccWeweeuhrc4BH7LR24-IVFaV9SBx9hKYwso5-RtHjBb5fkntgyyUqL',3),(84,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXA0QG1haWwuY29tIiwicm9sZSI6IkVNUExPWUVFIiwiaWF0IjoxNzMyNjE3Njg3LCJleHAiOjE3MzI3MDQwODd9.kA8st1qvXGByJ3ArNz2pHVHjK3xPvunCd-rIj_SMzJkKrHmzc4Iw-Z-O4xW4iqtT',8),(85,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI2MTc3NDksImV4cCI6MTczMjcwNDE0OX0.gvyTKujj9hDhDRVEz9-NdBBSDyW7wOB1VFxyOxps32NWK8PpJf24gz-TfSLSHV4o',2),(86,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTg0MzIsImV4cCI6MTczMjcwNDgzMn0.NmpDQv7NwUjeyL_3c2HeP9SNJC2Dkfawa2ZR8bQ8EXCij9OA0g1G5TinZgjryHxH',3),(87,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTg0NDksImV4cCI6MTczMjcwNDg0OX0.D6WUXh64PXov9Hz8D0Ae_XmMUydvnENQsLRZo0IdAKAJwAamyzDKl0Okh5_JgIF3',3),(88,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTg2OTEsImV4cCI6MTczMjcwNTA5MX0.pQ3zflWxN_JrC4bzP8jm1auobWM02nmeBqm8ru8HhASalZFFTdIE5QrbMLkBG7YK',3),(89,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTg2OTAsImV4cCI6MTczMjcwNTA5MH0.J8tIjqE32XpF_3xZrQ_mdyCyLFV6RUxEpCWnrhJRs32Fnaws1honwEGhMfgM8uee',3),(90,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTg2OTEsImV4cCI6MTczMjcwNTA5MX0.pQ3zflWxN_JrC4bzP8jm1auobWM02nmeBqm8ru8HhASalZFFTdIE5QrbMLkBG7YK',3),(91,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTg4MDYsImV4cCI6MTczMjcwNTIwNn0.B8Ks2jy76X9QiA9QDH8IzKkFhQ3eobi_SxZ0ztYhvqVAIiWtyvx2XNgHOJ8DPTeK',3),(92,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MTk2NDYsImV4cCI6MTczMjcwNjA0Nn0.VVjmclBb3sUtQmgzVPJmc0zeNIy5wHnnDl-mXZMKzyozSzI566pFOqE9bG365jNt',3),(93,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjE3MjEsImV4cCI6MTczMjcwODEyMX0.FUa4fNsSimrkU__P3W4U3kL3htFeL-xVXRpebJ5kJmWvF-a4r2EXApkVKQKR3ogt',3),(94,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjIwNTQsImV4cCI6MTczMjcwODQ1NH0.UYz2H0-PoLI30fI98y5VSn26Szj9TDjIoSVG8JQsR7vtGafNlBZCJ5COjmfQQldA',3),(95,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjQ1NzgsImV4cCI6MTczMjcxMDk3OH0.ZB9SMPs-NtUt4B1MKxqovELdVQaV7IjNurdo281SPlXYu1pScGmOOVkLrA5ED5NJ',3),(96,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjQ1NzYsImV4cCI6MTczMjcxMDk3Nn0.iAgYor2IFDgGTKub-kWxfV4TGWL00HvACxRXhI5dL--_qmSv72d7jdzjXIg4EgIA',3),(97,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjUwOTgsImV4cCI6MTczMjcxMTQ5OH0.LhaX-GRlUC7_emn2Vm4Ml5y9Y1b4nopFZqW7oXFFoTiKqsQxiCKKREfBjAlDTIZu',3),(98,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjUyOTYsImV4cCI6MTczMjcxMTY5Nn0.tMheHdsSo61_D4wO7u0ExRDzRHpdKymq3w0tIJ6C09nz5ZbvbrUfzlULwVg_Iwq4',3),(99,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjUzMjIsImV4cCI6MTczMjcxMTcyMn0.DlrhUSKMZV_VL-lJbGcL8r3u9XXTfhSqSvfwu9uih44hn0mBRMIBKLSgVZdMR_Y0',3),(100,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjUzNzYsImV4cCI6MTczMjcxMTc3Nn0.7S0UXtCPuEXJ929gXXbTv0cnkTS0hP-FKwEzHgSu14k6Ax9PxED1YxK4cK6_9TgN',3),(101,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjU1MDgsImV4cCI6MTczMjcxMTkwOH0.6Aex2H1yxjzDgvVF22oQGsv7We85QGEVB2_ihjeH1hfbeoZI0jUkLdMLsGfXyjZl',3),(102,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjU1NDAsImV4cCI6MTczMjcxMTk0MH0.ZbrfH-Wo-ZJ8WTTmPGXv1nP_7yTXayfmx4cz1ZsYMs60jD3IS8Jwnq8tvPrR3XKB',3),(103,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjYwODIsImV4cCI6MTczMjcxMjQ4Mn0.0KKmRSIVtCn7-0PYhpR2JNo5eERpHvGgBdkvAu_960tZyvclAc14BBoWVdiaxvWo',3),(104,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjYxNzksImV4cCI6MTczMjcxMjU3OX0.SdCKSzxa0tySGlpZ1vPU0Dma52d2z5S-hkSDXeEz9TFQpbbHIh-n6jZAy6vhytVu',3),(105,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjYyMTYsImV4cCI6MTczMjcxMjYxNn0.6qZyrlIhSDrNV1hyrvNzH4_VihBOgJCpugnbj2O3j-AqY6_Y8R2svjPuXGxJytNd',3),(106,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjYyNDAsImV4cCI6MTczMjcxMjY0MH0.O2oN186Ssadc-s-70OlkKxwmZ-fhZ2bzzaQiDlREz0z21ylKpQvOgLV9z4lbgJmY',3),(107,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjYyNjEsImV4cCI6MTczMjcxMjY2MX0.bhyiqufbhR7gC0QW2De1USfA6Q_K9UY_r9BX5vWUfcot7iZLa1PVIuYSUoKxjIAb',3),(108,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjYyNzEsImV4cCI6MTczMjcxMjY3MX0.nGQBCK3SNnnOnUdKRSSIbDW3ECKNY8Gi_mcGk0aTEEsRlRTmyAn21t7uG6l3i7cr',3),(109,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2MjY5NjAsImV4cCI6MTczMjcxMzM2MH0.Z74uiqP4JWanMlpob-UgynofGiTvWG-EJ_2w9P_CdomN_MIJMVqcydtDAHtVz-o3',3),(110,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJlbXBAbWFpbC5jb20iLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE3MzI2OTg4MjcsImV4cCI6MTczMjc4NTIyN30.4gEzCULM8R_DjRHOblbQuWqXM1jUPNxRJ20jMNeANhpwh6KqR6mZB8jb92M7uol8',3),(111,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI2OTg5MzEsImV4cCI6MTczMjc4NTMzMX0.UOnTWlre03t_xyLCDavLHtqoUGcBw3h1_s40ZlIFm72iblVi2YQY56dV9EgMkXoe',2),(112,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI2OTk1MzYsImV4cCI6MTczMjc4NTkzNn0.Z3o7zkTa6M0u9u-luCxonB3DkgMSUULy3CImU6KlVdyzl1OKYh4eETzuS9TPBD9k',2),(113,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI2OTk4OTQsImV4cCI6MTczMjc4NjI5NH0.wbkPg8jqKd583DVGR5-SWAJC80Hm-5Vbln4ENjCdbssjutl8XtOeTJVwLoJAk1Zc',2),(114,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI3MDM0NTUsImV4cCI6MTczMjc4OTg1NX0.LntZ6-BZ4IXkRhT_sluwPTazNYallyWXCde30IbZIwe-Ydt1f_eNS426j4KoclM1',2),(115,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI3MDQwMjgsImV4cCI6MTczMjc5MDQyOH0.mph3Amf44Fjaz6xLSA_qzxziYaPdCo5Purb1gkLKgqcvwo2Y5k4XWG3yL36GvJ--',2),(116,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtQG1haWwuY29tIiwicm9sZSI6Ik1BTkFHRVIiLCJpYXQiOjE3MzI3MDYxOTIsImV4cCI6MTczMjc5MjU5Mn0.jHJvuhJGFOuns2mUDS99tAFUtc82oibtOOupuLaILxJGq_lmC60i4ftj4wHo4kcC',2);
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
INSERT INTO `user_leave_balance` VALUES (3,15,0),(3,30,1),(3,10,2),(5,15,0),(5,30,1),(5,10,2),(6,15,0),(6,30,1),(6,10,2),(7,15,0),(7,30,1),(7,10,2),(8,15,0),(8,30,1),(8,10,2),(9,15,0),(9,30,1),(9,10,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,_binary '','Dhaka',50000,'017000000','2006-11-02','a@mail.com','Male',_binary '\0','2024-11-13','Tamim','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','ADMIN'),(2,_binary '','Dhaka',50000,'017000001','2006-11-02','m@mail.com','Male',_binary '\0','2024-11-13','Ahmed','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','MANAGER'),(3,_binary '','Dhaka',50000,'017000002','2006-11-02','emp@mail.com','Male',_binary '\0','2024-11-13','Raju','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(5,_binary '','Dhaka',50000,'017000003','2006-11-02','emp1@mail.com','Male',_binary '\0','2024-11-13','Rezvi','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(6,_binary '','Dhaka',50000,'017000004','2006-11-02','emp2@mail.com','Male',_binary '\0','2024-11-13','Nusrat','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(7,_binary '','Dhaka',50000,'017000005','2006-11-02','emp3@mail.com','Male',_binary '\0','2024-11-13','Shabab','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(8,_binary '','Dhaka',50000,'017000006','2006-11-02','emp4@mail.com','Male',_binary '\0','2024-11-13','Sanaullah','$2a$10$rClfwbBtWXOQt.eC89bD9OIXalKwl1e1k0gyZczVQzwHTqXVEWZpe','1731549128620_upload.jpg','EMPLOYEE'),(9,_binary '','Dhaka, Bangladesh',56000,'01700009999','2024-11-01','mrahmed1796@gmail.com','Male',_binary '\0','2024-11-26','Md Raju Ahmed','$2a$10$plMla.PnJ0MbxrOXKXzKG.c/zgfXr/JdeSXQ/0Upbw8WXvMsPH8zK','Test_Name_8aba9cab-80a0-4576-97a0-af5ec8c52245.jpg','EMPLOYEE');
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

-- Dump completed on 2024-11-27 18:25:46
