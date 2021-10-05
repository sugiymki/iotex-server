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
-- Table structure for table `monitoring_rooms_id`
--

DROP TABLE IF EXISTS `monitoring_rooms_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring_rooms_id` (
  `id` varchar(40) DEFAULT NULL,
  `hostname` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitoring_rooms_id`
--

LOCK TABLES `monitoring_rooms_id` WRITE;
/*!40000 ALTER TABLE `monitoring_rooms_id` DISABLE KEYS */;
INSERT INTO `monitoring_rooms_id` VALUES ('iot-01','27893d12'),('iot-02','abe56d67'),('iot-03','6c7e9aee'),('iot-04','9f046622'),('iot-05','5440d451'),('iot-06','c4e4ed56'),('iot-07','a65ee1de'),('iot-08','5d1826ea'),('iot-09','98d78759'),('iot-10','54a2675d'),('iot-11','1a1a7cda'),('iot-12','6c64adcc'),('iot-13','00cd3759'),('iot-15','6a892e31'),('iot-16','f2c2c25d'),('iot-17','93098e0d'),('iot-18','f0b2976e'),('iot-19','122ebae8'),('iot-20','6a20b11c'),('iot-21','32155501'),('iot-22','d487c535'),('iot-23','9b04fb4e'),('iot-24','89b7d77f'),('iot-25','1d7c9119'),('iot-26','19d441af'),('iot-27','7e0e62c9'),('iot-28','e99f6e64'),('iot-29','d1aee7c7'),('iot-30','7577731d'),('iot-31','5fb00178'),('iot-32','892cd2df'),('iot-33','4259cd8d'),('iot-34','7510365b'),('iot-35','dd8e189d'),('iot-36','d0477b1a'),('iot-37','b22f0f1b'),('iot-38','3c177d2f'),('iot-39','9478291c'),('iot-40','b0b377df'),('iot-41','3339b209'),('iot-42','228a1f97'),('iot-43','f45d08cf'),('iot-44','8698b463'),('iot-45','eb58b8de'),('iot-49','42fab4cd'),('iot-50','50eca8c6'),('iot-52','33eb3c39');
/*!40000 ALTER TABLE `monitoring_rooms_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitoring_rooms_names`
--

DROP TABLE IF EXISTS `monitoring_rooms_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring_rooms_names` (
  `id` varchar(40) DEFAULT NULL,
  `name_ja` varchar(20) DEFAULT NULL,
  `name_en` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitoring_rooms_names`
--

LOCK TABLES `monitoring_rooms_names` WRITE;
/*!40000 ALTER TABLE `monitoring_rooms_names` DISABLE KEYS */;
INSERT INTO `monitoring_rooms_names` VALUES ('iot-01','211講義室','211'),('iot-02','212講義室','212'),('iot-03','213講義室','213'),('iot-04','214講義室','214'),('iot-05','215講義室','215'),('iot-06','221講義室','221'),('iot-07','222講義室','222'),('iot-08','223講義室','223'),('iot-09','224講義室','224'),('iot-10','225講義室','225'),('iot-11','231講義室(1組)前','231'),('iot-12','232講義室(2組)','232'),('iot-13','233講義室(3組)','233'),('iot-14','知識工学実験室(杉山実験室)','sugiyama-lab'),('iot-15','234講義室(4組)','234'),('iot-16','235講義室(5組)前','235'),('iot-17','220講義室','220'),('iot-18','マルチメディア演習室','pc-bld4-4F'),('iot-19','創造演習室','tech-0'),('iot-20','共通工学実験室1','tech-1'),('iot-21','320講義室','320'),('iot-22','236講義室','236'),('iot-23','共通工学実験室2','tech-2'),('iot-24','共通工学実験室3','tech-3'),('iot-25','441講義室','441'),('iot-26','442講義室','442'),('iot-27','511講義室','511'),('iot-28','512講義室','512'),('iot-29','521講義室','521'),('iot-30','522講義室','522'),('iot-31','541講義室','541'),('iot-32','情報処理演習室','pc-bld5-3F'),('iot-33','651ゼミナール室','651'),('iot-34','421講義室','421'),('iot-35','652ゼミナール室','652'),('iot-36','1棟1階玄関','hall-bld1-1F'),('iot-37','2棟1階階段前','hall-bld2-1F'),('iot-38','2棟2階階段前','hall-bld2-2F'),('iot-39','2棟3階階段前','hall-bld2-3F'),('iot-40','3棟1階階段前','hall-bld3-1F'),('iot-41','3棟2階階段前','hall-bld3-2F'),('iot-42','3棟3階階段前','hall-bld3-3F'),('iot-43','共通CAD演習室','pc-bld2-2F'),('iot-44','231講義室(1組)後','231b'),('iot-45','235講義室(5組)後','235b'),('iot-46','屋外(SHT75+通風筒)','roof-sht75'),('iot-47','屋外(近藤式通風温度計)','roof-kondo'),('iot-48','223講義室後','223b'),('iot-49','事務部学生課','jimu-gakusei'),('iot-50','事務部総務課','jimu-soumu2'),('iot-51','542 教員室','542 teacher room'),('metpak','屋外(MetPak)','roof-metpak'),('iot-52','542教員室','542 Lab');
/*!40000 ALTER TABLE `monitoring_rooms_names` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-05 22:37:06
