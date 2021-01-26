/*
 Navicat Premium Data Transfer

 Source Server         : cloud-mysql
 Source Server Type    : MySQL
 Source Server Version : 50640
 Source Host           : localhost:3306
 Source Schema         : cloud_obo

 Target Server Type    : MySQL
 Target Server Version : 50640
 File Encoding         : 65001

 Date: 25/10/2019 16:56:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for obo_costitem
-- ----------------------------
DROP TABLE IF EXISTS `obo_costitem`;
CREATE TABLE `obo_costitem` (
  `objid` varchar(50) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for obo_occupancy_type
-- ----------------------------
DROP TABLE IF EXISTS `obo_occupancy_type`;
CREATE TABLE `obo_occupancy_type` (
  `objid` varchar(50) NOT NULL,
  `divisionid` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_occupancy_use_typeid` (`divisionid`) USING BTREE,
  CONSTRAINT `fk_obo_occupancytype_divisionid` FOREIGN KEY (`divisionid`) REFERENCES `obo_occupancy_type_division` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for obo_occupancy_type_division
-- ----------------------------
DROP TABLE IF EXISTS `obo_occupancy_type_division`;
CREATE TABLE `obo_occupancy_type_division` (
  `objid` varchar(50) NOT NULL,
  `groupid` varchar(50) DEFAULT NULL,
  `title` text,
  `type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_occupancyuse` (`groupid`) USING BTREE,
  CONSTRAINT `obo_occupancy_type_division_ibfk_1` FOREIGN KEY (`groupid`) REFERENCES `obo_occupancy_type_group` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for obo_occupancy_type_group
-- ----------------------------
DROP TABLE IF EXISTS `obo_occupancy_type_group`;
CREATE TABLE `obo_occupancy_type_group` (
  `objid` varchar(50) NOT NULL,
  `title` text,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for obo_permit_type
-- ----------------------------
DROP TABLE IF EXISTS `obo_permit_type`;
CREATE TABLE `obo_permit_type` (
  `objid` varchar(50) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `sortorder` smallint(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for obo_requirement_type
-- ----------------------------
DROP TABLE IF EXISTS `obo_requirement_type`;
CREATE TABLE `obo_requirement_type` (
  `objid` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `sortorder` int(255) DEFAULT NULL,
  `permittype` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for obo_variable
-- ----------------------------
DROP TABLE IF EXISTS `obo_variable`;
CREATE TABLE `obo_variable` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `datatype` varchar(100) DEFAULT NULL,
  `typeid` varchar(50) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `sortorder` smallint(3) DEFAULT NULL,
  `system` smallint(3) DEFAULT NULL,
  `arrayvalues` text,
  `unit` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_obo_variable_name` (`name`) USING BTREE,
  KEY `fk_obo_section_variable` (`typeid`) USING BTREE,
  KEY `ix_state` (`state`) USING BTREE,
  KEY `ix_caption` (`caption`) USING BTREE,
  KEY `ix_datatype` (`datatype`) USING BTREE,
  KEY `ix_category` (`category`) USING BTREE,
  KEY `ix_sortorder` (`sortorder`) USING BTREE,
  KEY `ix_system` (`system`) USING BTREE,
  KEY `ix_unit` (`unit`) USING BTREE,
  CONSTRAINT `fx_obo_variable_typeid` FOREIGN KEY (`typeid`) REFERENCES `obo_variable_type` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for obo_variable_type
-- ----------------------------
DROP TABLE IF EXISTS `obo_variable_type`;
CREATE TABLE `obo_variable_type` (
  `objid` varchar(50) CHARACTER SET utf8 NOT NULL,
  `title` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `sortindex` int(255) DEFAULT NULL,
  `accessory` int(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for obo_work_type
-- ----------------------------
DROP TABLE IF EXISTS `obo_work_type`;
CREATE TABLE `obo_work_type` (
  `objid` varchar(50) NOT NULL,
  `description` text,
  `idx` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for obo_zoneclass
-- ----------------------------
DROP TABLE IF EXISTS `obo_zoneclass`;
CREATE TABLE `obo_zoneclass` (
  `objid` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_building_permit
-- ----------------------------
DROP TABLE IF EXISTS `online_building_permit`;
CREATE TABLE `online_building_permit` (
  `objid` varchar(50) NOT NULL,
  `orgcode` varchar(50) DEFAULT NULL,
  `apptype` varchar(50) DEFAULT NULL,
  `permittype` varchar(50) DEFAULT NULL,
  `contact_name` varchar(50) DEFAULT NULL,
  `contact_detail` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_mobileno` varchar(50) DEFAULT NULL,
  `dtfiled` varchar(200) DEFAULT NULL,
  `location_lotno` varchar(50) DEFAULT NULL,
  `location_blockno` varchar(50) DEFAULT NULL,
  `location_street` varchar(255) DEFAULT NULL,
  `location_barangay_name` varchar(255) DEFAULT NULL,
  `location_barangay_objid` varchar(50) DEFAULT NULL,
  `applicantid` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `occupancytypeid` varchar(50) DEFAULT NULL,
  `numunits` smallint(3) DEFAULT NULL,
  `projectcost` decimal(16,2) DEFAULT NULL,
  `dtproposedconstruction` date DEFAULT NULL,
  `dtexpectedcompletion` date DEFAULT NULL,
  `totalfloorarea` decimal(16,2) DEFAULT NULL,
  `height` decimal(16,2) DEFAULT NULL,
  `numfloors` smallint(255) DEFAULT NULL,
  `step` int(50) DEFAULT NULL,
  `worktypes` tinytext,
  `accessoryid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_app_occupancyuseid` (`occupancytypeid`) USING BTREE,
  KEY `ix_units` (`numunits`) USING BTREE,
  KEY `ix_estimatedcost` (`projectcost`) USING BTREE,
  KEY `ix_dtproposedconstruction` (`dtproposedconstruction`) USING BTREE,
  KEY `ix_dtexpectedcompletion` (`dtexpectedcompletion`) USING BTREE,
  KEY `fk_online_building_permit_applicantid` (`applicantid`),
  KEY `fk_online_building_permit_accessoryid` (`accessoryid`),
  CONSTRAINT `fk_online_building_permit_accessoryid` FOREIGN KEY (`accessoryid`) REFERENCES `online_building_permit_accessory` (`objid`),
  CONSTRAINT `fk_online_building_permit_applicantid` FOREIGN KEY (`applicantid`) REFERENCES `online_building_permit_entity` (`objid`),
  CONSTRAINT `fk_online_building_permit_occupancytypeid` FOREIGN KEY (`occupancytypeid`) REFERENCES `obo_occupancy_type` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_building_permit_accessory
-- ----------------------------
DROP TABLE IF EXISTS `online_building_permit_accessory`;
CREATE TABLE `online_building_permit_accessory` (
  `objid` varchar(50) NOT NULL,
  `appid` varchar(50) DEFAULT NULL,
  `occupancytypeid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_online_building_permit_accessory_occupancytypeid` (`occupancytypeid`),
  CONSTRAINT `fk_online_building_permit_accessory_occupancytypeid` FOREIGN KEY (`occupancytypeid`) REFERENCES `obo_occupancy_type` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_building_permit_ancillary
-- ----------------------------
DROP TABLE IF EXISTS `online_building_permit_ancillary`;
CREATE TABLE `online_building_permit_ancillary` (
  `objid` varchar(50) NOT NULL,
  `appid` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `permittypeid` varchar(255) DEFAULT NULL,
  `designprofessionalid` varchar(50) DEFAULT NULL,
  `supervisorid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_online_building_application_ancillary_appid_permit_type` (`appid`,`permittypeid`),
  KEY `fk_online_building_application_ancillary_permittypeid` (`permittypeid`),
  KEY `fk_online_building_application_ancillary_professionalid` (`designprofessionalid`),
  KEY `fk_online_building_application_ancillary_supervisorid` (`supervisorid`),
  CONSTRAINT `fk_online_building_application_ancillary_appid` FOREIGN KEY (`appid`) REFERENCES `online_building_permit` (`objid`),
  CONSTRAINT `fk_online_building_application_ancillary_permittypeid` FOREIGN KEY (`permittypeid`) REFERENCES `obo_permit_type` (`objid`),
  CONSTRAINT `fk_online_building_application_ancillary_professionalid` FOREIGN KEY (`designprofessionalid`) REFERENCES `online_building_permit_professional` (`objid`),
  CONSTRAINT `fk_online_building_application_ancillary_supervisorid` FOREIGN KEY (`supervisorid`) REFERENCES `online_building_permit_professional` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_building_permit_entity
-- ----------------------------
DROP TABLE IF EXISTS `online_building_permit_entity`;
CREATE TABLE `online_building_permit_entity` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `appid` varchar(50) DEFAULT NULL,
  `profileid` varchar(50) DEFAULT NULL,
  `entitytype` varchar(50) DEFAULT NULL,
  `profileno` varchar(50) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `middlename` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `resident` int(255) DEFAULT NULL,
  `address_objid` varchar(50) DEFAULT NULL,
  `address_text` varchar(255) DEFAULT NULL,
  `address_unitno` varchar(50) DEFAULT NULL,
  `address_bldgno` varchar(50) DEFAULT NULL,
  `address_bldgname` varchar(100) DEFAULT NULL,
  `address_street` varchar(255) DEFAULT NULL,
  `address_subdivision` varchar(255) DEFAULT NULL,
  `address_barangay_objid` varchar(50) DEFAULT NULL,
  `address_barangay_name` varchar(50) DEFAULT NULL,
  `address_citymunicipality` varchar(50) DEFAULT NULL,
  `address_province` varchar(50) DEFAULT NULL,
  `tin` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobileno` varchar(50) DEFAULT NULL,
  `phoneno` varchar(50) DEFAULT NULL,
  `id` mediumtext,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fx_building_application_entity_appid_role` (`appid`) USING BTREE,
  CONSTRAINT `fk_online_bldg_app_appid` FOREIGN KEY (`appid`) REFERENCES `online_building_permit` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_building_permit_info
-- ----------------------------
DROP TABLE IF EXISTS `online_building_permit_info`;
CREATE TABLE `online_building_permit_info` (
  `objid` varchar(50) NOT NULL,
  `appid` varchar(50) DEFAULT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `stringvalue` varchar(255) DEFAULT NULL,
  `decimalvalue` decimal(18,2) DEFAULT NULL,
  `intvalue` int(11) DEFAULT NULL,
  `datevalue` date DEFAULT NULL,
  `booleanvalue` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_parentid_varname` (`parentid`,`name`),
  KEY `ix_varname` (`name`) USING BTREE,
  KEY `ix_parentid` (`parentid`),
  KEY `fk_building_permit_info_appid` (`appid`),
  CONSTRAINT `fk_building_permit_info_appid` FOREIGN KEY (`appid`) REFERENCES `online_building_permit` (`objid`),
  CONSTRAINT `fk_building_permit_info_name` FOREIGN KEY (`name`) REFERENCES `obo_variable` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_building_permit_professional
-- ----------------------------
DROP TABLE IF EXISTS `online_building_permit_professional`;
CREATE TABLE `online_building_permit_professional` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `appid` varchar(50) DEFAULT NULL,
  `entityid` varchar(50) DEFAULT NULL,
  `profession` varchar(255) DEFAULT NULL,
  `ptr` mediumtext,
  `prc` mediumtext,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fx_building_application_entity_appid_role` (`appid`) USING BTREE,
  KEY `online_building_permit_professional_entityid` (`entityid`),
  CONSTRAINT `online_building_permit_professional_appid` FOREIGN KEY (`appid`) REFERENCES `online_building_permit` (`objid`),
  CONSTRAINT `online_building_permit_professional_entityid` FOREIGN KEY (`entityid`) REFERENCES `online_building_permit_entity` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_building_permit_requirement
-- ----------------------------
DROP TABLE IF EXISTS `online_building_permit_requirement`;
CREATE TABLE `online_building_permit_requirement` (
  `objid` varchar(50) NOT NULL,
  `appid` varchar(50) DEFAULT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `typeid` varchar(50) DEFAULT NULL,
  `status` int(10) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_req_appid` (`appid`) USING BTREE,
  KEY `fk_req_typeid` (`typeid`) USING BTREE,
  KEY `fk_building_permit_requirement_parentid` (`parentid`),
  CONSTRAINT `fk_building_permit_requirement_appid` FOREIGN KEY (`appid`) REFERENCES `online_building_permit` (`objid`),
  CONSTRAINT `fk_building_permit_requirement_parentid` FOREIGN KEY (`parentid`) REFERENCES `online_building_permit_ancillary` (`objid`),
  CONSTRAINT `fk_building_permit_requirement_typeid` FOREIGN KEY (`typeid`) REFERENCES `obo_requirement_type` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_building_permit_rpu
-- ----------------------------
DROP TABLE IF EXISTS `online_building_permit_rpu`;
CREATE TABLE `online_building_permit_rpu` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `appid` varchar(50) DEFAULT NULL,
  `tdno` varchar(50) DEFAULT NULL,
  `tctno` varchar(50) DEFAULT NULL,
  `pin` varchar(50) DEFAULT NULL,
  `barangay` varchar(50) DEFAULT NULL,
  `titleno` varchar(50) DEFAULT NULL,
  `lotno` varchar(50) DEFAULT NULL,
  `blockno` varchar(50) DEFAULT NULL,
  `areasqm` decimal(16,4) DEFAULT NULL,
  `classcode` varchar(255) DEFAULT NULL,
  `ownerid` varchar(50) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `lotowned` int(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_building_application_appid_refid` (`appid`,`refid`),
  CONSTRAINT `fk_online_building_permit_rpu_appid` FOREIGN KEY (`appid`) REFERENCES `online_building_permit` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_occupancy_permit
-- ----------------------------
DROP TABLE IF EXISTS `online_occupancy_permit`;
CREATE TABLE `online_occupancy_permit` (
  `objid` varchar(50) NOT NULL,
  `orgcode` varchar(50) DEFAULT NULL,
  `apptype` varchar(50) DEFAULT NULL,
  `permittype` varchar(50) DEFAULT NULL,
  `contact_name` varchar(50) DEFAULT NULL,
  `contact_detail` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_mobileno` varchar(50) DEFAULT NULL,
  `dtfiled` varchar(200) DEFAULT NULL,
  `locationid` varchar(50) DEFAULT NULL,
  `applicantid` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `occupancytypeid` varchar(50) DEFAULT NULL,
  `numunits` smallint(3) DEFAULT NULL,
  `floorarea` decimal(8,2) DEFAULT NULL,
  `projectcost` decimal(16,2) DEFAULT NULL,
  `dtproposedconstruction` date DEFAULT NULL,
  `dtexpectedcompletion` date DEFAULT NULL,
  `supervisorid` varchar(50) DEFAULT NULL,
  `totalfloorarea` decimal(16,2) DEFAULT NULL,
  `height` decimal(16,2) DEFAULT NULL,
  `numfloors` smallint(255) DEFAULT NULL,
  `step` int(50) DEFAULT NULL,
  `worktypes` tinytext,
  `contractorid` varchar(50) DEFAULT NULL,
  `bldgpermit_objid` varchar(50) DEFAULT NULL,
  `bldgpermit_controlno` varchar(50) DEFAULT NULL,
  `bldgpermit_dtissued` date DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_app_occupancyuseid` (`occupancytypeid`) USING BTREE,
  KEY `ix_units` (`numunits`) USING BTREE,
  KEY `ix_floorarea` (`floorarea`) USING BTREE,
  KEY `ix_estimatedcost` (`projectcost`) USING BTREE,
  KEY `ix_dtproposedconstruction` (`dtproposedconstruction`) USING BTREE,
  KEY `ix_dtexpectedcompletion` (`dtexpectedcompletion`) USING BTREE,
  KEY `ix_supervisorid` (`supervisorid`) USING BTREE,
  KEY `online_building_application_locationid` (`locationid`),
  KEY `online_building_application_applicantid` (`applicantid`),
  KEY `online_building_application_constructioninchargeid` (`contractorid`),
  CONSTRAINT `online_occupancy_permit_applicantid` FOREIGN KEY (`applicantid`) REFERENCES `online_occupancy_permit_entity` (`objid`),
  CONSTRAINT `online_occupancy_permit_locationid` FOREIGN KEY (`locationid`) REFERENCES `online_occupancy_permit_rpu` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_occupancy_permit_costitem
-- ----------------------------
DROP TABLE IF EXISTS `online_occupancy_permit_costitem`;
CREATE TABLE `online_occupancy_permit_costitem` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `appid` varchar(50) DEFAULT NULL,
  `itemid` varchar(50) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `online_occupancy_permit_costitem_itemid` (`itemid`),
  KEY `uix_building_application_appid_refid` (`appid`) USING BTREE,
  CONSTRAINT `online_occupancy_permit_costitem_appid` FOREIGN KEY (`appid`) REFERENCES `online_occupancy_permit` (`objid`),
  CONSTRAINT `online_occupancy_permit_costitem_itemid` FOREIGN KEY (`itemid`) REFERENCES `obo_costitem` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_occupancy_permit_entity
-- ----------------------------
DROP TABLE IF EXISTS `online_occupancy_permit_entity`;
CREATE TABLE `online_occupancy_permit_entity` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `appid` varchar(50) DEFAULT NULL,
  `profileid` varchar(50) DEFAULT NULL,
  `entitytype` varchar(50) DEFAULT NULL,
  `profileno` varchar(50) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `middlename` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `resident` int(255) DEFAULT NULL,
  `address_objid` varchar(50) DEFAULT NULL,
  `address_text` varchar(255) DEFAULT NULL,
  `address_unitno` varchar(50) DEFAULT NULL,
  `address_bldgno` varchar(50) DEFAULT NULL,
  `address_bldgname` varchar(100) DEFAULT NULL,
  `address_street` varchar(255) DEFAULT NULL,
  `address_subdivision` varchar(255) DEFAULT NULL,
  `address_barangay_objid` varchar(50) DEFAULT NULL,
  `address_barangay_name` varchar(50) DEFAULT NULL,
  `address_citymunicipality` varchar(50) DEFAULT NULL,
  `address_province` varchar(50) DEFAULT NULL,
  `tin` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobileno` varchar(50) DEFAULT NULL,
  `phoneno` varchar(50) DEFAULT NULL,
  `id` mediumtext,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fx_building_application_entity_appid_role` (`appid`) USING BTREE,
  CONSTRAINT `online_occupancy_permit_appid` FOREIGN KEY (`appid`) REFERENCES `online_occupancy_permit` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_occupancy_permit_professional
-- ----------------------------
DROP TABLE IF EXISTS `online_occupancy_permit_professional`;
CREATE TABLE `online_occupancy_permit_professional` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `appid` varchar(50) DEFAULT NULL,
  `entityid` varchar(50) DEFAULT NULL,
  `profession` varchar(255) DEFAULT NULL,
  `ptr` mediumtext,
  `prc` mediumtext,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fx_building_application_entity_appid_role` (`appid`) USING BTREE,
  KEY `online_building_permit_professional_entityid` (`entityid`),
  CONSTRAINT `online_occupancy_permit_professional_appid` FOREIGN KEY (`appid`) REFERENCES `online_occupancy_permit` (`objid`),
  CONSTRAINT `online_occupancy_permit_professional_entityid` FOREIGN KEY (`entityid`) REFERENCES `online_occupancy_permit_entity` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for online_occupancy_permit_rpu
-- ----------------------------
DROP TABLE IF EXISTS `online_occupancy_permit_rpu`;
CREATE TABLE `online_occupancy_permit_rpu` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `appid` varchar(50) DEFAULT NULL,
  `tdno` varchar(50) DEFAULT NULL,
  `tctno` varchar(50) DEFAULT NULL,
  `pin` varchar(50) DEFAULT NULL,
  `barangay` varchar(50) DEFAULT NULL,
  `titleno` varchar(50) DEFAULT NULL,
  `lotno` varchar(50) DEFAULT NULL,
  `blockno` varchar(50) DEFAULT NULL,
  `areasqm` decimal(16,4) DEFAULT NULL,
  `classcode` varchar(255) DEFAULT NULL,
  `ownerid` varchar(50) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `bill_amtdue` decimal(16,2) DEFAULT NULL,
  `lotowned` int(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_building_application_appid_refid` (`appid`,`refid`),
  CONSTRAINT `fk_online_occupancy_permit_rpu_appid` FOREIGN KEY (`appid`) REFERENCES `online_occupancy_permit` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_rule
-- ----------------------------
DROP TABLE IF EXISTS `sys_rule`;
CREATE TABLE `sys_rule` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(25) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `ruleset` varchar(50) NOT NULL,
  `rulegroup` varchar(50) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `description` longtext,
  `salience` int(11) DEFAULT NULL,
  `effectivefrom` date DEFAULT NULL,
  `effectiveto` date DEFAULT NULL,
  `dtfiled` datetime DEFAULT NULL,
  `user_objid` varchar(50) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `noloop` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `rulegroup` (`rulegroup`,`ruleset`) USING BTREE,
  KEY `ruleset` (`ruleset`) USING BTREE,
  CONSTRAINT `sys_rule_ibfk_1` FOREIGN KEY (`rulegroup`, `ruleset`) REFERENCES `sys_rulegroup` (`name`, `ruleset`),
  CONSTRAINT `sys_rule_ibfk_2` FOREIGN KEY (`ruleset`) REFERENCES `sys_ruleset` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_rule_action
-- ----------------------------
DROP TABLE IF EXISTS `sys_rule_action`;
CREATE TABLE `sys_rule_action` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `actiondef_objid` varchar(50) DEFAULT NULL,
  `actiondef_name` varchar(50) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  KEY `sys_rule_action_actiondef` (`actiondef_objid`) USING BTREE,
  CONSTRAINT `sys_rule_action_actiondef` FOREIGN KEY (`actiondef_objid`) REFERENCES `sys_rule_actiondef` (`objid`),
  CONSTRAINT `sys_rule_action_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_rule` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_rule_action_param
-- ----------------------------
DROP TABLE IF EXISTS `sys_rule_action_param`;
CREATE TABLE `sys_rule_action_param` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `actiondefparam_objid` varchar(100) DEFAULT NULL,
  `stringvalue` varchar(255) DEFAULT NULL,
  `booleanvalue` int(11) DEFAULT NULL,
  `var_objid` varchar(50) DEFAULT NULL,
  `var_name` varchar(50) DEFAULT NULL,
  `expr` longtext,
  `exprtype` varchar(25) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `obj_key` varchar(50) DEFAULT NULL,
  `obj_value` varchar(255) DEFAULT NULL,
  `listvalue` longtext,
  `lov` varchar(50) DEFAULT NULL,
  `rangeoption` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  KEY `var_objid` (`var_objid`) USING BTREE,
  KEY `sys_rule_action_param_actiondefparam` (`actiondefparam_objid`) USING BTREE,
  CONSTRAINT `sys_rule_action_param_actiondefparam` FOREIGN KEY (`actiondefparam_objid`) REFERENCES `sys_rule_actiondef_param` (`objid`),
  CONSTRAINT `sys_rule_action_param_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_action` (`objid`),
  CONSTRAINT `sys_rule_action_param_ibfk_2` FOREIGN KEY (`var_objid`) REFERENCES `sys_rule_condition_var` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_rule_actiondef
-- ----------------------------
DROP TABLE IF EXISTS `sys_rule_actiondef`;
CREATE TABLE `sys_rule_actiondef` (
  `objid` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(250) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `actionname` varchar(50) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `actionclass` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_rule_actiondef_param
-- ----------------------------
DROP TABLE IF EXISTS `sys_rule_actiondef_param`;
CREATE TABLE `sys_rule_actiondef_param` (
  `objid` varchar(100) NOT NULL DEFAULT '',
  `parentid` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `datatype` varchar(50) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  `lookuphandler` varchar(50) DEFAULT NULL,
  `lookupkey` varchar(50) DEFAULT NULL,
  `lookupvalue` varchar(50) DEFAULT NULL,
  `vardatatype` varchar(50) DEFAULT NULL,
  `lovname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  CONSTRAINT `sys_rule_actiondef_param_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_actiondef` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_rule_condition
-- ----------------------------
DROP TABLE IF EXISTS `sys_rule_condition`;
CREATE TABLE `sys_rule_condition` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `fact_name` varchar(50) DEFAULT NULL,
  `fact_objid` varchar(50) DEFAULT NULL,
  `varname` varchar(50) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `ruletext` longtext,
  `displaytext` longtext,
  `dynamic_datatype` varchar(50) DEFAULT NULL,
  `dynamic_key` varchar(50) DEFAULT NULL,
  `dynamic_value` varchar(50) DEFAULT NULL,
  `notexist` int(11) NOT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fact_objid` (`fact_objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  CONSTRAINT `sys_rule_condition_fact` FOREIGN KEY (`fact_objid`) REFERENCES `sys_rule_fact` (`objid`),
  CONSTRAINT `sys_rule_condition_ibfk_1` FOREIGN KEY (`fact_objid`) REFERENCES `sys_rule_fact` (`objid`),
  CONSTRAINT `sys_rule_condition_ibfk_2` FOREIGN KEY (`parentid`) REFERENCES `sys_rule` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_rule_condition_constraint
-- ----------------------------
DROP TABLE IF EXISTS `sys_rule_condition_constraint`;
CREATE TABLE `sys_rule_condition_constraint` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `field_objid` varchar(100) DEFAULT NULL,
  `fieldname` varchar(50) DEFAULT NULL,
  `varname` varchar(50) DEFAULT NULL,
  `operator_caption` varchar(50) DEFAULT NULL,
  `operator_symbol` varchar(50) DEFAULT NULL,
  `usevar` int(11) DEFAULT NULL,
  `var_objid` varchar(50) DEFAULT NULL,
  `var_name` varchar(50) DEFAULT NULL,
  `decimalvalue` decimal(16,2) DEFAULT NULL,
  `intvalue` int(11) DEFAULT NULL,
  `stringvalue` varchar(255) DEFAULT NULL,
  `listvalue` longtext,
  `datevalue` date DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  KEY `var_objid` (`var_objid`) USING BTREE,
  KEY `sys_rule_condition_constraint_fact_field` (`field_objid`) USING BTREE,
  CONSTRAINT `sys_rule_condition_constraint_fact_field` FOREIGN KEY (`field_objid`) REFERENCES `sys_rule_fact_field` (`objid`),
  CONSTRAINT `sys_rule_condition_constraint_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_condition` (`objid`),
  CONSTRAINT `sys_rule_condition_constraint_ibfk_2` FOREIGN KEY (`var_objid`) REFERENCES `sys_rule_condition_var` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_rule_condition_var
-- ----------------------------
DROP TABLE IF EXISTS `sys_rule_condition_var`;
CREATE TABLE `sys_rule_condition_var` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `ruleid` varchar(50) DEFAULT NULL,
  `varname` varchar(50) DEFAULT NULL,
  `datatype` varchar(50) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  CONSTRAINT `sys_rule_condition_var_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_condition` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_rule_deployed
-- ----------------------------
DROP TABLE IF EXISTS `sys_rule_deployed`;
CREATE TABLE `sys_rule_deployed` (
  `objid` varchar(50) NOT NULL,
  `ruletext` longtext,
  PRIMARY KEY (`objid`) USING BTREE,
  CONSTRAINT `sys_rule_deployed_ibfk_1` FOREIGN KEY (`objid`) REFERENCES `sys_rule` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_rule_fact
-- ----------------------------
DROP TABLE IF EXISTS `sys_rule_fact`;
CREATE TABLE `sys_rule_fact` (
  `objid` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `factclass` varchar(50) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  `defaultvarname` varchar(25) DEFAULT NULL,
  `dynamic` int(11) DEFAULT NULL,
  `lookuphandler` varchar(50) DEFAULT NULL,
  `lookupkey` varchar(50) DEFAULT NULL,
  `lookupvalue` varchar(50) DEFAULT NULL,
  `lookupdatatype` varchar(50) DEFAULT NULL,
  `dynamicfieldname` varchar(50) DEFAULT NULL,
  `builtinconstraints` varchar(50) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `factsuperclass` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_rule_fact_field
-- ----------------------------
DROP TABLE IF EXISTS `sys_rule_fact_field`;
CREATE TABLE `sys_rule_fact_field` (
  `objid` varchar(100) NOT NULL DEFAULT '',
  `parentid` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `datatype` varchar(50) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  `lookuphandler` varchar(50) DEFAULT NULL,
  `lookupkey` varchar(50) DEFAULT NULL,
  `lookupvalue` varchar(50) DEFAULT NULL,
  `lookupdatatype` varchar(50) DEFAULT NULL,
  `multivalued` int(11) DEFAULT NULL,
  `required` int(11) DEFAULT NULL,
  `vardatatype` varchar(50) DEFAULT NULL,
  `lovname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  CONSTRAINT `sys_rule_fact_field_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_fact` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_rulegroup
-- ----------------------------
DROP TABLE IF EXISTS `sys_rulegroup`;
CREATE TABLE `sys_rulegroup` (
  `name` varchar(50) NOT NULL,
  `ruleset` varchar(50) NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`,`ruleset`) USING BTREE,
  KEY `ruleset` (`ruleset`) USING BTREE,
  CONSTRAINT `sys_rulegroup_ibfk_1` FOREIGN KEY (`ruleset`) REFERENCES `sys_ruleset` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_ruleset
-- ----------------------------
DROP TABLE IF EXISTS `sys_ruleset`;
CREATE TABLE `sys_ruleset` (
  `name` varchar(50) NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `packagename` varchar(50) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `permission` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_ruleset_actiondef
-- ----------------------------
DROP TABLE IF EXISTS `sys_ruleset_actiondef`;
CREATE TABLE `sys_ruleset_actiondef` (
  `ruleset` varchar(50) NOT NULL,
  `actiondef` varchar(50) NOT NULL,
  PRIMARY KEY (`ruleset`,`actiondef`) USING BTREE,
  KEY `actiondef` (`actiondef`) USING BTREE,
  CONSTRAINT `fk_sys_ruleset_actiondef_actiondef` FOREIGN KEY (`actiondef`) REFERENCES `sys_rule_actiondef` (`objid`),
  CONSTRAINT `sys_ruleset_actiondef_ibfk_2` FOREIGN KEY (`ruleset`) REFERENCES `sys_ruleset` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_ruleset_fact
-- ----------------------------
DROP TABLE IF EXISTS `sys_ruleset_fact`;
CREATE TABLE `sys_ruleset_fact` (
  `ruleset` varchar(50) NOT NULL,
  `rulefact` varchar(50) NOT NULL,
  PRIMARY KEY (`ruleset`,`rulefact`) USING BTREE,
  KEY `rulefact` (`rulefact`) USING BTREE,
  CONSTRAINT `fk_sys_ruleset_fact_rulefact` FOREIGN KEY (`rulefact`) REFERENCES `sys_rule_fact` (`objid`),
  CONSTRAINT `sys_ruleset_fact_ibfk_2` FOREIGN KEY (`ruleset`) REFERENCES `sys_ruleset` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_wf
-- ----------------------------
DROP TABLE IF EXISTS `sys_wf`;
CREATE TABLE `sys_wf` (
  `name` varchar(50) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_wf_node
-- ----------------------------
DROP TABLE IF EXISTS `sys_wf_node`;
CREATE TABLE `sys_wf_node` (
  `name` varchar(50) NOT NULL,
  `processname` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(100) DEFAULT NULL,
  `nodetype` varchar(10) DEFAULT NULL,
  `idx` int(11) DEFAULT NULL,
  `salience` int(11) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `ui` text,
  `properties` text,
  `tracktime` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`,`processname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_wf_transition
-- ----------------------------
DROP TABLE IF EXISTS `sys_wf_transition`;
CREATE TABLE `sys_wf_transition` (
  `parentid` varchar(50) NOT NULL DEFAULT '',
  `processname` varchar(50) NOT NULL DEFAULT '',
  `action` varchar(50) NOT NULL,
  `to` varchar(50) NOT NULL,
  `idx` int(11) DEFAULT NULL,
  `eval` mediumtext,
  `properties` varchar(255) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `ui` text,
  PRIMARY KEY (`parentid`,`processname`,`to`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- View structure for vw_obo_occupancy_type
-- ----------------------------
DROP VIEW IF EXISTS `vw_obo_occupancy_type`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_obo_occupancy_type` AS select `ot`.`objid` AS `objid`,`ot`.`divisionid` AS `divisionid`,`ot`.`title` AS `title`,`od`.`objid` AS `division_objid`,`od`.`title` AS `division_title`,`og`.`objid` AS `group_objid`,`og`.`title` AS `group_title` from ((`obo_occupancy_type` `ot` join `obo_occupancy_type_division` `od` on((`ot`.`divisionid` = `od`.`objid`))) join `obo_occupancy_type_group` `og` on((`od`.`groupid` = `og`.`objid`)));

-- ----------------------------
-- View structure for vw_online_building_permit_professional
-- ----------------------------
DROP VIEW IF EXISTS `vw_online_building_permit_professional`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_online_building_permit_professional` AS select `a`.`objid` AS `objid`,`a`.`appid` AS `appid`,`a`.`entityid` AS `entityid`,`a`.`profession` AS `profession`,`a`.`ptr` AS `ptr`,`a`.`prc` AS `prc`,`e`.`name` AS `name`,`e`.`firstname` AS `firstname`,`e`.`lastname` AS `lastname`,`e`.`middlename` AS `middlename`,`e`.`address_text` AS `address_text`,`e`.`tin` AS `tin`,`e`.`id` AS `id` from (`online_building_permit_professional` `a` join `online_building_permit_entity` `e` on((`a`.`entityid` = `e`.`objid`)));

SET FOREIGN_KEY_CHECKS = 1;
