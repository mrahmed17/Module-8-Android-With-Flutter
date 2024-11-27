-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dbcrud
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
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Najmul','najmul@gmail.com','Dhanmondi, Dhaka'),(2,'Kutub','kutub@gmail.com','Dhanmondi, Dhaka'),(3,'Tamim Ahmed Raju','tamimahmed@gmail.com','Azimpur, Dhaka'),(4,'Rezvi','rezvi@gmail.com','Azimpur, Dhaka'),(5,'Nusrat','nusrat@gmail.com','Mirpur, Dhaka'),(6,'Tawhid','tawhid@gmail.com','Dhanmondi, Dhaka'),(7,'Shabab','shabab@gmail.com','Kollanpur, Dhaka'),(8,'Shamima','shamima@gmail.com','Kollanpur, Dhaka'),(9,'Nyamul','nyamul@gmail.com','MDpur, Dhaka'),(10,'Nirjash','nirjash@gmail.com','Panthapath, Dhaka'),(11,'Rafiqul','rafiqul@gmail.com','Panthapath, Dhaka'),(12,'Rabiul','rabiul@gmail.com','MDpur, Dhaka'),(13,'Sanaullah','sanaullah@gmail.com','Dhanmondi, Dhaka'),(14,'Muhammad Emran ','mdemran@gmail.com','Malibag, Dhaka'),(15,'Aminul','aminul@gmail.com','MDpur, Dhaka');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `cell` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'Raju','Raju@gmail.com','Azimpur, Dhaka','416406465'),(2,'Nusrat','Nusrat@gmail.com','Mirpur','416406465'),(3,'Rezvi','rezvi@gmail.com','Azimpur, Dhaka','98656465'),(5,'Najmul','najmul@gmail.com','Dhanmondi','+90464'),(6,'Shabab','shabab@gmail.com','Kollanpur','26465'),(7,'Shamima','shamima@gmail.com','Kollanpur','6426146'),(8,'Tawhid','tawhid@gmail.com','Dhanmondi ','64641654'),(9,'Nusu','nusu@gmail.com','Mohammadpur ','654665213'),(10,'Nyamul','nyamul@gmail.com','MDpur','654461132'),(11,'Nirjash','nirjash@gmail.com','Panthapath','66655654'),(12,'Rafiqul','rafiqul@gmail.com','Panthapath','54646554'),(13,'Rabiul','rabiul@gmail.com','MDpur','6465654654654'),(14,'Sanaullah','sanaullah@gmail.com','Dhanmondi','98154'),(15,'Kutub','kutub@gmail.com','Dhanmondi ','45665456454');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-27 18:26:04
