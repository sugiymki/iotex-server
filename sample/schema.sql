-- MySQL dump 10.18  Distrib 10.3.27-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: iotex
-- ------------------------------------------------------
-- Server version	10.3.27-MariaDB-0+deb10u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `monitoring`
--

DROP TABLE IF EXISTS `monitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring` (
  `hostname` varchar(20) CHARACTER SET utf8 NOT NULL,
  `time` datetime NOT NULL,
  `temp` double DEFAULT NULL,
  `temp2` double DEFAULT NULL,
  `temp3` double DEFAULT NULL,
  `humi` double DEFAULT NULL,
  `humi2` double DEFAULT NULL,
  `humi3` double DEFAULT NULL,
  `dp` double DEFAULT NULL,
  `dp2` double DEFAULT NULL,
  `dp3` double DEFAULT NULL,
  `bmptemp` double DEFAULT NULL,
  `dietemp` double DEFAULT NULL,
  `lux` double DEFAULT NULL,
  `objtemp` double DEFAULT NULL,
  `pres` double DEFAULT NULL,
  `sitemp` double DEFAULT NULL,
  `sihumi` double DEFAULT NULL,
  `eco2` double DEFAULT NULL,
  `tvoc` double DEFAULT NULL,
  `winddir` double DEFAULT NULL,
  `windvel` double DEFAULT NULL,
  PRIMARY KEY (`hostname`, `time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitoring_hosts`
--

DROP TABLE IF EXISTS `monitoring_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring_hosts` (
  `hostname` varchar(20) NOT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`hostname`)
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

-- Dump completed on 2021-10-04 23:59:03
