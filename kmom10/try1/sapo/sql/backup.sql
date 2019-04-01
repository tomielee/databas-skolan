-- MySQL dump 10.13  Distrib 8.0.14, for macos10.14 (x86_64)
--
-- Host: localhost    Database: sapo
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
-- Table structure for table `kategori`
--

DROP TABLE IF EXISTS `kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `kategori` (
  `typ` varchar(20) NOT NULL,
  `niva` int(11) DEFAULT NULL,
  PRIMARY KEY (`typ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategori`
--

LOCK TABLES `kategori` WRITE;
/*!40000 ALTER TABLE `kategori` DISABLE KEYS */;
INSERT INTO `kategori` VALUES ('ickespridning',2),('personskydd',3),('spionage',5),('terrorism',5);
/*!40000 ALTER TABLE `kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logg`
--

DROP TABLE IF EXISTS `logg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `logg` (
  `id` int(11) NOT NULL,
  `kategori_typ` varchar(20) DEFAULT NULL,
  `person_id` varchar(5) DEFAULT NULL,
  `org_id` varchar(5) DEFAULT NULL,
  `vad` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kategori_typ` (`kategori_typ`),
  KEY `person_id` (`person_id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `logg_ibfk_1` FOREIGN KEY (`kategori_typ`) REFERENCES `kategori` (`typ`),
  CONSTRAINT `logg_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `logg_ibfk_3` FOREIGN KEY (`org_id`) REFERENCES `org` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logg`
--

LOCK TABLES `logg` WRITE;
/*!40000 ALTER TABLE `logg` DISABLE KEYS */;
INSERT INTO `logg` VALUES (1,'ickespridning','mumin','ha','Personen iaktogs på en hemmabyggd moped, misstänkt samröre med kriminell mc-organisation och vapenhandel.'),(2,'ickespridning','mumin','ha','Personen syntes hänga på torget vid Sibylla, ätandes en korv med mos, mopeden var nymålad och allt såg mycket misstänkt ut.'),(3,'spionage','mos','ps','Det noterades att personen googlade på \"webbprogrammering\", högst misstänkt spionage och eventuellt brott mot Internet. '),(4,'terrorism','mos','swed','Det finns iakttagelser om att personen pensionssparar sin statliga pension i en känd organisation för pengatvätt, högst olämpligt, rent av ett hot mot rikets säkerhet.'),(5,'spionage','jodoe','ps','Personen verkar sakna bakgrund och identitet, högst märkligt, kan det vara en spion eller vilande terrorgrupp.');
/*!40000 ALTER TABLE `logg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `org`
--

DROP TABLE IF EXISTS `org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `org` (
  `id` varchar(5) NOT NULL,
  `namn` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `org`
--

LOCK TABLES `org` WRITE;
/*!40000 ALTER TABLE `org` DISABLE KEYS */;
INSERT INTO `org` VALUES ('ha','Henriks Änglar'),('ps','Pensionerade spioner'),('si','Sveriges Idealister'),('swed','Internationell pengatvätt');
/*!40000 ALTER TABLE `org` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `person` (
  `id` varchar(5) NOT NULL,
  `fornamn` varchar(20) DEFAULT NULL,
  `efternamn` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('jadoe','Jane','Doe'),('jodoe','John','Doe'),('mos','Mikael ','Roos'),('mumin','Mumintrollet','Mumin');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_logg`
--

DROP TABLE IF EXISTS `v_logg`;
/*!50001 DROP VIEW IF EXISTS `v_logg`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_logg` AS SELECT 
 1 AS `loggid`,
 1 AS `kategorityp`,
 1 AS `personid`,
 1 AS `orgid`,
 1 AS `vad`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_org`
--

DROP TABLE IF EXISTS `v_org`;
/*!50001 DROP VIEW IF EXISTS `v_org`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_org` AS SELECT 
 1 AS `person_id`,
 1 AS `Organsation`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_pers`
--

DROP TABLE IF EXISTS `v_pers`;
/*!50001 DROP VIEW IF EXISTS `v_pers`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_pers` AS SELECT 
 1 AS `Personid`,
 1 AS `Namn`,
 1 AS `Antal`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_person`
--

DROP TABLE IF EXISTS `v_person`;
/*!50001 DROP VIEW IF EXISTS `v_person`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_person` AS SELECT 
 1 AS `id`,
 1 AS `fornamn`,
 1 AS `efternamn`,
 1 AS `namn`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_rapport`
--

DROP TABLE IF EXISTS `v_rapport`;
/*!50001 DROP VIEW IF EXISTS `v_rapport`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_rapport` AS SELECT 
 1 AS `Namn`,
 1 AS `Antal`,
 1 AS `Organsation`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_show_logg_extra`
--

DROP TABLE IF EXISTS `v_show_logg_extra`;
/*!50001 DROP VIEW IF EXISTS `v_show_logg_extra`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_show_logg_extra` AS SELECT 
 1 AS `loggid`,
 1 AS `kategorityp`,
 1 AS `personid`,
 1 AS `orgid`,
 1 AS `vad`,
 1 AS `orgnamn`,
 1 AS `namn`,
 1 AS `niva`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_show_logg_extra_t`
--

DROP TABLE IF EXISTS `v_show_logg_extra_t`;
/*!50001 DROP VIEW IF EXISTS `v_show_logg_extra_t`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_show_logg_extra_t` AS SELECT 
 1 AS `LoggID`,
 1 AS `Kategorityp`,
 1 AS `Nivå`,
 1 AS `Org.ID`,
 1 AS `Organisationsnamn`,
 1 AS `Pers.ID`,
 1 AS `Personnamn`,
 1 AS `Notering vad som hände`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'sapo'
--
/*!50003 DROP PROCEDURE IF EXISTS `show_logg` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_logg`(
)
BEGIN
	SELECT
		*
	FROM v_show_logg_extra;
		          
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_logg_search` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_logg_search`(
	a_search VARCHAR(300)
)
MAIN: BEGIN
	DECLARE current_search VARCHAR(30);
    
    SELECT CONCAT('%', a_search, '%') INTO current_search;

	SELECT * FROM v_show_logg_extra
    WHERE kategorityp LIKE current_search
    OR niva LIKE current_search
    OR namn LIKE current_search
    OR personid LIKE current_search
    OR orgid LIKE current_search
    OR orgnamn LIKE current_search
    OR vad LIKE current_search
	ORDER BY loggid;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_logg_search_t` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_logg_search_t`(
	a_search VARCHAR(300)
)
MAIN: BEGIN
	DECLARE current_search VARCHAR(30);
    
    SELECT CONCAT('%', a_search, '%') INTO current_search;

	SELECT 
	*
	FROM v_show_logg_extra
    WHERE kategorityp LIKE current_search
    OR niva LIKE current_search
    OR namn LIKE current_search
    OR personid LIKE current_search
    OR orgid LIKE current_search
    OR orgnamn LIKE current_search
    OR vad LIKE current_search
	ORDER BY loggid;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_logg_terminal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_logg_terminal`(
)
BEGIN
	SELECT
	*
	FROM v_show_logg_extra_t;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_rapport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_rapport`(
)
BEGIN
	SELECT * FROM v_rapport;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_logg`
--

/*!50001 DROP VIEW IF EXISTS `v_logg`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_logg` AS select `logg`.`id` AS `loggid`,`logg`.`kategori_typ` AS `kategorityp`,`logg`.`person_id` AS `personid`,`logg`.`org_id` AS `orgid`,`logg`.`vad` AS `vad` from `logg` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_org`
--

/*!50001 DROP VIEW IF EXISTS `v_org`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_org` AS select `l`.`person_id` AS `person_id`,group_concat(distinct `o`.`namn` order by `o`.`namn` DESC separator ' + ') AS `Organsation` from (`logg` `l` join `org` `o` on((`l`.`org_id` = `o`.`id`))) group by `l`.`person_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_pers`
--

/*!50001 DROP VIEW IF EXISTS `v_pers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_pers` AS select `p`.`id` AS `Personid`,concat(`p`.`fornamn`,' ',`p`.`efternamn`,' (',`p`.`id`,')') AS `Namn`,count(`l`.`id`) AS `Antal` from (`person` `p` left join `logg` `l` on((`p`.`id` = `l`.`person_id`))) group by `Namn`,`Personid` order by `Namn` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_person`
--

/*!50001 DROP VIEW IF EXISTS `v_person`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_person` AS select `person`.`id` AS `id`,`person`.`fornamn` AS `fornamn`,`person`.`efternamn` AS `efternamn`,concat(`person`.`fornamn`,' ',`person`.`efternamn`) AS `namn` from `person` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_rapport`
--

/*!50001 DROP VIEW IF EXISTS `v_rapport`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_rapport` AS select `p`.`Namn` AS `Namn`,`p`.`Antal` AS `Antal`,`o`.`Organsation` AS `Organsation` from (`v_pers` `p` left join `v_org` `o` on((`p`.`Personid` = `o`.`person_id`))) order by `p`.`Namn` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_show_logg_extra`
--

/*!50001 DROP VIEW IF EXISTS `v_show_logg_extra`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_show_logg_extra` AS select `l`.`loggid` AS `loggid`,`l`.`kategorityp` AS `kategorityp`,`l`.`personid` AS `personid`,`l`.`orgid` AS `orgid`,`l`.`vad` AS `vad`,`o`.`namn` AS `orgnamn`,`p`.`namn` AS `namn`,`k`.`niva` AS `niva` from (((`v_logg` `l` join `org` `o` on((`l`.`orgid` = `o`.`id`))) join `v_person` `p` on((`l`.`personid` = `p`.`id`))) join `kategori` `k` on((`l`.`kategorityp` = `k`.`typ`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_show_logg_extra_t`
--

/*!50001 DROP VIEW IF EXISTS `v_show_logg_extra_t`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_show_logg_extra_t` AS select `v_show_logg_extra`.`loggid` AS `LoggID`,`v_show_logg_extra`.`kategorityp` AS `Kategorityp`,`v_show_logg_extra`.`niva` AS `Nivå`,`v_show_logg_extra`.`orgid` AS `Org.ID`,`v_show_logg_extra`.`orgnamn` AS `Organisationsnamn`,`v_show_logg_extra`.`personid` AS `Pers.ID`,`v_show_logg_extra`.`namn` AS `Personnamn`,`v_show_logg_extra`.`vad` AS `Notering vad som hände` from `v_show_logg_extra` */;
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

-- Dump completed on 2019-03-28 13:41:35
