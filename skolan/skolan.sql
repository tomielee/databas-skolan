-- MySQL dump 10.13  Distrib 8.0.14, for macos10.14 (x86_64)
--
-- Host: localhost    Database: skolan
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
-- Table structure for table `kurs`
--

DROP TABLE IF EXISTS `kurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `kurs` (
  `kod` char(6) COLLATE utf8_swedish_ci NOT NULL,
  `namn` varchar(40) COLLATE utf8_swedish_ci DEFAULT NULL,
  `poang` float DEFAULT NULL,
  `niva` char(3) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`kod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kurs`
--

LOCK TABLES `kurs` WRITE;
/*!40000 ALTER TABLE `kurs` DISABLE KEYS */;
INSERT INTO `kurs` VALUES ('AST101','Astronomi',5,'G1N'),('DJU101','Skötsel och vård av magiska djur',4,'G1F'),('DRY101','Trolldryckslära',6,'G1N'),('DRY102','Trolldryckslära',6,'G1F'),('KVA101','Kvastflygning',4,'G1N'),('MUG101','Mugglarstudier',6,'G1F'),('SVT101','Försvar mot svartkonster',8,'G1N'),('SVT201','Försvar mot svartkonster',6,'G1F'),('SVT202','Försvar mot svartkonster',6,'G1F'),('SVT401','Försvar mot svartkonster',6,'G2F'),('VAN101','Förvandlingskonst',5,'G1F');
/*!40000 ALTER TABLE `kurs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kurstillfalle`
--

DROP TABLE IF EXISTS `kurstillfalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `kurstillfalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kurskod` char(6) COLLATE utf8_swedish_ci NOT NULL,
  `kursansvarig` char(3) COLLATE utf8_swedish_ci NOT NULL,
  `lasperiod` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `kurskod` (`kurskod`),
  KEY `kursansvarig` (`kursansvarig`),
  CONSTRAINT `kurstillfalle_ibfk_1` FOREIGN KEY (`kurskod`) REFERENCES `kurs` (`kod`),
  CONSTRAINT `kurstillfalle_ibfk_2` FOREIGN KEY (`kursansvarig`) REFERENCES `teacher` (`acronym`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kurstillfalle`
--

LOCK TABLES `kurstillfalle` WRITE;
/*!40000 ALTER TABLE `kurstillfalle` DISABLE KEYS */;
INSERT INTO `kurstillfalle` VALUES (226,'SVT101','gyl',1),(227,'SVT101','gyl',3),(228,'SVT201','ala',1),(229,'SVT202','ala',2),(230,'SVT401','sna',1),(231,'KVA101','hoc',1),(232,'DJU101','hag',3),(233,'DRY101','sna',2),(234,'DRY102','sna',3),(235,'MUG101','min',4);
/*!40000 ALTER TABLE `kurstillfalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `person` (
  `fornamn` varchar(10) COLLATE utf8_swedish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('Örjan'),('Börje'),('Bo'),('Øjvind'),('Åke'),('Åkesson'),('Arne'),('Ängla'),('Ægir');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `teacher` (
  `acronym` char(3) COLLATE utf8_swedish_ci NOT NULL,
  `section` char(4) COLLATE utf8_swedish_ci DEFAULT NULL,
  `fname` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `sirname` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `sex` char(1) COLLATE utf8_swedish_ci DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `competence` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`acronym`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES ('ala','DIPT','Alastor','Moody','M',27594,'1943-04-03',1),('dum','ADM','Albus','Dumbledore','M',85000,'1941-04-01',7),('fil','ADM','Argus','Filch','M',27594,'1946-04-06',3),('gyl','DIPT','Gyllenroy','Lockman','M',27594,'1952-05-02',1),('hag','ADM','Hagrid','Rubeus','M',30000,'1956-05-06',2),('hoc','DIDD','Madam','Hooch','F',37580,'1948-04-08',1),('min','DIDD','Minerva','McGonagall','F',49880,'1955-05-05',2),('sna','DIPT','Severus','Snape','M',45000,'1951-05-01',2);
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_pre`
--

DROP TABLE IF EXISTS `teacher_pre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `teacher_pre` (
  `acronym` char(3) COLLATE utf8_swedish_ci NOT NULL,
  `section` char(4) COLLATE utf8_swedish_ci DEFAULT NULL,
  `fname` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `sirname` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `sex` char(1) COLLATE utf8_swedish_ci DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `competence` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`acronym`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_pre`
--

LOCK TABLES `teacher_pre` WRITE;
/*!40000 ALTER TABLE `teacher_pre` DISABLE KEYS */;
INSERT INTO `teacher_pre` VALUES ('ala','DIPT','Alastor','Moody','M',30000,'1943-04-03',1),('dum','ADM','Albus','Dumbledore','M',80000,'1941-04-01',1),('fil','ADM','Argus','Filch','M',25000,'1946-04-06',1),('gyl','DIPT','Gyllenroy','Lockman','M',30000,'1952-05-02',1),('hag','ADM','Hagrid','Rubeus','M',25000,'1956-05-06',1),('hoc','DIDD','Madam','Hooch','F',35000,'1948-04-08',1),('min','DIDD','Minerva','McGonagall','F',40000,'1955-05-05',1),('sna','DIPT','Severus','Snape','M',40000,'1951-05-01',1);
/*!40000 ALTER TABLE `teacher_pre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_larare`
--

DROP TABLE IF EXISTS `v_larare`;
/*!50001 DROP VIEW IF EXISTS `v_larare`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_larare` AS SELECT 
 1 AS `acronym`,
 1 AS `section`,
 1 AS `fname`,
 1 AS `sirname`,
 1 AS `sex`,
 1 AS `salary`,
 1 AS `birth`,
 1 AS `competence`,
 1 AS `Age`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_lonerevision`
--

DROP TABLE IF EXISTS `v_lonerevision`;
/*!50001 DROP VIEW IF EXISTS `v_lonerevision`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_lonerevision` AS SELECT 
 1 AS `Acro`,
 1 AS `Fname`,
 1 AS `SName`,
 1 AS `Presal`,
 1 AS `Nowsal`,
 1 AS `Precomp`,
 1 AS `Nowcomp`,
 1 AS `proc`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_name_age`
--

DROP TABLE IF EXISTS `v_name_age`;
/*!50001 DROP VIEW IF EXISTS `v_name_age`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_name_age` AS SELECT 
 1 AS `Name Section`,
 1 AS `Age`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_planering`
--

DROP TABLE IF EXISTS `v_planering`;
/*!50001 DROP VIEW IF EXISTS `v_planering`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_planering` AS SELECT 
 1 AS `kod`,
 1 AS `namn`,
 1 AS `poang`,
 1 AS `niva`,
 1 AS `id`,
 1 AS `kurskod`,
 1 AS `kursansvarig`,
 1 AS `lasperiod`,
 1 AS `acronym`,
 1 AS `section`,
 1 AS `fname`,
 1 AS `sirname`,
 1 AS `sex`,
 1 AS `salary`,
 1 AS `birth`,
 1 AS `competence`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_larare`
--

/*!50001 DROP VIEW IF EXISTS `v_larare`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`user`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_larare` AS select `teacher`.`acronym` AS `acronym`,`teacher`.`section` AS `section`,`teacher`.`fname` AS `fname`,`teacher`.`sirname` AS `sirname`,`teacher`.`sex` AS `sex`,`teacher`.`salary` AS `salary`,`teacher`.`birth` AS `birth`,`teacher`.`competence` AS `competence`,timestampdiff(YEAR,`teacher`.`birth`,curdate()) AS `Age` from `teacher` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_lonerevision`
--

/*!50001 DROP VIEW IF EXISTS `v_lonerevision`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`user`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_lonerevision` AS select `t`.`acronym` AS `Acro`,`t`.`fname` AS `Fname`,`t`.`sirname` AS `SName`,`p`.`salary` AS `Presal`,`t`.`salary` AS `Nowsal`,`p`.`competence` AS `Precomp`,`t`.`competence` AS `Nowcomp`,round((((`t`.`salary` - `p`.`salary`) / `p`.`salary`) * 100),2) AS `proc` from (`teacher` `t` join `teacher_pre` `p` on((`t`.`acronym` = `p`.`acronym`))) order by round((((`t`.`salary` - `p`.`salary`) / `p`.`salary`) * 100),2) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_name_age`
--

/*!50001 DROP VIEW IF EXISTS `v_name_age`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`user`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_name_age` AS select concat_ws(' ',`teacher`.`fname`,`teacher`.`sirname`,concat('(',lower(`teacher`.`section`),')')) AS `Name Section`,timestampdiff(YEAR,`teacher`.`birth`,curdate()) AS `Age` from `teacher` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_planering`
--

/*!50001 DROP VIEW IF EXISTS `v_planering`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_planering` AS select `k`.`kod` AS `kod`,`k`.`namn` AS `namn`,`k`.`poang` AS `poang`,`k`.`niva` AS `niva`,`kt`.`id` AS `id`,`kt`.`kurskod` AS `kurskod`,`kt`.`kursansvarig` AS `kursansvarig`,`kt`.`lasperiod` AS `lasperiod`,`t`.`acronym` AS `acronym`,`t`.`section` AS `section`,`t`.`fname` AS `fname`,`t`.`sirname` AS `sirname`,`t`.`sex` AS `sex`,`t`.`salary` AS `salary`,`t`.`birth` AS `birth`,`t`.`competence` AS `competence` from ((`kurs` `k` join `kurstillfalle` `kt` on((`k`.`kod` = `kt`.`kurskod`))) join `teacher` `t` on((`t`.`acronym` = `kt`.`kursansvarig`))) */;
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

-- Dump completed on 2019-02-14 11:22:00
