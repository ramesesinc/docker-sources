-- MySQL dump 10.13  Distrib 5.5.59, for Win64 (AMD64)
--
-- Host: localhost    Database: cloud_epayment
-- ------------------------------------------------------
-- Server version	5.5.59

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
-- Current Database: `cloud_epayment`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cloud_epayment` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `cloud_epayment`;

--
-- Table structure for table `api_account`
--

DROP TABLE IF EXISTS `api_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_account` (
  `objid` varchar(25) NOT NULL,
  `state` varchar(25) NOT NULL,
  `dtfiled` datetime NOT NULL,
  `filedby` varchar(150) NOT NULL,
  `name` varchar(150) NOT NULL,
  `secretkey` varchar(50) NOT NULL,
  `partnerid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_dtfiled` (`dtfiled`),
  KEY `ix_filedby` (`filedby`),
  KEY `ix_name` (`name`),
  KEY `ix_partnerid` (`partnerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `objid` varchar(50) NOT NULL,
  `orgcode` varchar(50) DEFAULT NULL,
  `paypartnerid` varchar(20) NOT NULL,
  `paymentrefid` varchar(100) NOT NULL,
  `txndate` datetime NOT NULL,
  `traceid` varchar(150) NOT NULL,
  `tracedate` datetime NOT NULL,
  `amount` decimal(16,4) NOT NULL,
  `receiptid` varchar(50) DEFAULT NULL,
  `receiptno` varchar(50) DEFAULT NULL,
  `receiptdate` datetime DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_paymentrefid` (`paymentrefid`),
  KEY `ix_txndate` (`txndate`),
  KEY `ix_traceid` (`traceid`),
  KEY `ix_tracedate` (`tracedate`),
  KEY `ix_receiptid` (`receiptid`),
  KEY `ix_receiptno` (`receiptno`),
  KEY `ix_receiptdate` (`receiptdate`),
  KEY `ix_partnercode` (`paypartnerid`),
  CONSTRAINT `fk_payment_paymentrefid` FOREIGN KEY (`paymentrefid`) REFERENCES `paymentorder_paid` (`objid`),
  CONSTRAINT `fk_paypartnerid` FOREIGN KEY (`paypartnerid`) REFERENCES `payment_partner` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_partner`
--

DROP TABLE IF EXISTS `payment_partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_partner` (
  `objid` varchar(50) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(3) DEFAULT NULL,
  `actionurl` varchar(255) DEFAULT NULL,
  `caption` varchar(50) NOT NULL,
  `info` text NOT NULL,
  `allowsend` int(11) NOT NULL,
  `allowpay` int(11) NOT NULL,
  `state` varchar(20) NOT NULL,
  `requirecheckout` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_partner_option`
--

DROP TABLE IF EXISTS `payment_partner_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_partner_option` (
  `objid` varchar(50) NOT NULL,
  `partnerid` varchar(50) DEFAULT NULL,
  `paypartnerid` varchar(50) DEFAULT NULL,
  `info` longtext,
  PRIMARY KEY (`objid`),
  KEY `fk_partner` (`partnerid`),
  KEY `fk_payment_partner` (`paypartnerid`),
  CONSTRAINT `fk_payment_partner` FOREIGN KEY (`paypartnerid`) REFERENCES `payment_partner` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_partnerinfo`
--

DROP TABLE IF EXISTS `payment_partnerinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_partnerinfo` (
  `objid` varchar(50) NOT NULL,
  `partnerid` varchar(50) DEFAULT NULL,
  `webfee` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`objid`),
  KEY `ix_partnerid` (`partnerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paymentorder`
--

DROP TABLE IF EXISTS `paymentorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentorder` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime DEFAULT NULL,
  `txntype` varchar(25) NOT NULL,
  `txntypename` varchar(100) NOT NULL,
  `orgcode` varchar(25) NOT NULL,
  `refno` varchar(50) NOT NULL,
  `_paymentrefid` varchar(50) DEFAULT NULL,
  `amount` decimal(16,4) NOT NULL,
  `controlno` varchar(25) NOT NULL,
  `paidby` varchar(255) NOT NULL,
  `particulars` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobileno` varchar(150) DEFAULT NULL,
  `phoneno` varchar(150) DEFAULT NULL,
  `origin` varchar(32) DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  `webfee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `cachekey` varchar(50) DEFAULT NULL,
  `checkoutid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_paymentrefid` (`_paymentrefid`),
  KEY `ix_txntype` (`txntype`),
  KEY `ix_orgcode` (`orgcode`),
  KEY `ix_refno` (`refno`),
  KEY `uix_controlno` (`controlno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paymentorder_cancelled`
--

DROP TABLE IF EXISTS `paymentorder_cancelled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentorder_cancelled` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime DEFAULT NULL,
  `txntype` varchar(25) NOT NULL,
  `txntypename` varchar(100) NOT NULL,
  `orgcode` varchar(25) NOT NULL,
  `refno` varchar(50) NOT NULL,
  `_paymentrefid` varchar(50) DEFAULT NULL,
  `amount` decimal(16,4) NOT NULL,
  `controlno` varchar(25) NOT NULL,
  `paidby` varchar(255) NOT NULL,
  `particulars` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobileno` varchar(150) DEFAULT NULL,
  `phoneno` varchar(150) DEFAULT NULL,
  `origin` varchar(32) DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  `webfee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `cachekey` varchar(50) DEFAULT NULL,
  `checkoutid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_paymentrefid` (`_paymentrefid`),
  KEY `ix_txntype` (`txntype`),
  KEY `ix_orgcode` (`orgcode`),
  KEY `ix_refno` (`refno`),
  KEY `uix_controlno` (`controlno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paymentorder_paid`
--

DROP TABLE IF EXISTS `paymentorder_paid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentorder_paid` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime DEFAULT NULL,
  `txntype` varchar(25) NOT NULL,
  `txntypename` varchar(100) NOT NULL,
  `orgcode` varchar(25) NOT NULL,
  `refno` varchar(50) NOT NULL,
  `_paymentrefid` varchar(50) DEFAULT NULL,
  `amount` decimal(16,4) NOT NULL,
  `controlno` varchar(25) NOT NULL,
  `paidby` varchar(255) NOT NULL,
  `particulars` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobileno` varchar(150) DEFAULT NULL,
  `phoneno` varchar(150) DEFAULT NULL,
  `origin` varchar(32) DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  `webfee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `cachekey` varchar(50) DEFAULT NULL,
  `checkoutid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_paymentrefid` (`_paymentrefid`),
  KEY `ix_txntype` (`txntype`),
  KEY `ix_orgcode` (`orgcode`),
  KEY `ix_refno` (`refno`),
  KEY `uix_controlno` (`controlno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_sequence`
--

DROP TABLE IF EXISTS `sys_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_sequence` (
  `objid` varchar(100) NOT NULL,
  `nextSeries` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_var`
--

DROP TABLE IF EXISTS `sys_var`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_var` (
  `name` varchar(50) NOT NULL,
  `value` longtext,
  `description` varchar(255) DEFAULT NULL,
  `datatype` varchar(15) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-12 22:24:46
