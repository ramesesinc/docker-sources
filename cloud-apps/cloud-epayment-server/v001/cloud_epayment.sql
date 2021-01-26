/*
 Navicat Premium Data Transfer

 Source Server         : cloud-mysql
 Source Server Type    : MySQL
 Source Server Version : 50640
 Source Host           : localhost:3306
 Source Schema         : cloud_epayment

 Target Server Type    : MySQL
 Target Server Version : 50640
 File Encoding         : 65001

 Date: 25/10/2019 16:55:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for api_account
-- ----------------------------
DROP TABLE IF EXISTS `api_account`;
CREATE TABLE `api_account` (
  `objid` varchar(25) NOT NULL,
  `state` varchar(25) NOT NULL,
  `dtfiled` datetime NOT NULL,
  `filedby` varchar(150) NOT NULL,
  `name` varchar(150) NOT NULL,
  `secretkey` varchar(50) NOT NULL,
  `partnerid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_dtfiled` (`dtfiled`) USING BTREE,
  KEY `ix_filedby` (`filedby`) USING BTREE,
  KEY `ix_name` (`name`) USING BTREE,
  KEY `ix_partnerid` (`partnerid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
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
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_paymentrefid` (`paymentrefid`) USING BTREE,
  KEY `ix_txndate` (`txndate`) USING BTREE,
  KEY `ix_traceid` (`traceid`) USING BTREE,
  KEY `ix_tracedate` (`tracedate`) USING BTREE,
  KEY `ix_receiptid` (`receiptid`) USING BTREE,
  KEY `ix_receiptno` (`receiptno`) USING BTREE,
  KEY `ix_receiptdate` (`receiptdate`) USING BTREE,
  KEY `ix_partnercode` (`paypartnerid`) USING BTREE,
  CONSTRAINT `fk_paypartnerid` FOREIGN KEY (`paypartnerid`) REFERENCES `payment_partner` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for payment_partner
-- ----------------------------
DROP TABLE IF EXISTS `payment_partner`;
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
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for payment_partner_option
-- ----------------------------
DROP TABLE IF EXISTS `payment_partner_option`;
CREATE TABLE `payment_partner_option` (
  `objid` varchar(50) NOT NULL,
  `partnerid` varchar(50) DEFAULT NULL,
  `paypartnerid` varchar(50) DEFAULT NULL,
  `info` longtext,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_partner` (`partnerid`) USING BTREE,
  KEY `fk_payment_partner` (`paypartnerid`) USING BTREE,
  CONSTRAINT `fk_payment_partner` FOREIGN KEY (`paypartnerid`) REFERENCES `payment_partner` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for payment_partnerinfo
-- ----------------------------
DROP TABLE IF EXISTS `payment_partnerinfo`;
CREATE TABLE `payment_partnerinfo` (
  `objid` varchar(50) NOT NULL,
  `partnerid` varchar(50) DEFAULT NULL,
  `webfee` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_partnerid` (`partnerid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for paymentorder
-- ----------------------------
DROP TABLE IF EXISTS `paymentorder`;
CREATE TABLE `paymentorder` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime DEFAULT NULL,
  `txntype` varchar(25) NOT NULL,
  `txntypename` varchar(100) NOT NULL,
  `orgcode` varchar(25) NOT NULL,
  `refno` varchar(50) NOT NULL,
  `paymentrefid` varchar(100) NOT NULL,
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
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_paymentrefid` (`paymentrefid`) USING BTREE,
  KEY `ix_txntype` (`txntype`) USING BTREE,
  KEY `ix_orgcode` (`orgcode`) USING BTREE,
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `uix_controlno` (`controlno`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for paymentorder_paid
-- ----------------------------
DROP TABLE IF EXISTS `paymentorder_paid`;
CREATE TABLE `paymentorder_paid` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime DEFAULT NULL,
  `txntype` varchar(25) NOT NULL,
  `txntypename` varchar(100) NOT NULL,
  `orgcode` varchar(25) NOT NULL,
  `refno` varchar(50) NOT NULL,
  `paymentrefid` varchar(100) NOT NULL,
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
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_paymentrefid` (`paymentrefid`) USING BTREE,
  KEY `ix_txntype` (`txntype`) USING BTREE,
  KEY `ix_orgcode` (`orgcode`) USING BTREE,
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `uix_controlno` (`controlno`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_sequence
-- ----------------------------
DROP TABLE IF EXISTS `sys_sequence`;
CREATE TABLE `sys_sequence` (
  `objid` varchar(100) NOT NULL,
  `nextSeries` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_session
-- ----------------------------
DROP TABLE IF EXISTS `sys_session`;
CREATE TABLE `sys_session` (
  `sessionid` varchar(50) NOT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `clienttype` varchar(12) DEFAULT NULL,
  `accesstime` datetime DEFAULT NULL,
  `accessexpiry` datetime DEFAULT NULL,
  `timein` datetime DEFAULT NULL,
  PRIMARY KEY (`sessionid`) USING BTREE,
  KEY `ix_timein` (`timein`) USING BTREE,
  KEY `ix_userid` (`userid`) USING BTREE,
  KEY `ix_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_session_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_session_log`;
CREATE TABLE `sys_session_log` (
  `sessionid` varchar(50) NOT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `clienttype` varchar(12) DEFAULT NULL,
  `accesstime` datetime DEFAULT NULL,
  `accessexpiry` datetime DEFAULT NULL,
  `timein` datetime DEFAULT NULL,
  `timeout` datetime DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`sessionid`) USING BTREE,
  KEY `ix_timein` (`timein`) USING BTREE,
  KEY `ix_timeout` (`timeout`) USING BTREE,
  KEY `ix_userid` (`userid`) USING BTREE,
  KEY `ix_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_var
-- ----------------------------
DROP TABLE IF EXISTS `sys_var`;
CREATE TABLE `sys_var` (
  `name` varchar(50) NOT NULL,
  `value` longtext,
  `description` varchar(255) DEFAULT NULL,
  `datatype` varchar(15) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
