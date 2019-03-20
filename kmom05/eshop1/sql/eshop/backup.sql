-- MySQL dump 10.13  Distrib 8.0.14, for macos10.14 (x86_64)
--
-- Host: localhost    Database: eshop
-- ------------------------------------------------------
-- Server version	8.0.14

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(50) DEFAULT NULL,
  `fname` char(100) DEFAULT NULL,
  `sirname` char(100) DEFAULT NULL,
  `adress` varchar(300) DEFAULT NULL,
  `zip` int(10) DEFAULT NULL,
  `city` char(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'jerald@cormier.com','Jerald','Cormier','Granville Lane',3182,'Newark'),(2,'carol@stephenson.com','Carol','Stephenson','Ridge Road',67801,'Dodge City'),(3,'christopher@robin.po','Christofer','Robin','Humanvillage',1234,'Pooh City'),(4,'piglet@thepig.se','Piglet','The pig','Scaredvillage',4567,'Pooh City'),(5,'mary@lamb.se','Mary','Had a little','Lambstreet',12356,'Imaginary');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_id` varchar(10) DEFAULT NULL,
  `shelf` varchar(8) DEFAULT NULL,
  `items` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prod_id` (`prod_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,'boo1','B:01',100),(2,'boo2','B:02',74),(3,'boo3','B:02',64),(4,'boo4','M:01',85),(5,'cd1','C:01',98),(6,'merch1','M:01',200);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_row`
--

DROP TABLE IF EXISTS `invoice_row`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `invoice_row` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_id` varchar(10) DEFAULT NULL,
  `prod_order_id` int(11) DEFAULT NULL,
  `inv_id` int(11) DEFAULT NULL,
  `total` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prod_id` (`prod_id`),
  KEY `prod_order_id` (`prod_order_id`),
  KEY `inv_id` (`inv_id`),
  CONSTRAINT `invoice_row_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `product` (`id`),
  CONSTRAINT `invoice_row_ibfk_2` FOREIGN KEY (`prod_order_id`) REFERENCES `prod_order` (`id`),
  CONSTRAINT `invoice_row_ibfk_3` FOREIGN KEY (`inv_id`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_row`
--

LOCK TABLES `invoice_row` WRITE;
/*!40000 ALTER TABLE `invoice_row` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_row` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_row`
--

DROP TABLE IF EXISTS `order_row`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `order_row` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_order_id` int(11) DEFAULT NULL,
  `prod_id` varchar(10) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prod_order_id` (`prod_order_id`),
  KEY `prod_id` (`prod_id`),
  CONSTRAINT `order_row_ibfk_1` FOREIGN KEY (`prod_order_id`) REFERENCES `prod_order` (`id`),
  CONSTRAINT `order_row_ibfk_2` FOREIGN KEY (`prod_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_row`
--

LOCK TABLES `order_row` WRITE;
/*!40000 ALTER TABLE `order_row` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_row` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plock_list`
--

DROP TABLE IF EXISTS `plock_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plock_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_order_id` int(11) DEFAULT NULL,
  `prod_id` varchar(10) DEFAULT NULL,
  `items` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prod_order_id` (`prod_order_id`),
  KEY `prod_id` (`prod_id`),
  CONSTRAINT `plock_list_ibfk_1` FOREIGN KEY (`prod_order_id`) REFERENCES `prod_order` (`id`),
  CONSTRAINT `plock_list_ibfk_2` FOREIGN KEY (`prod_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plock_list`
--

LOCK TABLES `plock_list` WRITE;
/*!40000 ALTER TABLE `plock_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `plock_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_2_cat`
--

DROP TABLE IF EXISTS `prod_2_cat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `prod_2_cat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_id` varchar(10) DEFAULT NULL,
  `cat_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prod_id` (`prod_id`),
  KEY `cat_id` (`cat_id`),
  CONSTRAINT `prod_2_cat_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `product` (`id`),
  CONSTRAINT `prod_2_cat_ibfk_2` FOREIGN KEY (`cat_id`) REFERENCES `prod_cat` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_2_cat`
--

LOCK TABLES `prod_2_cat` WRITE;
/*!40000 ALTER TABLE `prod_2_cat` DISABLE KEYS */;
INSERT INTO `prod_2_cat` VALUES (1,'boo1','cat_book'),(2,'boo2','cat_book'),(3,'boo2','cat_sale'),(4,'boo3','cat_book'),(5,'boo4','cat_book'),(6,'boo4','cat_new'),(7,'cd1','cat_cd'),(8,'merch1','cat_merch'),(9,'merch1','cat_sale');
/*!40000 ALTER TABLE `prod_2_cat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_cat`
--

DROP TABLE IF EXISTS `prod_cat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `prod_cat` (
  `id` varchar(10) NOT NULL,
  `cat` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_cat`
--

LOCK TABLES `prod_cat` WRITE;
/*!40000 ALTER TABLE `prod_cat` DISABLE KEYS */;
INSERT INTO `prod_cat` VALUES ('cat_book','Book'),('cat_cd','CD'),('cat_merch','Merch'),('cat_new','New'),('cat_sale','Sale');
/*!40000 ALTER TABLE `prod_cat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_order`
--

DROP TABLE IF EXISTS `prod_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `prod_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL,
  `delivery` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `prod_order_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_order`
--

LOCK TABLES `prod_order` WRITE;
/*!40000 ALTER TABLE `prod_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product` (
  `id` varchar(10) NOT NULL,
  `title` char(100) DEFAULT NULL,
  `info` varchar(300) DEFAULT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('boo1','Diktboken','Lite lyrik',200),('boo2','Romanboken','En skönlitterär bok',90),('boo3','Kokboken','En massa gott',100),('boo4','Barnboken','Hittepå och färgglatt',50),('cd1','CD','Great music',60),('merch1','Tygkasse','En bra kasse',25);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `log_insert_prod` AFTER INSERT ON `product` FOR EACH ROW INSERT INTO product_log(`what`, `id`, `title`, `info`, `price`)
		VALUES("trigger - insert", NEW.id, NEW.title, NEW.info, NEW.price) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `log_update_prod` BEFORE UPDATE ON `product` FOR EACH ROW INSERT INTO product_log(`what`, `id`, `title`, `info`, `price`)
		VALUES("trigger - update", NEW.id, NEW.title, NEW.info, NEW.price) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `log_delete_prod` BEFORE DELETE ON `product` FOR EACH ROW INSERT INTO product_log(`what`, `id`, `title`, `info`, `price`)
		VALUES("trigger - delete", OLD.id, OLD.title, OLD.info, OLD.price) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product_log`
--

DROP TABLE IF EXISTS `product_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product_log` (
  `log` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(10) DEFAULT NULL,
  `when` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `what` varchar(20) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `info` varchar(300) DEFAULT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`log`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_log`
--

LOCK TABLES `product_log` WRITE;
/*!40000 ALTER TABLE `product_log` DISABLE KEYS */;
INSERT INTO `product_log` VALUES (1,'boo1','2019-03-19 14:37:09','trigger - insert','Diktboken','Lite lyrik',20),(2,'boo2','2019-03-19 14:37:09','trigger - insert','Romanboken','En skönlitterär bok',90),(3,'boo3','2019-03-19 14:37:09','trigger - insert','Kokboken','En massa gott',100),(4,'boo4','2019-03-19 14:37:09','trigger - insert','Barnboken','Hittepå och färgglatt',50),(5,'cd1','2019-03-19 14:37:09','trigger - insert','CD','Great music',60),(6,'merch1','2019-03-19 14:37:09','trigger - insert','Tygkasse','En bra kasse',25),(7,'boo1','2019-03-19 14:37:09','trigger - update','Diktboken','Lite lyrik',200),(8,'cd2','2019-03-19 14:37:09','trigger - insert','musica','more music',30),(9,'merch2','2019-03-19 14:37:09','trigger - insert','mugg','kopp med logo',1),(10,'cd2','2019-03-19 14:37:09','trigger - delete','musica','more music',30),(11,'merch2','2019-03-19 14:37:09','trigger - delete','mugg','kopp med logo',1);
/*!40000 ALTER TABLE `product_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_prodcat`
--

DROP TABLE IF EXISTS `v_prodcat`;
/*!50001 DROP VIEW IF EXISTS `v_prodcat`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_prodcat` AS SELECT 
 1 AS `Categories`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_products`
--

DROP TABLE IF EXISTS `v_products`;
/*!50001 DROP VIEW IF EXISTS `v_products`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_products` AS SELECT 
 1 AS `ProdId`,
 1 AS `Title`,
 1 AS `Price`,
 1 AS `Items in stock`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_prodcat`
--

/*!50001 DROP VIEW IF EXISTS `v_prodcat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_prodcat` AS select `pc`.`cat` AS `Categories` from ((`product` `prod` join `prod_2_cat` `p2` on((`prod`.`id` = `p2`.`prod_id`))) join `prod_cat` `pc` on((`p2`.`cat_id` = `pc`.`id`))) group by `p2`.`cat_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_products`
--

/*!50001 DROP VIEW IF EXISTS `v_products`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_products` AS select `prod`.`id` AS `ProdId`,`prod`.`title` AS `Title`,`prod`.`price` AS `Price`,`inv`.`items` AS `Items in stock` from (`product` `prod` join `inventory` `inv` on((`inv`.`prod_id` = `prod`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-19 15:37:27
