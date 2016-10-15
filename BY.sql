CREATE DATABASE  IF NOT EXISTS `wkud` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `wkud`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: wkud
-- ------------------------------------------------------
-- Server version	5.7.13-log

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
-- Table structure for table `保养`
--

DROP TABLE IF EXISTS `保养`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `保养` (
  `id保养` int(11) NOT NULL,
  `设备类别id` int(11) NOT NULL,
  `设备id` int(11) NOT NULL,
  `检修类型id` int(11) NOT NULL,
  PRIMARY KEY (`id保养`,`设备类别id`,`设备id`),
  KEY `FK2_idx` (`设备类别id`),
  KEY `FK3_idx` (`设备id`),
  KEY `FK4_idx` (`检修类型id`),
  CONSTRAINT `FK2` FOREIGN KEY (`设备类别id`) REFERENCES `设备类别` (`id设备类别`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK3` FOREIGN KEY (`设备id`) REFERENCES `设备` (`id设备`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK4` FOREIGN KEY (`检修类型id`) REFERENCES `检修类型` (`id检修类型`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `保养`
--

LOCK TABLES `保养` WRITE;
/*!40000 ALTER TABLE `保养` DISABLE KEYS */;
INSERT INTO `保养` VALUES (2,2,2,3),(1,1,1,5);
/*!40000 ALTER TABLE `保养` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `保养记录`
--

DROP TABLE IF EXISTS `保养记录`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `保养记录` (
  `id保养记录` int(11) NOT NULL,
  `保养id` int(11) NOT NULL,
  `保养人` varchar(10) NOT NULL,
  `保养日期` date NOT NULL,
  `保养班组` varchar(20) NOT NULL,
  `备注` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id保养记录`,`保养id`),
  KEY `FK7_idx` (`保养id`),
  CONSTRAINT `FK7` FOREIGN KEY (`保养id`) REFERENCES `保养` (`id保养`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `保养记录`
--

LOCK TABLES `保养记录` WRITE;
/*!40000 ALTER TABLE `保养记录` DISABLE KEYS */;
INSERT INTO `保养记录` VALUES (1,1,'保养人1','2016-10-01','班组1',NULL),(2,1,'保养人1','2016-10-03','班组1',NULL),(3,1,'保养人1','2016-09-28','班组1',NULL),(4,2,'保养人2','2016-09-28','班组2',NULL);
/*!40000 ALTER TABLE `保养记录` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `保养项目`
--

DROP TABLE IF EXISTS `保养项目`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `保养项目` (
  `id保养项目` int(11) NOT NULL,
  `设备类别id` int(11) NOT NULL,
  `保养内容` varchar(100) NOT NULL,
  PRIMARY KEY (`id保养项目`),
  KEY `FK6_idx` (`设备类别id`),
  CONSTRAINT `FK6` FOREIGN KEY (`设备类别id`) REFERENCES `设备类别` (`id设备类别`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `保养项目`
--

LOCK TABLES `保养项目` WRITE;
/*!40000 ALTER TABLE `保养项目` DISABLE KEYS */;
INSERT INTO `保养项目` VALUES (1,1,'接线盒开盖检查'),(2,1,'电机电缆头固定、磨损情况'),(3,1,'电机接线柱螺栓紧固和电机线压紧检查'),(4,1,'电机绝缘电阻测试（每千伏1兆欧以上）'),(5,1,'电机接线盒的密封情况'),(6,1,'电机接地线连接是否可靠'),(7,1,'电机上是否有杂物，多要通知工艺处理');
/*!40000 ALTER TABLE `保养项目` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `修理`
--

DROP TABLE IF EXISTS `修理`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `修理` (
  `id修理` int(11) NOT NULL,
  `保养记录id` int(11) NOT NULL,
  `保养项目id` int(11) NOT NULL,
  `材料配件id` int(11) DEFAULT NULL,
  `是否完好` varchar(2) NOT NULL,
  `材料配件数量` varchar(45) DEFAULT NULL,
  `备注` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id修理`),
  KEY `FK8_idx` (`材料配件id`),
  KEY `FK11_idx` (`保养项目id`),
  CONSTRAINT `FK10` FOREIGN KEY (`材料配件id`) REFERENCES `配件` (`id配件`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK11` FOREIGN KEY (`保养项目id`) REFERENCES `保养项目` (`id保养项目`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `修理`
--

LOCK TABLES `修理` WRITE;
/*!40000 ALTER TABLE `修理` DISABLE KEYS */;
INSERT INTO `修理` VALUES (1,1,1,1,'否','2',NULL),(2,1,2,1,'否','3',NULL),(3,1,3,3,'否','2',NULL),(4,1,4,NULL,'是',NULL,NULL),(5,1,5,NULL,'是',NULL,NULL),(6,1,6,NULL,'是',NULL,NULL),(7,1,7,NULL,'是',NULL,NULL);
/*!40000 ALTER TABLE `修理` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `检修类型`
--

DROP TABLE IF EXISTS `检修类型`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `检修类型` (
  `id检修类型` int(11) NOT NULL,
  `检修周期` int(11) NOT NULL,
  `检修类型` varchar(4) NOT NULL,
  PRIMARY KEY (`id检修类型`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `检修类型`
--

LOCK TABLES `检修类型` WRITE;
/*!40000 ALTER TABLE `检修类型` DISABLE KEYS */;
INSERT INTO `检修类型` VALUES (1,365,'年检'),(2,90,'季检'),(3,60,'双月检'),(4,30,'月检'),(5,7,'周检');
/*!40000 ALTER TABLE `检修类型` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `设备`
--

DROP TABLE IF EXISTS `设备`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `设备` (
  `id设备` int(11) NOT NULL,
  `设备类别` int(11) NOT NULL,
  `设备号` varchar(50) NOT NULL,
  `提前预警天数` int(11) NOT NULL,
  PRIMARY KEY (`id设备`),
  KEY `设备类别_idx` (`设备类别`),
  CONSTRAINT `FK1` FOREIGN KEY (`设备类别`) REFERENCES `设备类别` (`id设备类别`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `设备`
--

LOCK TABLES `设备` WRITE;
/*!40000 ALTER TABLE `设备` DISABLE KEYS */;
INSERT INTO `设备` VALUES (1,1,'001',4),(2,2,'002',5);
/*!40000 ALTER TABLE `设备` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `设备类别`
--

DROP TABLE IF EXISTS `设备类别`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `设备类别` (
  `id设备类别` int(11) NOT NULL,
  `类别名` varchar(45) NOT NULL,
  PRIMARY KEY (`id设备类别`),
  UNIQUE KEY `类别名_UNIQUE` (`类别名`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `设备类别`
--

LOCK TABLES `设备类别` WRITE;
/*!40000 ALTER TABLE `设备类别` DISABLE KEYS */;
INSERT INTO `设备类别` VALUES (2,'6000V以下不带振动电机'),(3,'6000V以下带振动电机'),(1,'6000V电机'),(4,'CST'),(5,'PLC');
/*!40000 ALTER TABLE `设备类别` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `配件`
--

DROP TABLE IF EXISTS `配件`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `配件` (
  `id配件` int(11) NOT NULL,
  `配件名称` varchar(20) NOT NULL,
  PRIMARY KEY (`id配件`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `配件`
--

LOCK TABLES `配件` WRITE;
/*!40000 ALTER TABLE `配件` DISABLE KEYS */;
INSERT INTO `配件` VALUES (1,'配件1'),(2,'配件2'),(3,'配件3'),(4,'配件4');
/*!40000 ALTER TABLE `配件` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-15 17:07:54
