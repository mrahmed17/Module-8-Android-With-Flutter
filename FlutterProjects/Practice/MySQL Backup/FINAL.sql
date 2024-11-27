-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: final
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
-- Table structure for table `advance`
--

DROP TABLE IF EXISTS `advance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(38,2) DEFAULT NULL,
  `employee_id` bigint DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKh62etjlrdxk656bate70uf86d` (`employee_id`),
  CONSTRAINT `FKh62etjlrdxk656bate70uf86d` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advance`
--

LOCK TABLES `advance` WRITE;
/*!40000 ALTER TABLE `advance` DISABLE KEYS */;
INSERT INTO `advance` VALUES (1,250.00,3,'afd','2024-10-02'),(2,300.00,4,'asdf','2024-10-02'),(3,5000.00,5,'adsf','2024-10-02'),(4,2500.00,7,'Sick','2024-10-02'),(5,5000.00,3,'adf','2024-10-02'),(6,5000.00,4,'safds','2024-10-02'),(7,5000.00,3,'jhfkjad','2024-10-02');
/*!40000 ALTER TABLE `advance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `check_in` datetime(6) DEFAULT NULL,
  `check_out` datetime(6) DEFAULT NULL,
  `empid` bigint DEFAULT NULL,
  `check_in_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKf7s4sspd4ho3qgli0jtstoje3` (`empid`),
  CONSTRAINT `FKf7s4sspd4ho3qgli0jtstoje3` FOREIGN KEY (`empid`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (1,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',3,'2024-10-02'),(2,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',5,'2024-10-02'),(3,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',3,'2024-10-02'),(4,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',3,'2024-10-02'),(5,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',3,'2024-10-02'),(6,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',3,'2024-10-02'),(7,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',5,'2024-10-02'),(8,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',5,'2024-10-02'),(9,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',5,'2024-10-02'),(10,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',5,'2024-10-02'),(18,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',5,'2024-10-02'),(19,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',5,'2024-10-02'),(20,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',5,'2024-10-02'),(21,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',5,'2024-10-02'),(22,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',5,'2024-10-02'),(23,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',3,'2024-10-02'),(24,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',3,'2024-10-02'),(25,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',3,'2024-10-02'),(26,'2024-10-02 00:00:00.000000','2024-10-02 00:00:00.000000',4,'2024-10-02'),(28,'2024-10-02 15:22:45.214000','2024-10-02 15:22:45.214000',3,NULL),(29,'2024-10-02 15:38:43.240000','2024-10-02 15:38:43.240000',3,NULL),(30,'2024-10-02 15:38:46.285000','2024-10-02 15:38:46.285000',4,NULL),(31,'2024-10-02 15:38:49.690000','2024-10-02 15:38:49.690000',5,NULL);
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bonus`
--

DROP TABLE IF EXISTS `bonus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bonus` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(38,2) DEFAULT NULL,
  `employee_id` bigint DEFAULT NULL,
  `bonus_date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4518bv68y4abo4muqqqrurlhn` (`employee_id`),
  CONSTRAINT `FK4518bv68y4abo4muqqqrurlhn` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bonus`
--

LOCK TABLES `bonus` WRITE;
/*!40000 ALTER TABLE `bonus` DISABLE KEYS */;
INSERT INTO `bonus` VALUES (3,450.00,5,'2024-10-02'),(5,25000.00,3,'2024-10-02'),(6,500.00,4,'2024-10-02'),(7,500.00,7,'2024-10-02'),(8,250.00,6,'2024-10-02'),(9,5000.00,3,'2024-10-02'),(10,5000.00,3,'2024-10-02');
/*!40000 ALTER TABLE `bonus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'JAVA'),(2,'NT'),(3,'Graphics'),(4,'c#'),(5,'Web');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_leave`
--

DROP TABLE IF EXISTS `emp_leave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp_leave` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contact` varchar(255) DEFAULT NULL,
  `leave_date` varchar(255) DEFAULT NULL,
  `leave_reason` varchar(255) DEFAULT NULL,
  `employee_id` bigint DEFAULT NULL,
  `is_grant` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKtgxwanjnsn616t5kt97rod34q` (`employee_id`),
  CONSTRAINT `FKtgxwanjnsn616t5kt97rod34q` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_leave`
--

LOCK TABLES `emp_leave` WRITE;
/*!40000 ALTER TABLE `emp_leave` DISABLE KEYS */;
INSERT INTO `emp_leave` VALUES (1,'45646464','2024-10-02','sick',3,_binary ''),(2,'1131464646','2024-10-02','sick',4,_binary ''),(3,'465421','2024-10-02','sick',4,_binary ''),(6,'545123','2024-10-02','sick',3,_binary '\0'),(7,'5456564','2024-10-02','adf',4,_binary ''),(8,'4654561','2024-10-02','klajflk',3,_binary '');
/*!40000 ALTER TABLE `emp_leave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contact` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `joining_date` date NOT NULL,
  `name` varchar(255) NOT NULL,
  `salary` varchar(255) NOT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_fopic1oh5oln2khj8eat6ino0` (`email`),
  KEY `FKbejtwvg9bxus2mffsm3swj3u9` (`department_id`),
  CONSTRAINT `FKbejtwvg9bxus2mffsm3swj3u9` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (3,'1234567890','raju@example.com','male','2022-01-01','Raju','5000',1),(4,'254844454545','mostafa@gmail.com','male','2024-02-12','Mostofa','25000',3),(5,'0136946464','shabab@gmail.com','male','2024-02-20','Shabab','23000',2),(6,'01303686210','nusrat@gmail.com','female','2024-02-21','Nusrat','15000',2),(7,'01303686210','shamima@gmail.com','female','2024-02-14','Shamima','15000',2);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salary`
--

DROP TABLE IF EXISTS `salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salary` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(38,2) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `employee_id` bigint DEFAULT NULL,
  `total_amount` decimal(38,2) DEFAULT NULL,
  `emp_advance` decimal(38,2) DEFAULT NULL,
  `emp_bonus` decimal(38,2) DEFAULT NULL,
  `total_salary` decimal(38,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKnlnv3jbyvbiu8ci59r3btlk00` (`employee_id`),
  CONSTRAINT `FKnlnv3jbyvbiu8ci59r3btlk00` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary`
--

LOCK TABLES `salary` WRITE;
/*!40000 ALTER TABLE `salary` DISABLE KEYS */;
INSERT INTO `salary` VALUES (2,12500.00,'2024-10-02',4,12200.00,NULL,NULL,12200.00),(4,25000.00,'2024-10-02',5,25900.00,NULL,NULL,25900.00),(5,2500.00,'2024-10-02',3,2250.00,NULL,NULL,2250.00),(6,2500.00,'2024-10-02',3,2250.00,NULL,NULL,2250.00),(7,2500.00,'2024-10-02',3,2250.00,NULL,NULL,2250.00),(8,23000.00,'2024-10-02',5,5000.00,NULL,NULL,NULL),(9,23000.00,'2024-10-02',5,2250.00,NULL,NULL,2250.00),(17,5000.00,'2024-10-02',3,5000.00,250.00,25000.00,29750.00),(18,5000.00,'2024-10-02',3,NULL,250.00,25000.00,28700.00),(19,50000.00,'2024-10-02',3,NULL,5000.00,5000.00,499999950.00);
/*!40000 ALTER TABLE `salary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `emp_id` bigint DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `FKpgwd5fnhtf1rxclepvtva55rp` (`emp_id`),
  CONSTRAINT `FKpgwd5fnhtf1rxclepvtva55rp` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'1234',3),(2,'1234',3),(3,'1234',4);
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

-- Dump completed on 2024-11-27 18:26:19
