-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: dadi-submission
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `grups`
--

DROP TABLE IF EXISTS `grups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grups` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Nama` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grups`
--

LOCK TABLES `grups` WRITE;
/*!40000 ALTER TABLE `grups` DISABLE KEYS */;
INSERT INTO `grups` VALUES (1,'Telkom'),(2,'Telkomsel');
/*!40000 ALTER TABLE `grups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Nama` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Planner'),(2,'Designer'),(3,'Tester'),(4,'Executor');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subgrups`
--

DROP TABLE IF EXISTS `subgrups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subgrups` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Nama` varchar(100) NOT NULL,
  `GrupId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_GrupID` (`GrupId`),
  CONSTRAINT `FK_GrupID` FOREIGN KEY (`GrupId`) REFERENCES `grups` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subgrups`
--

LOCK TABLES `subgrups` WRITE;
/*!40000 ALTER TABLE `subgrups` DISABLE KEYS */;
INSERT INTO `subgrups` VALUES (1,'Consumer services',1),(2,'IT & Solution',1),(3,'Digital business',2),(4,'HCM',2);
/*!40000 ALTER TABLE `subgrups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Nama` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `Telepon` varchar(50) NOT NULL,
  `TanggalLahir` date NOT NULL,
  `RoleId` int(11) NOT NULL,
  `SubGrupId` int(11) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_RoleId` (`RoleId`),
  KEY `FK_SubGrupID` (`SubGrupId`),
  CONSTRAINT `FK_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`Id`),
  CONSTRAINT `FK_SubGrupID` FOREIGN KEY (`SubGrupId`) REFERENCES `subgrups` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (11,'admin','admin','admin@inagri','sha256$Wm3MBLgmXRayKygV$fc263ca040ceaea325c04f9bae6cfd26553329bcd5f18f7cde06b9735b1eb6a3','02112345','2001-01-01',2,2,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'dadi-submission'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-03 15:40:37
