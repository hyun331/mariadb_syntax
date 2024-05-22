-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `post_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(2,'aaa','aaaa@naver.com','1234','a',36,NULL,NULL,NULL,'user',0),
(4,'ccc','c@naver.com','1234','c',50,NULL,NULL,NULL,'user',0),
(5,'ddd','d@naver.com','1234','d',125,NULL,NULL,NULL,'user',0),
(6,'eee','e@naver.com','1234','d',224,NULL,NULL,NULL,'user',0),
(7,'홍길동','dmsl','1234','f',11,NULL,NULL,NULL,'user',0),
(8,'신승현','sdmfl','12234','fd',26,NULL,NULL,NULL,'user',0),
(9,'dskd이','ddj','1234','121',12,NULL,NULL,NULL,'user',0),
(10,NULL,'hello@',NULL,NULL,32,NULL,'1999-03-31','2000-11-11 11:11:11','user',0),
(11,NULL,'heelo',NULL,NULL,28,NULL,NULL,'1999-01-11 11:11:11','user',0),
(13,'dkdk','dddauthor',NULL,NULL,29,NULL,NULL,'2024-05-17 11:11:11','user',0),
(14,NULL,'hilil@',NULL,NULL,NULL,NULL,NULL,'2024-05-17 14:57:32','admin',0),
(15,'dkdk','ddd',NULL,NULL,NULL,NULL,NULL,'2024-05-17 14:52:14','user',0),
(1113,'transaction test','transaction',NULL,NULL,NULL,NULL,NULL,'2024-05-20 15:39:09','user',0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'집','가고싶다',NULL,1000.000,NULL,'0bb4e314-141f-11ef-9157-84144d92bf7a'),
(2,'hello','this is dkdk',NULL,2000.000,NULL,'0bb4e441-141f-11ef-9157-84144d92bf7a'),
(3,'hello','this is sksk',2,3000.000,'2022-05-17 16:15:27','0bb4e484-141f-11ef-9157-84144d92bf7a'),
(4,'T1','this is sksk',2,5000.000,'2022-05-17 16:15:27','0bb4e4b8-141f-11ef-9157-84144d92bf7a'),
(5,'T1','this is sksk',2,4000.000,'2023-05-17 16:15:27','0bb4e506-141f-11ef-9157-84144d92bf7a'),
(7,'T1',NULL,5,1234.100,'2023-05-17 16:15:27','0bb4e582-141f-11ef-9157-84144d92bf7a'),
(8,'dkdkls','new',5,1000.000,'2024-05-17 16:15:27','0bb4e5b6-141f-11ef-9157-84144d92bf7a'),
(9,'abc',NULL,NULL,NULL,'2024-05-17 16:28:35','1443f0c4-141f-11ef-9157-84144d92bf7a'),
(10,'abc',NULL,NULL,NULL,'2024-05-17 16:29:22','30597b4c-141f-11ef-9157-84144d92bf7a'),
(11,'abc',NULL,4,4000.000,'2020-05-17 16:29:59','467e922f-141f-11ef-9157-84144d92bf7a'),
(13,'hello world',NULL,4,2000.000,'2020-05-20 12:48:13','c87238e9-165b-11ef-9607-84144d92bf7a');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 16:27:17
