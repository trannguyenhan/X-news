-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: x_news
-- ------------------------------------------------------
-- Server version	8.0.25-0ubuntu0.20.10.1

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
-- Table structure for table `websites`
--

DROP TABLE IF EXISTS `websites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `websites` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) DEFAULT NULL,
  `category` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `websites`
--

LOCK TABLES `websites` WRITE;
/*!40000 ALTER TABLE `websites` DISABLE KEYS */;
INSERT INTO `websites` VALUES (1,'https://vietnamnet.vn','[\"/vn/thoi-su/\", \"/vn/kinh-doanh/\", \"/vn/giai-tri/\", \"/vn/the-gioi/\"]'),(2,'https://nhandan.vn','[\"/chinhtri\", \"/kinhte\", \"/vanhoa\", \"/thegioi\", \"/thethao\"]'),(3,'https://kenh14.vn','[\"/the-gioi.chn\", \"/doi-song.chn\", \"/xa-hoi.chn\", \"/sport.chn\", \"/xa-hoi.chn\"]'),(4,'https://vnexpress.net','[\"/thoi-su\", \"/goc-nhin\", \"/the-gioi\", \"/the-thao\", \"/doi-song\"]');
/*!40000 ALTER TABLE `websites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_path_categories`
--

DROP TABLE IF EXISTS `x_path_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `x_path_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `website_id` int unsigned DEFAULT NULL,
  `x_path` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `website_id` (`website_id`),
  CONSTRAINT `x_path_categories_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_path_categories`
--

LOCK TABLES `x_path_categories` WRITE;
/*!40000 ALTER TABLE `x_path_categories` DISABLE KEYS */;
INSERT INTO `x_path_categories` VALUES (1,1,'/html/body/div[1]/div[4]/div[2]/div[1]'),(2,2,'/html/body/div[1]/section[2]/div/div[2]/div[1]/div'),(3,3,'//*[@id=\"admWrapsite\"]/div[2]/div[3]/div/div[3]/div/div/div[2]/div'),(4,4,'//*[@id=\"automation_TV0\"]/div');
/*!40000 ALTER TABLE `x_path_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_path_contents`
--

DROP TABLE IF EXISTS `x_path_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `x_path_contents` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `website_id` int unsigned DEFAULT NULL,
  `x_path_title` varchar(500) DEFAULT NULL,
  `x_path_content` varchar(500) DEFAULT NULL,
  `x_path_date` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `website_id` (`website_id`),
  CONSTRAINT `x_path_contents_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_path_contents`
--

LOCK TABLES `x_path_contents` WRITE;
/*!40000 ALTER TABLE `x_path_contents` DISABLE KEYS */;
INSERT INTO `x_path_contents` VALUES (1,1,'//*[@id=\"ArticleHolder\"]/div[2]/h1','//*[@id=\"ArticleContent\"]','//*[@id=\"ArticleHolder\"]/div[2]/div[3]/span'),(2,2,'/html/body/div[1]/section[2]/div/div[2]/div[1]/div/h1','/html/body/div[1]/section[2]/div/div[2]/div[2]/div/div[1]/div[2]','/html/body/div[1]/section[2]/div/div[2]/div[2]/div/div[1]/div[1]/div[1]'),(3,3,'//*[@id=\"k14-detail-content\"]/div[2]/div/div/div[1]/div[1]/h1','//*[@id=\"k14-detail-content\"]/div[2]/div/div/div[1]/div[2]','//*[@id=\"k14-detail-content\"]/div[2]/div/div/div[1]/div[1]/div[2]/span[3]'),(4,4,'//*[@id=\"dark_theme\"]/section[4]/div/div[2]/h1','//*[@id=\"dark_theme\"]/section[4]/div/div[2]/article','//*[@id=\"dark_theme\"]/section[4]/div/div[2]/div[1]/span');
/*!40000 ALTER TABLE `x_path_contents` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-14 22:04:49
