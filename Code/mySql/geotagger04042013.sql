CREATE DATABASE  IF NOT EXISTS `geotagger` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `geotagger`;
-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: geotagger
-- ------------------------------------------------------
-- Server version	5.6.10-log

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `AccountID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Username` varchar(15) NOT NULL DEFAULT 'New User',
  `Name` varchar(45) DEFAULT NULL,
  `EmailAddress` varchar(45) DEFAULT NULL,
  `Password` varchar(20) NOT NULL,
  `Image` blob,
  `Description` mediumtext,
  `Location` varchar(50) DEFAULT NULL,
  `Quote` tinytext,
  `Type` tinyint(4) NOT NULL DEFAULT '0',
  `Visibility` tinyint(4) NOT NULL DEFAULT '1',
  `CreatedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `RatingScore` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`AccountID`),
  UNIQUE KEY `AccountID_UNIQUE` (`AccountID`),
  UNIQUE KEY `Username_UNIQUE` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COMMENT='Stores User Account data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (4,'Testuser1','Chris L','loeschornc1@mail.montclair.edu','pass',NULL,'This is my test account','NJ','\"Hello\"',1,1,'2013-02-04 23:43:40',0),(9,'Testuser',NULL,NULL,'testpw',NULL,NULL,NULL,NULL,1,1,'2013-03-06 23:14:21',0),(11,'Chris',NULL,NULL,'mypass',NULL,NULL,NULL,NULL,1,1,'2013-03-27 04:42:34',0),(12,'Robotico',NULL,NULL,'Derpyy',NULL,NULL,NULL,NULL,1,1,'2013-03-29 03:20:30',0);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adventures`
--

DROP TABLE IF EXISTS `adventures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adventures` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OwnerID` int(10) unsigned NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Description` text,
  `Location` tinytext,
  `Visibility` tinyint(4) NOT NULL,
  `CreatedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_AdvOwner_idx` (`ID`),
  KEY `fk_oID_idx` (`ID`),
  KEY `fk_oID` (`OwnerID`),
  CONSTRAINT `fk_oID` FOREIGN KEY (`OwnerID`) REFERENCES `accounts` (`AccountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adventures`
--

LOCK TABLES `adventures` WRITE;
/*!40000 ALTER TABLE `adventures` DISABLE KEYS */;
INSERT INTO `adventures` VALUES (6,4,'New Adv',NULL,NULL,1,'2013-02-04 23:15:52');
/*!40000 ALTER TABLE `adventures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adventuretags`
--

DROP TABLE IF EXISTS `adventuretags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adventuretags` (
  `AdvID` int(10) unsigned NOT NULL,
  `TagID` bigint(20) unsigned NOT NULL,
  `TagIndex` int(10) unsigned NOT NULL,
  KEY `fk_AdvID_idx` (`AdvID`),
  KEY `fk_TagID_idx` (`TagID`),
  CONSTRAINT `fk_AdvID` FOREIGN KEY (`AdvID`) REFERENCES `adventures` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_TagID` FOREIGN KEY (`TagID`) REFERENCES `tags` (`TagID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adventuretags`
--

LOCK TABLES `adventuretags` WRITE;
/*!40000 ALTER TABLE `adventuretags` DISABLE KEYS */;
/*!40000 ALTER TABLE `adventuretags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friendassociations`
--

DROP TABLE IF EXISTS `friendassociations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friendassociations` (
  `uID` int(10) unsigned NOT NULL,
  `fID` int(10) unsigned NOT NULL,
  KEY `fk_uID_idx` (`uID`),
  KEY `fk_fID_idx` (`fID`),
  CONSTRAINT `fk_fID` FOREIGN KEY (`fID`) REFERENCES `accounts` (`AccountID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_uID` FOREIGN KEY (`uID`) REFERENCES `accounts` (`AccountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendassociations`
--

LOCK TABLES `friendassociations` WRITE;
/*!40000 ALTER TABLE `friendassociations` DISABLE KEYS */;
/*!40000 ALTER TABLE `friendassociations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupadventures`
--

DROP TABLE IF EXISTS `groupadventures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupadventures` (
  `gID` int(10) unsigned NOT NULL,
  `aID` int(10) unsigned NOT NULL,
  `AddedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_groupID_idx` (`gID`),
  KEY `fk_acctID_idx` (`aID`),
  CONSTRAINT `fk1_acctID` FOREIGN KEY (`aID`) REFERENCES `accounts` (`AccountID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk1_groupID` FOREIGN KEY (`gID`) REFERENCES `groups` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupadventures`
--

LOCK TABLES `groupadventures` WRITE;
/*!40000 ALTER TABLE `groupadventures` DISABLE KEYS */;
/*!40000 ALTER TABLE `groupadventures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupmembers`
--

DROP TABLE IF EXISTS `groupmembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupmembers` (
  `GroupID` int(10) unsigned NOT NULL,
  `aID` int(10) unsigned NOT NULL,
  `MemberType` tinyint(4) NOT NULL,
  `MemberSince` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_gID_idx` (`GroupID`),
  KEY `fk_aID_idx` (`aID`),
  CONSTRAINT `fk_aID` FOREIGN KEY (`aID`) REFERENCES `accounts` (`AccountID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_groupID` FOREIGN KEY (`GroupID`) REFERENCES `groups` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupmembers`
--

LOCK TABLES `groupmembers` WRITE;
/*!40000 ALTER TABLE `groupmembers` DISABLE KEYS */;
INSERT INTO `groupmembers` VALUES (3,4,0,'2013-02-10 22:11:42');
/*!40000 ALTER TABLE `groupmembers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` tinytext NOT NULL,
  `Description` text,
  `Image` blob,
  `CreationDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (3,'TestGroup','This is my test group',NULL,'2013-02-10 22:11:41');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grouptags`
--

DROP TABLE IF EXISTS `grouptags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grouptags` (
  `GroupID` int(10) unsigned NOT NULL,
  `TagID` bigint(20) unsigned NOT NULL,
  `AddedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_gID_idx` (`GroupID`),
  KEY `fk_tID_idx` (`TagID`),
  CONSTRAINT `fk_gID` FOREIGN KEY (`GroupID`) REFERENCES `groups` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tID` FOREIGN KEY (`TagID`) REFERENCES `tags` (`TagID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grouptags`
--

LOCK TABLES `grouptags` WRITE;
/*!40000 ALTER TABLE `grouptags` DISABLE KEYS */;
/*!40000 ALTER TABLE `grouptags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pendingrequests`
--

DROP TABLE IF EXISTS `pendingrequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pendingrequests` (
  `RequestID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `senderID` int(10) unsigned NOT NULL,
  `recipientID` int(10) unsigned NOT NULL,
  `Message` text,
  `RequestType` tinyint(4) NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`RequestID`),
  KEY `fk_Sender_idx` (`senderID`),
  KEY `fk_Recipient_idx` (`recipientID`),
  CONSTRAINT `fk_Recipient` FOREIGN KEY (`recipientID`) REFERENCES `accounts` (`AccountID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Sender` FOREIGN KEY (`senderID`) REFERENCES `accounts` (`AccountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pendingrequests`
--

LOCK TABLES `pendingrequests` WRITE;
/*!40000 ALTER TABLE `pendingrequests` DISABLE KEYS */;
/*!40000 ALTER TABLE `pendingrequests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagcomments`
--

DROP TABLE IF EXISTS `tagcomments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagcomments` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ParentTagID` bigint(20) unsigned NOT NULL,
  `Title` tinytext,
  `Text` text,
  `CreatedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `RatingScore` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `fk_pTagID_idx` (`ParentTagID`),
  CONSTRAINT `fk_pTagID` FOREIGN KEY (`ParentTagID`) REFERENCES `tags` (`TagID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagcomments`
--

LOCK TABLES `tagcomments` WRITE;
/*!40000 ALTER TABLE `tagcomments` DISABLE KEYS */;
/*!40000 ALTER TABLE `tagcomments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `TagID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `OwnerID` int(10) unsigned NOT NULL,
  `Visibility` int(11) NOT NULL DEFAULT '1',
  `Name` varchar(35) NOT NULL,
  `Description` text,
  `ImageUrl` tinytext,
  `Location` tinytext,
  `Latitude` double DEFAULT NULL,
  `Longitude` double DEFAULT NULL,
  `CreatedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Category` tinytext,
  `RatingScore` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`TagID`),
  UNIQUE KEY `TagID_UNIQUE` (`TagID`),
  KEY `oID_idx` (`OwnerID`),
  CONSTRAINT `fk_tagOwner` FOREIGN KEY (`OwnerID`) REFERENCES `accounts` (`AccountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (5,11,1,'My Tag','This is my test tag.','http://10.0.2.2/geotagger/images/042013515b9e1309982.jpg','NJ',NULL,NULL,'2013-04-03 03:12:19','Default',0),(6,11,1,'My Second Tag','This is my second test tag.','http://10.0.2.2/geotagger/images/042013/515b9ed20ca0a.jpg','NJ',NULL,NULL,'2013-04-03 03:15:32','Default',0);
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'geotagger'
--
/*!50003 DROP FUNCTION IF EXISTS `AddTag` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `AddTag`(
 ownerID INT, tagName varchar(35), Vis int, Descr Text, Image TinyText, Location TinyText,
		Lat double, Lon double, cat tinytext) RETURNS mediumtext CHARSET latin1
BEGIN

	Insert into Tags(ownerID, Visibility, Name, Description, ImageUrl, Location, Latitude, 
		Longitude, CreatedDateTime, Category)
	Values(ownerID, Vis, tagName, Descr, Image, Location,
		Lat, Lon, now(), cat);

	Return LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `Adv_GetNextIndex` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `Adv_GetNextIndex`(advID INT) RETURNS int(11)
BEGIN
Declare nextIndex Int;
Declare count Int;
Declare done Boolean;

Set count = (Select count(*) from AdventureTags where AdvID = advID)+1;
Set done = FALSE;
-- check the index to ensure it is unique, if not increment until a unique index is found
While !done DO
	IF (Select count(*) from AdventureTags where AdvID = advID and TagIndex = count) > 0 
	THEN
		set count = count + 1;
	Else set done = TRUE;
	End IF;
End While;


RETURN count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `TagExists_InAdv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `TagExists_InAdv`(advID INT, tagID BIGINT) RETURNS int(11)
BEGIN
	Declare chk INT;
	-- if the tag does not exist in the adventure, 0 will be returned
	Select Count(*) into chk from AdventureTags A Where A.AdvID = advID AND A.TagID = tagID;
	return chk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `TagExists_InGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `TagExists_InGroup`(gID INT, tID BIGINT) RETURNS int(11)
BEGIN
	Declare chk INT;
	-- if the tag does not exist in the group, 0 will be returned
	Select Count(*) into chk from GroupTags g Where g.GroupID = gID AND g.TagID = tID;
	return chk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAccount`(
IN uName varchar(15),
IN Pw varchar(20)
)
BEGIN
	 Insert into Accounts(Username, Password, Type, Visibility,
			CreatedDateTime)
	VALUES(uName, Pw, 1, 1, now());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddAdventure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAdventure`(
IN oID INT,
IN Name varchar(45),
IN des Text,
IN loc TinyText,
In vis TinyInt
)
BEGIN

	Insert Into Adventures(OwnerID, Name, Description, Location,
		Visibility, CreatedDateTime) 
	Values(oID, Name, des, loc, vis, now());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddGroup`(
IN n Tinytext,
IN descr Text,
In creatorID INT
)
BEGIN
	Insert INTO Groups(Name, Description, CreationDateTime)
		Values(n, descr, now());
	Insert INTO GroupMembers(GroupID, aID, MemberType, MemberSince)
		Values(LAST_INSERT_ID(), creatorID, 0, now());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddTagComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTagComment`(
	IN pID BIGINT,
	IN ttl tinyText,
	IN txt Text
)
BEGIN
	Insert into TagComments(ParentTagID, Title, Text, CreatedDateTime) 
		Values(pID, ttl, txt, now());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddTag_OLD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTag_OLD`(
IN ownerID INT,
IN tagName varchar(35),
IN Vis int,
IN Descr Text,
In Image TinyText,
IN Location TinyText,
IN Lat double,
IN Lon double,
IN cat tinytext,
Out tagId long
)
BEGIN

	Insert into Tags(ownerID, Visibility, Name, Description, Image, Location, Latitude, 
		Longitude, CreatedDateTime, Category)
	Values(ownerID, Vis, tagName, Descr, Image, Location,
		Lat, Lon, now(), cat);

	Set tagId = 12345;
	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddTag_ToAdventure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTag_ToAdventure`(
In advID INT,
In tagID BigInt
)
BEGIN
	Declare i INT;
	IF(TagExists_InAdv(advID, tagID)) = 0 THEN
		SET i = (Adv_GetNextIndex(advID));
		Insert into AdventureTags(AdvID, TagID, TagIndex)
			VALUES(advID,tagID, i);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddTag_ToGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTag_ToGroup`(
IN gID INT,
IN tID BIGINT
)
BEGIN
	IF(TagExists_InGroup(gID, tID)) = 0 THEN
		Insert Into GroupTags(GroupID, TagID, AddedDateTime)
			Values(gID, tID, now());
	End IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteTagComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteTagComment`(
	IN cID BIGINT
)
BEGIN
-- Delete a specified comment from a tag
	Delete from TagComments where ID = cID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EditAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditAccount`(
IN uName varchar(15),
IN name varchar(45),
IN Email varchar(45),
IN Pw varchar(20),
In Img blob,
In Des MEDIUMTEXT,
In Loc varchar(50),
In Quote TinyText,
In typ tinyint,
In vis tinyint
)
BEGIN
	 Insert into Accounts(Username, Name, EmailAddress, Password,
		Image, Description, Location, Quote, Type, Visibility,
			CreatedDateTime)
	VALUES(uName, name, Email, Pw, Img, Des, Loc, Quote,
		typ, vis, now());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RemoveTag_FromGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RemoveTag_FromGroup`(
gID INT,
tID BIGINT
)
BEGIN
-- remove the specified tag from the groupTags of the given group
Delete from GroupTags where GroupID = gID and TagID = tID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SendRequest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SendRequest`(
	IN sID INT,
	IN rID INT,
	IN msg TEXT,
	IN typ TinyINT
)
BEGIN
-- send a request if one of the same type does not already exist between the two users. 
	IF (Select Count(*) from PendingRequests p where p.senderID = sID and p.recipientID = rID and p.RequestType = typ) = 0 THEN
		Insert Into PendingRequests(senderID, recipientID, Message, RequestType, TimeStamp)
			Values (sID, rID, msg, typ, now());
	End IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Test_AddAccounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Test_AddAccounts`(
IN numUsers INT
)
BEGIN
declare i INT;
declare name varchar(20);

Select Count(*) into i from Accounts;
Set numUsers = numUsers + i;

While i < numUsers DO

	set name = CONCAT('User', i);

	Insert into Accounts (Username, Name, Password, Description, 
		Type, Visibility, CreatedDateTime)
	Values(name, name, 'testpw', 'my test account',1, 1, now());
	
	SET i = i+1;
End While;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Test_AddTestAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Test_AddTestAccount`()
BEGIN

	call AddAccount('Testuser1', 'Chris L', 'loeschornc1@mail.montclair.edu',
		'pass', null, 'This is my test account', 'NJ', '"Hello"', 
			1,1);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-04-04 21:11:12
