/*
 Navicat Premium Data Transfer

 Source Server         : cloud-mysql
 Source Server Type    : MySQL
 Source Server Version : 50640
 Source Host           : localhost:3306
 Source Schema         : cloud_partner

 Target Server Type    : MySQL
 Target Server Version : 50640
 File Encoding         : 65001

 Date: 25/10/2019 16:56:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for barangay
-- ----------------------------
DROP TABLE IF EXISTS `barangay`;
CREATE TABLE `barangay` (
  `objid` varchar(50) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for partner
-- ----------------------------
DROP TABLE IF EXISTS `partner`;
CREATE TABLE `partner` (
  `id` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `clusterid` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `subtype` varchar(50) DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `logo` longtext,
  `excludeservices` longtext,
  `includeservices` longtext,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uix_group_name` (`name`,`clusterid`) USING BTREE,
  KEY `fk_member_cluster` (`clusterid`) USING BTREE,
  CONSTRAINT `fk_partner_cluster` FOREIGN KEY (`clusterid`) REFERENCES `partner_cluster` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for partner_cluster
-- ----------------------------
DROP TABLE IF EXISTS `partner_cluster`;
CREATE TABLE `partner_cluster` (
  `objid` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for partner_field_conf
-- ----------------------------
DROP TABLE IF EXISTS `partner_field_conf`;
CREATE TABLE `partner_field_conf` (
  `objid` varchar(50) NOT NULL,
  `partnerid` varchar(50) NOT NULL,
  `txntype` varchar(50) NOT NULL,
  `exclude` text NOT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_partnerid` (`partnerid`) USING BTREE,
  KEY `ix_txntype` (`txntype`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for partner_online
-- ----------------------------
DROP TABLE IF EXISTS `partner_online`;
CREATE TABLE `partner_online` (
  `id` varchar(50) NOT NULL,
  `dtregistered` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;
