-- MySQL dump 10.16  Distrib 10.1.26-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: iotex
-- ------------------------------------------------------
-- Server version	10.1.26-MariaDB-0+deb9u1


--
-- Table structure for table `monitoring`
--

DROP TABLE IF EXISTS `monitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring` (
  `hostname` varchar(20) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
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
  PRIMARY KEY (`hostname`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitoring_10min`
--

DROP TABLE IF EXISTS `monitoring_10min`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring_10min` (
  `hostname` varchar(20) NOT NULL,
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
  `pres` double DEFAULT NULL,
  `bmptemp` double DEFAULT NULL,
  `dietemp` double DEFAULT NULL,
  `objtemp` double DEFAULT NULL,
  `sitemp` double DEFAULT NULL,
  `sihumi` double DEFAULT NULL,
  `eco2` double DEFAULT NULL,
  `tvoc` double DEFAULT NULL,
  `lux` double DEFAULT NULL,
  `didx` double DEFAULT NULL,
  `didx2` double DEFAULT NULL,
  `didx3` double DEFAULT NULL,
  PRIMARY KEY (`hostname`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `monitoring_1hour`
--

DROP TABLE IF EXISTS `monitoring_1hour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring_1hour` (
  `hostname` varchar(20) NOT NULL,
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
  `pres` double DEFAULT NULL,
  `bmptemp` double DEFAULT NULL,
  `dietemp` double DEFAULT NULL,
  `objtemp` double DEFAULT NULL,
  `sitemp` double DEFAULT NULL,
  `sihumi` double DEFAULT NULL,
  `eco2` double DEFAULT NULL,
  `tvoc` double DEFAULT NULL,
  `lux` double DEFAULT NULL,
  `didx` double DEFAULT NULL,
  `didx2` double DEFAULT NULL,
  `didx3` double DEFAULT NULL,
  PRIMARY KEY (`hostname`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `monitoring_hosts`
--

DROP TABLE IF EXISTS `monitoring_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring_hosts` (
  `hostname` varchar(20) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`hostname`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

