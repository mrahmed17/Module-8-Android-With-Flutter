-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: practice2
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
  PRIMARY KEY (`id`),
  KEY `FK8o39cn3ghqwhccyrrqdesttr8` (`user_id`),
  CONSTRAINT `FK8o39cn3ghqwhccyrrqdesttr8` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendances`
--

LOCK TABLES `attendances` WRITE;
/*!40000 ALTER TABLE `attendances` DISABLE KEYS */;
INSERT INTO `attendances` VALUES (1,'2024-09-13 08:30:00.000000','2024-09-13 18:30:00.000000','2024-09-13',1),(2,'2024-09-13 08:30:00.000000','2024-09-13 18:30:00.000000','2024-09-13',2),(3,'2024-09-13 08:30:00.000000','2024-09-13 18:30:00.000000','2024-09-13',1),(4,'2024-09-13 08:30:00.000000','2024-09-13 18:30:00.000000','2024-09-13',2),(5,'2024-09-14 11:57:45.368025','2024-09-14 11:57:54.741494','2024-09-14',2),(6,'2024-09-14 12:07:23.431262','2024-09-14 12:07:27.968757','2024-09-14',5),(7,'2024-09-14 12:07:31.963883','2024-09-14 12:07:35.846880','2024-09-14',6),(8,'2024-09-14 12:14:14.052186','2024-09-14 12:39:00.114705','2024-09-14',14),(9,'2024-09-14 12:14:27.963590','2024-09-14 12:16:01.010486','2024-09-14',4),(10,'2024-09-14 12:16:37.857432','2024-09-14 12:16:41.719108','2024-09-14',13),(11,'2024-09-14 12:17:47.524288','2024-09-14 12:39:11.680718','2024-09-14',11),(24,'2024-09-14 15:30:35.503277','2024-09-14 15:31:00.443908','2024-09-14',21),(25,'2024-09-14 15:35:37.709919','2024-09-14 15:35:50.659470','2024-09-14',18),(26,'2024-09-14 15:36:38.859088','2024-09-14 15:36:43.739103','2024-09-14',10),(27,'2024-09-14 16:36:00.171869','2024-09-14 16:37:03.472962','2024-09-14',19),(28,'2024-09-14 16:37:43.201338','2024-09-14 16:37:57.205241','2024-09-14',17),(29,'2024-09-15 17:07:28.873986','2024-09-15 17:09:26.761652','2024-09-15',9),(30,'2024-09-15 17:07:58.861222','2024-09-15 17:09:17.369195','2024-09-15',1),(31,'2024-09-15 17:08:06.981550','2024-09-15 17:18:23.571774','2024-09-15',4),(32,'2024-09-15 17:08:14.228569','2024-09-15 17:18:34.962622','2024-09-15',6),(33,'2024-09-15 17:08:24.444831','2024-09-15 17:09:36.194772','2024-09-15',10),(34,'2024-09-15 17:08:31.563874','2024-09-15 17:09:44.618128','2024-09-15',11),(35,'2024-09-15 17:08:37.098542','2024-09-15 17:09:50.161798','2024-09-15',13),(36,'2024-09-15 17:08:47.756154','2024-09-15 17:10:12.579126','2024-09-15',19),(37,'2024-09-15 17:08:53.563606','2024-09-15 17:18:45.779648','2024-09-15',20),(38,'2024-09-15 17:08:59.610377','2024-09-15 17:18:51.026371','2024-09-15',21);
/*!40000 ALTER TABLE `attendances` ENABLE KEYS */;
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
  `is_approved` bit(1) NOT NULL,
  `leave_type` enum('RESERVE_UNPAID','SICK_PAID','SICK_UNPAID') DEFAULT NULL,
  `remaining_leave` int NOT NULL,
  `request_date` date DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKa3vfaevh5a44ccfq2wodxoxig` (`user_id`),
  CONSTRAINT `FKa3vfaevh5a44ccfq2wodxoxig` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaves`
--

LOCK TABLES `leaves` WRITE;
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
/*!40000 ALTER TABLE `leaves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contact` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `role` enum('ADMIN','COMPANY','EMPLOYEE','MANAGER','PAYROLL') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'45122625','raju@mail.com ','Raju','ADMIN'),(2,'123456','tamim@mail.com ','Tamim','MANAGER'),(3,'12325456','mrahmed@mail.com ','MRAhmed','COMPANY'),(4,'4512625','rezvi@mail.com ','Rezvi','EMPLOYEE'),(5,'12145625','nusrat@mail.com ','Nusrat','EMPLOYEE'),(6,'121625','neyamul@mail.com ','Neyamul','EMPLOYEE'),(9,'15646','towhid@gmail.com','Towhid Alam','EMPLOYEE'),(10,'13465','sanaullah@gmail.com','Sanaullah','EMPLOYEE'),(11,'45613','shabab@gmail.com','Shabab','EMPLOYEE'),(13,'232366','kututb@mail.com','Kutub Uddin','EMPLOYEE'),(14,'1321','rafiqul@mail.com','Rafiqul','EMPLOYEE'),(17,'13456','nirjash@mail.com','Nirjash','EMPLOYEE'),(18,'165646','nusu@mail.com','Nusu','EMPLOYEE'),(19,'794564','shamima@mail.com','Shamima','EMPLOYEE'),(20,'46123','najmul@mail.com','Najmul','EMPLOYEE'),(21,'78456','sir@mail.com','Sir Admin','PAYROLL');
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

-- Dump completed on 2024-11-27 18:27:59
