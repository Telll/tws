-- 1 up
-- MySQL dump 10.13  Distrib 5.5.47, for debian-linux-gnu (x86_64)
--
-- Host: db    Database: tws
-- ------------------------------------------------------
-- Server version	5.7.10

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
-- Table structure for table `auth`
--

DROP TABLE IF EXISTS `auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `auth_key` varchar(255) NOT NULL,
	  `login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `device` bigint(20) unsigned NOT NULL,
	  `logout` datetime DEFAULT NULL,
	  PRIMARY KEY (`id`,`auth_key`),
	  UNIQUE KEY `id` (`id`),
	  KEY `auth_idx_device` (`device`),
	  CONSTRAINT `auth_fk_device` FOREIGN KEY (`device`) REFERENCES `devices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth`
--

LOCK TABLES `auth` WRITE;
/*!40000 ALTER TABLE `auth` DISABLE KEYS */;
-- INSERT INTO `auth` VALUES (1,'a5502b31f2ba3d134be6102b010c9564eac6613b','2016-02-13 16:52:22',1,NULL),(2,'4ff200dbd067fbe52fc557bc42c467655688216c','2016-02-13 16:57:31',2,'2016-02-13 16:57:47'),(3,'173841e91be6fe2c710660cb95cb992301ae2bb4','2016-02-13 16:57:32',2,NULL),(4,'f0bab93355d88aabf64c561fa6209fadc02e3075','2016-02-13 16:58:57',3,NULL),(5,'3e35aa07bc2092c54dddef80dfdc64ea6e088aae','2016-02-13 16:59:13',4,'2016-02-13 16:59:29'),(6,'c0af99d5f9ef1084c2861a533d7a766ed4bbd291','2016-02-13 16:59:14',4,NULL),(7,'6cfc9cf0bc2bd821b4f65b38fb8abae5b463f7b8','2016-02-13 17:00:40',5,NULL),(8,'c0d16fafd5d7f458ea0afbb5f4accfb965b39340','2016-02-13 17:03:12',6,'2016-02-13 17:03:28'),(9,'6eb43b6dedc572a7a8a25e0ac8c587f154a1d45a','2016-02-13 17:03:12',6,NULL);
/*!40000 ALTER TABLE `auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clicks`
--

DROP TABLE IF EXISTS `clicks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clicks` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `value` decimal(2,0) DEFAULT NULL,
	  `photolink` bigint(20) unsigned NOT NULL,
	  `device` bigint(20) unsigned DEFAULT NULL,
	  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `user` bigint(20) unsigned DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `clicks_idx_device` (`device`),
	  KEY `clicks_idx_photolink` (`photolink`),
	  KEY `clicks_idx_user` (`user`),
	  CONSTRAINT `clicks_fk_device` FOREIGN KEY (`device`) REFERENCES `devices` (`id`),
	  CONSTRAINT `clicks_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`),
	  CONSTRAINT `clicks_fk_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clicks`
--

LOCK TABLES `clicks` WRITE;
/*!40000 ALTER TABLE `clicks` DISABLE KEYS */;
/*!40000 ALTER TABLE `clicks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `code_data`
--

DROP TABLE IF EXISTS `code_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code_data` (
	  `idcode_data` int(11) NOT NULL,
	  `datatype` varchar(45) NOT NULL,
	  `dataid` int(11) NOT NULL,
	  `components_idcomponents` int(11) NOT NULL,
	  PRIMARY KEY (`idcode_data`,`components_idcomponents`),
	  KEY `code_data_idx_components_idcomponents` (`components_idcomponents`),
	  CONSTRAINT `code_data_fk_components_idcomponents` FOREIGN KEY (`components_idcomponents`) REFERENCES `components` (`idcomponents`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code_data`
--

LOCK TABLES `code_data` WRITE;
/*!40000 ALTER TABLE `code_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `code_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `components`
--

DROP TABLE IF EXISTS `components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `components` (
	  `idcomponents` int(11) NOT NULL,
	  `name` varchar(45) DEFAULT NULL,
	  `href` varchar(255) DEFAULT NULL,
	  `doc` longtext,
	  PRIMARY KEY (`idcomponents`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `components`
--

LOCK TABLES `components` WRITE;
/*!40000 ALTER TABLE `components` DISABLE KEYS */;
/*!40000 ALTER TABLE `components` ENABLE KEYS */;
UNLOCK TABLES;

-- --
-- -- Table structure for table `dbix_class_deploymenthandler_versions`
-- --
-- 
-- DROP TABLE IF EXISTS `dbix_class_deploymenthandler_versions`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `dbix_class_deploymenthandler_versions` (
-- 	  `id` int(11) NOT NULL AUTO_INCREMENT,
-- 	  `version` varchar(50) NOT NULL,
-- 	  `ddl` text,
-- 	  `upgrade_sql` text,
-- 	  PRIMARY KEY (`id`),
-- 	  UNIQUE KEY `dbix_class_deploymenthandler_versions_version` (`version`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
-- --
-- -- Dumping data for table `dbix_class_deploymenthandler_versions`
-- --
-- 
-- LOCK TABLES `dbix_class_deploymenthandler_versions` WRITE;
-- /*!40000 ALTER TABLE `dbix_class_deploymenthandler_versions` DISABLE KEYS */;
-- INSERT INTO `dbix_class_deploymenthandler_versions` VALUES (1,'1','SET foreign_key_checks=0\nCREATE TABLE `dbix_class_deploymenthandler_versions` ( `id` integer NOT NULL auto_increment, `version` varchar(50) NOT NULL, `ddl` text NULL, `upgrade_sql` text NULL, PRIMARY KEY (`id`), UNIQUE `dbix_class_deploymenthandler_versions_version` (`version`) )\nSET foreign_key_checks=1SET foreign_key_checks=0\nCREATE TABLE `auth` ( `id` bigint unsigned NOT NULL auto_increment, `auth_key` varchar(255) NOT NULL, `login` timestamp NOT NULL DEFAULT current_timestamp, `device` bigint unsigned NOT NULL, `logout` datetime NULL, INDEX `auth_idx_device` (`device`), PRIMARY KEY (`id`, `auth_key`), UNIQUE `id` (`id`), CONSTRAINT `auth_fk_device` FOREIGN KEY (`device`) REFERENCES `devices` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT ) ENGINE=InnoDB\nCREATE TABLE `clicks` ( `id` bigint unsigned NOT NULL auto_increment, `value` decimal(2, 0) NULL, `photolink` bigint unsigned NOT NULL, `device` bigint unsigned NULL, `time` timestamp NOT NULL DEFAULT current_timestamp, `user` bigint unsigned NULL, INDEX `clicks_idx_device` (`device`), INDEX `clicks_idx_photolink` (`photolink`), INDEX `clicks_idx_user` (`user`), PRIMARY KEY (`id`), CONSTRAINT `clicks_fk_device` FOREIGN KEY (`device`) REFERENCES `devices` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT, CONSTRAINT `clicks_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT, CONSTRAINT `clicks_fk_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT ) ENGINE=InnoDB\nCREATE TABLE `code_data` ( `idcode_data` integer NOT NULL, `datatype` varchar(45) NOT NULL, `dataid` integer NOT NULL, `components_idcomponents` integer NOT NULL, INDEX `code_data_idx_components_idcomponents` (`components_idcomponents`), PRIMARY KEY (`idcode_data`, `components_idcomponents`), CONSTRAINT `code_data_fk_components_idcomponents` FOREIGN KEY (`components_idcomponents`) REFERENCES `components` (`idcomponents`) ON DELETE NO ACTION ON UPDATE NO ACTION ) ENGINE=InnoDB\nCREATE TABLE `components` ( `idcomponents` integer NOT NULL, `name` varchar(45) NULL, `href` varchar(255) NULL, `doc` longtext NULL, PRIMARY KEY (`idcomponents`) ) ENGINE=InnoDB\nCREATE TABLE `device_models` ( `id` bigint unsigned NOT NULL auto_increment, `name` varchar(50) NOT NULL, PRIMARY KEY (`id`), UNIQUE `name` (`name`) ) ENGINE=InnoDB\nCREATE TABLE `device_photolinks` ( `photolink` bigint unsigned NOT NULL DEFAULT 0, `device` bigint unsigned NOT NULL DEFAULT 0, `sent` timestamp NOT NULL DEFAULT current_timestamp, INDEX `device_photolinks_idx_device` (`device`), INDEX `device_photolinks_idx_photolink` (`photolink`), PRIMARY KEY (`photolink`, `device`), CONSTRAINT `device_photolinks_fk_device` FOREIGN KEY (`device`) REFERENCES `devices` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT, CONSTRAINT `device_photolinks_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT ) ENGINE=InnoDB\nCREATE TABLE `devices` ( `id` bigint unsigned NOT NULL auto_increment, `os` varchar(45) NULL, `number` varchar(45) NULL, `cache` blob NULL, `model` bigint unsigned NOT NULL, `user` bigint unsigned NOT NULL, INDEX `devices_idx_model` (`model`), INDEX `devices_idx_user` (`user`), PRIMARY KEY (`id`), CONSTRAINT `devices_fk_model` FOREIGN KEY (`model`) REFERENCES `device_models` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT, CONSTRAINT `devices_fk_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT ) ENGINE=InnoDB\nCREATE TABLE `mojo_migrations` ( `name` varchar(255) NOT NULL, `version` bigint NOT NULL, UNIQUE `name` (`name`) )\nCREATE TABLE `mojo_pubsub_notify` ( `id` integer NOT NULL auto_increment, `channel` varchar(64) NOT NULL, `payload` text NULL, `ts` timestamp NOT NULL DEFAULT current_timestamp, PRIMARY KEY (`id`) )\nCREATE TABLE `mojo_pubsub_subscribe` ( `id` integer NOT NULL auto_increment, `pid` integer NOT NULL, `channel` varchar(64) NOT NULL, `ts` timestamp NOT NULL DEFAULT current_timestamp, PRIMARY KEY (`id`), UNIQUE `subs_idx` (`pid`, `channel`) )\nCREATE TABLE `movies` ( `id` bigint unsigned NOT NULL auto_increment, `title` varchar(45) NULL, `description` varchar(255) NULL, `url` text NULL, `player` varchar(45) NULL, `image` text NULL, PRIMARY KEY (`id`), UNIQUE `title` (`title`) ) ENGINE=InnoDB\nCREATE TABLE `photolinks` ( `id` bigint unsigned NOT NULL auto_increment, `title` varchar(45) NULL, `description` varchar(255) NULL, `mediatype` varchar(45) NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB\nCREATE TABLE `points` ( `id` bigint unsigned NOT NULL auto_increment, `x` integer NULL, `y` integer NULL, `t` double precision NOT NULL, `trackmotion` bigint unsigned NOT NULL, INDEX `points_idx_trackmotion` (`trackmotion`), PRIMARY KEY (`id`), CONSTRAINT `points_fk_trackmotion` FOREIGN KEY (`trackmotion`) REFERENCES `trackmotions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT ) ENGINE=InnoDB\nCREATE TABLE `providers` ( `idproviders` integer NOT NULL, `level` integer NULL, `avatar` varchar(255) NULL, PRIMARY KEY (`idproviders`) )\nCREATE TABLE `redirects` ( `id` bigint unsigned NOT NULL auto_increment, `user` bigint unsigned NOT NULL, `movie` bigint unsigned NOT NULL, `photolink` bigint unsigned NOT NULL, `time` timestamp NOT NULL DEFAULT current_timestamp, `redirect_to` text NOT NULL, `price` integer NOT NULL DEFAULT 0, `divisor_for_cents` integer NOT NULL DEFAULT 100, INDEX `redirects_idx_movie` (`movie`), INDEX `redirects_idx_photolink` (`photolink`), INDEX `redirects_idx_user` (`user`), PRIMARY KEY (`id`), CONSTRAINT `redirects_fk_movie` FOREIGN KEY (`movie`) REFERENCES `movies` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT, CONSTRAINT `redirects_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT, CONSTRAINT `redirects_fk_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT ) ENGINE=InnoDB\nCREATE TABLE `thumbs` ( `idthumbs` integer NOT NULL auto_increment, `path` varchar(255) NOT NULL, PRIMARY KEY (`idthumbs`) )\nCREATE TABLE `trackmotions` ( `photolink` bigint unsigned NOT NULL, `id` bigint unsigned NOT NULL auto_increment, `thumb` varchar(255) NULL, `movie` bigint unsigned NOT NULL, INDEX `trackmotions_idx_movie` (`movie`), INDEX `trackmotions_idx_photolink` (`photolink`), PRIMARY KEY (`id`), CONSTRAINT `trackmotions_fk_movie` FOREIGN KEY (`movie`) REFERENCES `movies` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT, CONSTRAINT `trackmotions_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT ) ENGINE=InnoDB\nCREATE TABLE `urls` ( `id` bigint unsigned NOT NULL auto_increment, `href` varchar(255) NULL, `value` decimal(2, 0) NULL, `description` varchar(255) NULL, `photolink` bigint unsigned NOT NULL, `title` varchar(45) NULL, INDEX `urls_idx_photolink` (`photolink`), UNIQUE `id` (`id`), CONSTRAINT `urls_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT ) ENGINE=InnoDB\nCREATE TABLE `users` ( `username` varchar(255) NOT NULL, `email` varchar(255) NOT NULL, `password` varchar(255) NOT NULL, `create_time` timestamp NULL DEFAULT current_timestamp, `id` bigint unsigned NOT NULL auto_increment, `salt` char(15) NOT NULL, `counter` integer NULL DEFAULT 1024, `active` tinyint NULL DEFAULT 1, PRIMARY KEY (`id`), UNIQUE `username` (`username`) ) ENGINE=InnoDB\nCREATE TABLE `users_has_devices` ( `user` bigint unsigned NOT NULL DEFAULT 0, `device` bigint unsigned NOT NULL DEFAULT 0, INDEX `users_has_devices_idx_device` (`device`), INDEX `users_has_devices_idx_user` (`user`), PRIMARY KEY (`user`, `device`), CONSTRAINT `users_has_devices_fk_device` FOREIGN KEY (`device`) REFERENCES `devices` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT, CONSTRAINT `users_has_devices_fk_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT ) ENGINE=InnoDB\nCREATE TABLE `watchers` ( `idwatchers` integer NOT NULL, `level` integer NULL, `avatar` varchar(255) NULL, PRIMARY KEY (`idwatchers`) )\nSET foreign_key_checks=1',NULL);
-- /*!40000 ALTER TABLE `dbix_class_deploymenthandler_versions` ENABLE KEYS */;
-- UNLOCK TABLES;

--
-- Table structure for table `device_models`
--

DROP TABLE IF EXISTS `device_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_models` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `name` varchar(50) NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_models`
--

LOCK TABLES `device_models` WRITE;
/*!40000 ALTER TABLE `device_models` DISABLE KEYS */;
INSERT INTO `device_models` VALUES (1,'iPad'),(2,'iPhone');
/*!40000 ALTER TABLE `device_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_photolinks`
--

DROP TABLE IF EXISTS `device_photolinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_photolinks` (
	  `photolink` bigint(20) unsigned NOT NULL DEFAULT '0',
	  `device` bigint(20) unsigned NOT NULL DEFAULT '0',
	  `sent` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`photolink`,`device`),
	  KEY `device_photolinks_idx_device` (`device`),
	  KEY `device_photolinks_idx_photolink` (`photolink`),
	  CONSTRAINT `device_photolinks_fk_device` FOREIGN KEY (`device`) REFERENCES `devices` (`id`),
	  CONSTRAINT `device_photolinks_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_photolinks`
--

LOCK TABLES `device_photolinks` WRITE;
/*!40000 ALTER TABLE `device_photolinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_photolinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `os` varchar(45) DEFAULT NULL,
	  `number` varchar(45) DEFAULT NULL,
	  `cache` blob,
	  `model` bigint(20) unsigned NOT NULL,
	  `user` bigint(20) unsigned NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `devices_idx_model` (`model`),
	  KEY `devices_idx_user` (`user`),
	  CONSTRAINT `devices_fk_model` FOREIGN KEY (`model`) REFERENCES `device_models` (`id`),
	  CONSTRAINT `devices_fk_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
-- INSERT INTO `devices` VALUES (1,NULL,NULL,NULL,1,27),(2,NULL,NULL,NULL,1,27),(3,NULL,NULL,NULL,1,27),(4,NULL,NULL,NULL,1,27),(5,NULL,NULL,NULL,1,27),(6,NULL,NULL,NULL,1,27);
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mojo_migrations`
--

-- DROP TABLE IF EXISTS `mojo_migrations`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `mojo_migrations` (
-- 	  `name` varchar(255) NOT NULL,
-- 	  `version` bigint(20) NOT NULL,
-- 	  UNIQUE KEY `name` (`name`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
-- --
-- -- Dumping data for table `mojo_migrations`
-- --
-- 
-- LOCK TABLES `mojo_migrations` WRITE;
-- /*!40000 ALTER TABLE `mojo_migrations` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `mojo_migrations` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
-- --
-- -- Table structure for table `mojo_pubsub_notify`
-- --
-- 
-- DROP TABLE IF EXISTS `mojo_pubsub_notify`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `mojo_pubsub_notify` (
-- 	  `id` int(11) NOT NULL AUTO_INCREMENT,
-- 	  `channel` varchar(64) NOT NULL,
-- 	  `payload` text,
-- 	  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- 	  PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
-- --
-- -- Dumping data for table `mojo_pubsub_notify`
-- --
-- 
-- LOCK TABLES `mojo_pubsub_notify` WRITE;
-- /*!40000 ALTER TABLE `mojo_pubsub_notify` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `mojo_pubsub_notify` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
-- --
-- -- Table structure for table `mojo_pubsub_subscribe`
-- --
-- 
-- DROP TABLE IF EXISTS `mojo_pubsub_subscribe`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `mojo_pubsub_subscribe` (
-- 	  `id` int(11) NOT NULL AUTO_INCREMENT,
-- 	  `pid` int(11) NOT NULL,
-- 	  `channel` varchar(64) NOT NULL,
-- 	  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- 	  PRIMARY KEY (`id`),
-- 	  UNIQUE KEY `subs_idx` (`pid`,`channel`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
-- --
-- -- Dumping data for table `mojo_pubsub_subscribe`
-- --
-- 
-- LOCK TABLES `mojo_pubsub_subscribe` WRITE;
-- /*!40000 ALTER TABLE `mojo_pubsub_subscribe` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `mojo_pubsub_subscribe` ENABLE KEYS */;
-- UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movies` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `title` varchar(45) DEFAULT NULL,
	  `description` varchar(255) DEFAULT NULL,
	  `url` text,
	  `player` varchar(45) DEFAULT NULL,
	  `image` text,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photolinks`
--

DROP TABLE IF EXISTS `photolinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photolinks` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `title` varchar(45) DEFAULT NULL,
	  `description` varchar(255) DEFAULT NULL,
	  `mediatype` varchar(45) DEFAULT NULL,
	  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photolinks`
--

LOCK TABLES `photolinks` WRITE;
/*!40000 ALTER TABLE `photolinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `photolinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `points`
--

DROP TABLE IF EXISTS `points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `points` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `x` int(11) DEFAULT NULL,
	  `y` int(11) DEFAULT NULL,
	  `t` double NOT NULL,
	  `trackmotion` bigint(20) unsigned NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `points_idx_trackmotion` (`trackmotion`),
	  CONSTRAINT `points_fk_trackmotion` FOREIGN KEY (`trackmotion`) REFERENCES `trackmotions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `points`
--

LOCK TABLES `points` WRITE;
/*!40000 ALTER TABLE `points` DISABLE KEYS */;
/*!40000 ALTER TABLE `points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providers`
--

DROP TABLE IF EXISTS `providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providers` (
	  `idproviders` int(11) NOT NULL,
	  `level` int(11) DEFAULT NULL,
	  `avatar` varchar(255) DEFAULT NULL,
	  PRIMARY KEY (`idproviders`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providers`
--

LOCK TABLES `providers` WRITE;
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `redirects`
--

DROP TABLE IF EXISTS `redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `redirects` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `user` bigint(20) unsigned NOT NULL,
	  `movie` bigint(20) unsigned NOT NULL,
	  `photolink` bigint(20) unsigned NOT NULL,
	  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `redirect_to` text NOT NULL,
	  `price` int(11) NOT NULL DEFAULT '0',
	  `divisor_for_cents` int(11) NOT NULL DEFAULT '100',
	  PRIMARY KEY (`id`),
	  KEY `redirects_idx_movie` (`movie`),
	  KEY `redirects_idx_photolink` (`photolink`),
	  KEY `redirects_idx_user` (`user`),
	  CONSTRAINT `redirects_fk_movie` FOREIGN KEY (`movie`) REFERENCES `movies` (`id`),
	  CONSTRAINT `redirects_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`),
	  CONSTRAINT `redirects_fk_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `redirects`
--

LOCK TABLES `redirects` WRITE;
/*!40000 ALTER TABLE `redirects` DISABLE KEYS */;
/*!40000 ALTER TABLE `redirects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thumbs`
--

DROP TABLE IF EXISTS `thumbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thumbs` (
	  `idthumbs` int(11) NOT NULL AUTO_INCREMENT,
	  `path` varchar(255) NOT NULL,
	  PRIMARY KEY (`idthumbs`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thumbs`
--

LOCK TABLES `thumbs` WRITE;
/*!40000 ALTER TABLE `thumbs` DISABLE KEYS */;
/*!40000 ALTER TABLE `thumbs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trackmotions`
--

DROP TABLE IF EXISTS `trackmotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trackmotions` (
	  `photolink` bigint(20) unsigned NOT NULL,
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `thumb` varchar(255) DEFAULT NULL,
	  `movie` bigint(20) unsigned NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `trackmotions_idx_movie` (`movie`),
	  KEY `trackmotions_idx_photolink` (`photolink`),
	  CONSTRAINT `trackmotions_fk_movie` FOREIGN KEY (`movie`) REFERENCES `movies` (`id`),
	  CONSTRAINT `trackmotions_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trackmotions`
--

LOCK TABLES `trackmotions` WRITE;
/*!40000 ALTER TABLE `trackmotions` DISABLE KEYS */;
/*!40000 ALTER TABLE `trackmotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `urls`
--

DROP TABLE IF EXISTS `urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `urls` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `href` varchar(255) DEFAULT NULL,
	  `value` decimal(2,0) DEFAULT NULL,
	  `description` varchar(255) DEFAULT NULL,
	  `photolink` bigint(20) unsigned NOT NULL,
	  `title` varchar(45) DEFAULT NULL,
	  UNIQUE KEY `id` (`id`),
	  KEY `urls_idx_photolink` (`photolink`),
	  CONSTRAINT `urls_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `urls`
--

LOCK TABLES `urls` WRITE;
/*!40000 ALTER TABLE `urls` DISABLE KEYS */;
/*!40000 ALTER TABLE `urls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
	  `username` varchar(255) NOT NULL,
	  `email` varchar(255) NOT NULL,
	  `password` varchar(255) NOT NULL,
	  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `salt` char(15) NOT NULL,
	  `counter` int(11) DEFAULT '1024',
	  `active` tinyint(4) DEFAULT '1',
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('smokemachine','changed_ivory.ansell@fb.com','d7c6c265dcd2575e6e5f6087baa3efd45fcddc28','2015-08-28 00:57:10',27,'irxreqsdixkdvel',1024,1),('telll','myrl.dahl@mycabin.com','c84043dcbece9f6ec5c9b194602a50b80c5efa86','2016-02-13 16:56:00',28,'dajygqeaujbxdcn',1024,1),('BI8dm5gINbf2QDW - Changed','gia.delara@thedoghousemail.com','8dc16c52eae071fe813efff8bb074912a536d9f4','2016-02-13 16:57:40',29,'qdcklkujutdujfl',1024,0),('r1hK8sqYdBkNNV5 - Changed','valery.flemister@nyc.com','dddea42e47802d5d2d42a74b44cf91544bb44f5a','2016-02-13 16:59:22',30,'xdcenxqgvrydund',1024,0),('AGchxnCQmVEQ5cB - Changed','dalton.reels@emailchoice.com','0879bff93a232fac22c9251a2da8a21c55eb8f68','2016-02-13 17:03:21',31,'pxkguuyhknoirnc',1024,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_has_devices`
--

DROP TABLE IF EXISTS `users_has_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_has_devices` (
	  `user` bigint(20) unsigned NOT NULL DEFAULT '0',
	  `device` bigint(20) unsigned NOT NULL DEFAULT '0',
	  PRIMARY KEY (`user`,`device`),
	  KEY `users_has_devices_idx_device` (`device`),
	  KEY `users_has_devices_idx_user` (`user`),
	  CONSTRAINT `users_has_devices_fk_device` FOREIGN KEY (`device`) REFERENCES `devices` (`id`),
	  CONSTRAINT `users_has_devices_fk_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_has_devices`
--

LOCK TABLES `users_has_devices` WRITE;
/*!40000 ALTER TABLE `users_has_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_has_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchers`
--

DROP TABLE IF EXISTS `watchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchers` (
	  `idwatchers` int(11) NOT NULL,
	  `level` int(11) DEFAULT NULL,
	  `avatar` varchar(255) DEFAULT NULL,
	  PRIMARY KEY (`idwatchers`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchers`
--

LOCK TABLES `watchers` WRITE;
/*!40000 ALTER TABLE `watchers` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-13 19:32:04
-- 1 down

DROP TABLE IF EXISTS `auth`;
DROP TABLE IF EXISTS `clicks`;
DROP TABLE IF EXISTS `code_data`;
DROP TABLE IF EXISTS `components`;
-- DROP TABLE IF EXISTS `dbix_class_deploymenthandler_versions`;
DROP TABLE IF EXISTS `device_models`;
DROP TABLE IF EXISTS `device_photolinks`;
DROP TABLE IF EXISTS `devices`;
-- DROP TABLE IF EXISTS `mojo_migrations`;
-- DROP TABLE IF EXISTS `mojo_pubsub_notify`;
-- DROP TABLE IF EXISTS `mojo_pubsub_subscribe`;
DROP TABLE IF EXISTS `movies`;
DROP TABLE IF EXISTS `photolinks`;
DROP TABLE IF EXISTS `points`;
DROP TABLE IF EXISTS `providers`;
DROP TABLE IF EXISTS `redirects`;
DROP TABLE IF EXISTS `thumbs`;
DROP TABLE IF EXISTS `trackmotions`;
DROP TABLE IF EXISTS `urls`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `users_has_devices`;
DROP TABLE IF EXISTS `watchers`;
