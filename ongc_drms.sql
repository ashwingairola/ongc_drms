CREATE DATABASE  IF NOT EXISTS `ongc_drms` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ongc_drms`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ongc_drms
-- ------------------------------------------------------
-- Server version	5.7.18-log

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
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `userid` varchar(20) NOT NULL,
  `passwd` varchar(32) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `midname` varchar(100) DEFAULT NULL,
  `surname` varchar(100) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `designation` varchar(45) DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request` (
  `request_id` varchar(20) NOT NULL,
  `userid` varchar(20) NOT NULL,
  `location` varchar(45) NOT NULL,
  `request_list` varchar(1000) NOT NULL,
  `is_level1_approved` tinyint(4) DEFAULT '0',
  `is_level2_approved` tinyint(4) DEFAULT '0',
  `is_level3_approved` tinyint(4) DEFAULT '0',
  `is_rejected` tinyint(4) DEFAULT '0',
  `date_issued` date NOT NULL,
  `date_approved1` date DEFAULT NULL,
  `date_approved2` date DEFAULT NULL,
  `date_approved3` date DEFAULT NULL,
  `approver1_id` varchar(20) DEFAULT NULL,
  `approver2_id` varchar(20) DEFAULT NULL,
  `approver3_id` varchar(20) DEFAULT NULL,
  `is_dispatched` tinyint(4) DEFAULT '0',
  `courier_id` varchar(20) DEFAULT NULL,
  `date_dispatched` date DEFAULT NULL,
  `status` text,
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-27 13:08:40
