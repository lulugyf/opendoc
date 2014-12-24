-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.20 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             8.2.0.4675
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for function rom.nextval
DROP FUNCTION IF EXISTS `nextval`;
DELIMITER //
CREATE DEFINER=`rom`@`localhost` FUNCTION `nextval`(seq_name VARCHAR(50)) RETURNS bigint(20)
    MODIFIES SQL DATA
BEGIN
   declare val bigint;
   UPDATE rom_sequence  SET  current_value = current_value + increment  
   WHERE name = seq_name;  
   if ROW_COUNT() < 1 then
	insert into rom_sequence values(seq_name, 1, 1);
	return 1;
   else
     select current_value into val from rom_sequence where name=seq_name;
     return val;
   end if;
END//
DELIMITER ;


-- Dumping structure for table rom.rom_login_role_relation
DROP TABLE IF EXISTS `rom_login_role_relation`;
CREATE TABLE IF NOT EXISTS `rom_login_role_relation` (
  `login_no` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int(11) NOT NULL,
  `remarks` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`login_no`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.rom_login_role_relation: ~2 rows (approximately)
/*!40000 ALTER TABLE `rom_login_role_relation` DISABLE KEYS */;
INSERT INTO `rom_login_role_relation` (`login_no`, `role_id`, `remarks`) VALUES
	('abc', 5, '设置工号角色关系'),
	('admin', 1, '超级管理员');
/*!40000 ALTER TABLE `rom_login_role_relation` ENABLE KEYS */;


-- Dumping structure for table rom.rom_opera_code
DROP TABLE IF EXISTS `rom_opera_code`;
CREATE TABLE IF NOT EXISTS `rom_opera_code` (
  `opera_code` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `opera_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`opera_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.rom_opera_code: ~7 rows (approximately)
/*!40000 ALTER TABLE `rom_opera_code` DISABLE KEYS */;
INSERT INTO `rom_opera_code` (`opera_code`, `opera_name`, `remarks`) VALUES
	('1', '新增', NULL),
	('2', '修改', NULL),
	('3', '删除', NULL),
	('4', '赋权', NULL),
	('5', '启动或停止', NULL),
	('6', '文件上传下载', NULL),
	('7', '远程脚本调用配置', NULL);
/*!40000 ALTER TABLE `rom_opera_code` ENABLE KEYS */;


-- Dumping structure for table rom.rom_province_code
DROP TABLE IF EXISTS `rom_province_code`;
CREATE TABLE IF NOT EXISTS `rom_province_code` (
  `province_code` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `province_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`province_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.rom_province_code: ~2 rows (approximately)
/*!40000 ALTER TABLE `rom_province_code` DISABLE KEYS */;
INSERT INTO `rom_province_code` (`province_code`, `province_name`, `remarks`) VALUES
	('010', '内蒙古', NULL),
	('011', '北京', NULL);
/*!40000 ALTER TABLE `rom_province_code` ENABLE KEYS */;


-- Dumping structure for table rom.rom_pro_code
DROP TABLE IF EXISTS `rom_pro_code`;
CREATE TABLE IF NOT EXISTS `rom_pro_code` (
  `pro_code` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pro_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pro_version` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pro_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.rom_pro_code: ~1 rows (approximately)
/*!40000 ALTER TABLE `rom_pro_code` DISABLE KEYS */;
INSERT INTO `rom_pro_code` (`pro_code`, `pro_name`, `pro_version`, `remarks`) VALUES
	('P001', '报表', '0', '报表11111'),
	('SYSTEM', '后台管理功能', NULL, '系统初始化功能，不可删除');
/*!40000 ALTER TABLE `rom_pro_code` ENABLE KEYS */;


-- Dumping structure for table rom.rom_sequence
DROP TABLE IF EXISTS `rom_sequence`;
CREATE TABLE IF NOT EXISTS `rom_sequence` (
  `name` varchar(50) NOT NULL,
  `current_value` bigint(20) NOT NULL,
  `increment` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rom.rom_sequence: ~9 rows (approximately)
/*!40000 ALTER TABLE `rom_sequence` DISABLE KEYS */;
INSERT INTO `rom_sequence` (`name`, `current_value`, `increment`) VALUES
	('paramdata', 39, 1),
	('paramtype', 16, 1),
	('rptdoc', 10, 1),
	('rptgroup', 14, 1),
	('SEQ_COMMON', 1, 1),
	('SEQ_EXPAND', 1, 1),
	('SEQ_HOSTCHECK', 1, 1),
	('t_doc', 17, 1),
	('users', 7, 1);
/*!40000 ALTER TABLE `rom_sequence` ENABLE KEYS */;


-- Dumping structure for table rom.rom_sys_function
DROP TABLE IF EXISTS `rom_sys_function`;
CREATE TABLE IF NOT EXISTS `rom_sys_function` (
  `function_code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `function_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_name` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `node_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_code` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operation_code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note_seq` int(11) DEFAULT '0',
  `open_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`function_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.rom_sys_function: ~34 rows (approximately)
/*!40000 ALTER TABLE `rom_sys_function` DISABLE KEYS */;
INSERT INTO `rom_sys_function` (`function_code`, `function_name`, `action_name`, `node_type`, `parent_code`, `operation_code`, `remarks`, `note_seq`, `open_type`) VALUES
	('2200', '报表系统', '', '0', '0', '1;2;3;4;', NULL, NULL, '1'),
	('2201', '数据同步任务', '', '0', '2200', '1;2;3;4;', NULL, NULL, '1'),
	('2202', '任务配置', '../taskmain.do', '0', '2201', '1;2;3;', NULL, NULL, '1'),
	('2203', '任务监控', '../taskmon.do', '0', '2201', '1;2;3;4;', NULL, NULL, '1'),
	('2204', '任务结果查看', '../taskresult.do', '0', '2201', '1;2;3;4;', NULL, NULL, '1'),
	('2205', '数据连接配置', '../dbconnsMain.do', '0', '2201', '1;2;3;', NULL, NULL, '1'),
	('BUSCFG', '节点配置', '../busConfigMain.do', '1', 'BUSMAIN', '1;2;3;', NULL, 1, '1'),
	('BUSCRIPT', '远程脚本配置', '../busScriptMain.do', '1', 'BUSMAIN', '1;2;3;', NULL, 2, '1'),
	('BUSMAIN', 'bus总线', '../busMain.do?node=BUSCFG&script=BUSCRIPT&run=BUSRUN', '0', 'NODEMNG', NULL, NULL, 0, '1'),
	('CMDCFG1', '网元指令配置', '../gotoInstructionConfig.do', '0', 'NETCELL', NULL, NULL, NULL, '1'),
	('DOC0007', '华北区收入', '../rptdoc_main.do', '0', 'DOCG0007', '1;', 'add report doc', NULL, '1'),
	('DOC0009', '测试报表', '../rptdoc_main.do', '0', 'DOCG0006', '1;', 'add report doc', NULL, '1'),
	('DOC0010', '2222', '../rptdoc_main.do', '0', 'DOCG0007', '1;', 'add report doc', NULL, '1'),
	('DOCG0006', 'helhe 123', NULL, '0', 'RPTROOT', '1;', 'remarks', NULL, '1'),
	('DOCG0007', '收入报表', NULL, '0', 'RPTROOT', '1;', 'add report group', NULL, '1'),
	('DOCG0008', '支出报表', NULL, '0', 'RPTROOT', '1;', 'add report group', NULL, '1'),
	('DOCG0014', '过滤条件', NULL, '0', 'RPTROOT', '1;', 'add report group', NULL, '1'),
	('NETCELL', '网元管理', NULL, '0', '0', NULL, NULL, NULL, '1'),
	('NODEMNG', '节点管理', NULL, '0', '0', NULL, NULL, 9, '1'),
	('PARAMCFG', '报表参数配置', '../paramcfg_main.do', '0', 'RPTCFG', '1;2;3;', NULL, NULL, '1'),
	('PARAMUSR', '参数与用户关联', '../paramusr_main.do', '0', 'RPTCFG', '1;2;', NULL, NULL, '1'),
	('RPTCFG', '报表配置', '', '0', '2200', '', NULL, NULL, '1'),
	('RPTCONF', '报表配置', '../rptconf_main.do', '0', 'RPTCFG', '1;2;3;4;', NULL, NULL, '1'),
	('RPTROOT', '报表文档', '', '0', '2200', '', NULL, NULL, '1'),
	('SYS01', '系统管理', NULL, '0', '0', NULL, NULL, 0, '1'),
	('SYS02', '角色管理', '../role.do', '0', 'SYS01', '1;2;3;4;', NULL, 0, '1'),
	('SYS03', '工号管理', '../loginMain.do', '0', 'SYS01', '1;2;3;', NULL, 0, '1'),
	('SYS04', '工号密码管理', '../passMain.do', '0', 'SYS01', '2', NULL, 0, '1'),
	('SYS11', '工号密码修改', '../gotoUpdatePass.do', '1', 'SYS01', NULL, NULL, 0, '1'),
	('SYS12', '产品管理', '../product.do', '0', 'SYS01', '1;2;3', NULL, 0, '1'),
	('SYS13', '功能树管理', '../function.do', '0', 'SYS01', '1;2;3', NULL, 0, '1'),
	('SYS14', '功能权限注册', '../popereg.do', '0', 'SYS01', '1;2;3;', NULL, 0, '1'),
	('SYSLOG', '日志管理', NULL, '0', '0', NULL, NULL, 0, '1'),
	('SYSLOG1', '工号日志', '../logMain.do', '0', 'SYSLOG', NULL, NULL, 0, '1');
/*!40000 ALTER TABLE `rom_sys_function` ENABLE KEYS */;


-- Dumping structure for table rom.rom_sys_login
DROP TABLE IF EXISTS `rom_sys_login`;
CREATE TABLE IF NOT EXISTS `rom_sys_login` (
  `login_no` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `login_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login_pwd` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `use_flg` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expire_time` date DEFAULT NULL,
  `login_flg` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_no` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login_ip` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province_code` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`login_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.rom_sys_login: ~2 rows (approximately)
/*!40000 ALTER TABLE `rom_sys_login` DISABLE KEYS */;
INSERT INTO `rom_sys_login` (`login_no`, `login_name`, `login_pwd`, `use_flg`, `expire_time`, `login_flg`, `phone_no`, `login_ip`, `remark`, `province_code`) VALUES
	('abc', '中文abc', '79fe00adb01e2791420db84c678197fa', '0', NULL, NULL, '13500000000', NULL, NULL, '010'),
	('admin', '超级管理员', '79fe00adb01e2791420db84c678197fa', '0', NULL, NULL, NULL, NULL, NULL, '00');
/*!40000 ALTER TABLE `rom_sys_login` ENABLE KEYS */;


-- Dumping structure for table rom.rom_sys_op_log
DROP TABLE IF EXISTS `rom_sys_op_log`;
CREATE TABLE IF NOT EXISTS `rom_sys_op_log` (
  `op_date` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `op_staff` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `staff_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pro_code` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `function_code` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `op_time` date DEFAULT NULL,
  `op_content` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  KEY `PK_OP_DATE_OP_LOG` (`op_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.rom_sys_op_log: ~48 rows (approximately)
/*!40000 ALTER TABLE `rom_sys_op_log` DISABLE KEYS */;
INSERT INTO `rom_sys_op_log` (`op_date`, `op_staff`, `staff_name`, `pro_code`, `function_code`, `op_time`, `op_content`, `remarks`) VALUES
	('20141108', 'admin', '?????', 'SYSTEM', 'SYS12', '2014-11-08', '?????????=??1???=1.0', ''),
	('20141108', 'admin', '?????', 'SYSTEM', 'SYS12', '2014-11-08', '?????????=undefined???=undefined', ''),
	('20141108', 'admin', '?????', 'SYSTEM', 'SYS12', '2014-11-08', '?????????=??1???=1.0', ''),
	('20141108', 'admin', '?????', 'SYSTEM', 'SYS12', '2014-11-08', '?????????=??1???=1', ''),
	('20141108', 'admin', '?????', 'SYSTEM', 'SYS12', '2014-11-08', '?????????=?????=1', ''),
	('20141108', 'admin', '?????', 'SYSTEM', 'SYS12', '2014-11-08', '?????????=undefined???=undefined', ''),
	('20141108', 'admin', '?????', 'SYSTEM', 'SYS12', '2014-11-08', '?????????=undefined???=undefined', ''),
	('20141108', 'admin', '?????', 'SYSTEM', 'SYS12', '2014-11-08', '?????????=?????=1', ''),
	('20141108', 'admin', '?????', 'SYSTEM', 'SYS12', '2014-11-08', '?????????=???????=1', ''),
	('20141108', 'admin', '?????', 'SYSTEM', 'SYS12', '2014-11-08', '?????????=??????=1', ''),
	('20141108', 'admin', '?????', 'SYSTEM', 'SYS12', '2014-11-08', '?????????=????=1', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-08', '新增产品：产品名称=fgsfgsf，版本=2', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-08', '新增产品：产品名称=反反复复方法，版本=3', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-08', '删除产品：产品名称=undefined，版本=undefined', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-08', '删除产品：产品名称=undefined，版本=undefined', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-08', '删除产品：产品名称=undefined，版本=undefined', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-08', '删除产品：产品名称=undefined，版本=undefined', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-08', '删除产品：产品名称=undefined，版本=undefined', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-08', '删除产品：产品名称=undefined，版本=undefined', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-08', '删除产品：产品名称=undefined，版本=undefined', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-08', '新增产品：产品名称=报表，版本=1', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-08', '修改产品：产品名称=报表，版本=1', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS02', '2014-11-08', '新增角色：角色名称=report1，产品名称=报表', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS03', '2014-11-08', '新增工号：工号=abc', ''),
	('20141108', 'admin', '超级管理员', 'SYSTEM', 'SYS03', '2014-11-08', '工号角色设置：工号=abc', ''),
	('20141111', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-11-11', '新增功能节点：功能代码=2200，功能名称=报表系统', ''),
	('20141111', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-11-11', '新增功能节点：功能代码=2201，功能名称=数据同步任务', ''),
	('20141111', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-11-11', '新增功能节点：功能代码=2202，功能名称=任务配置', ''),
	('20141111', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-11-11', '新增功能节点：功能代码=2203，功能名称=任务监控', ''),
	('20141111', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-11-11', '新增功能节点：功能代码=2204，功能名称=任务结果查看', ''),
	('20141111', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-11', '设置产品对应功能', ''),
	('20141111', 'admin', '超级管理员', 'SYSTEM', 'SYS02', '2014-11-11', '角色权限设置：角色名称=report1', ''),
	('20141111', 'admin', '超级管理员', 'SYSTEM', 'SYS03', '2014-11-11', '工号角色设置：工号=abc', ''),
	('20141111', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-11-11', '修改功能节点：功能代码=2202，功能名称=任务配置', ''),
	('20141111', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-11-11', '修改功能节点：功能代码=2203，功能名称=任务监控', ''),
	('20141111', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-11-11', '修改功能节点：功能代码=2204，功能名称=任务结果查看', ''),
	('20141114', 'admin', '超级管理员', 'SYSTEM', 'SYS14', '2014-11-14', '删除功能注册：功能链接=tasklist.do，所属功能=任务配置 2202', ''),
	('20141114', 'admin', '超级管理员', 'SYSTEM', 'SYS14', '2014-11-14', '新增功能注册：功能链接=tasklist.do，所属功能=任务配置 2202', ''),
	('20141114', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-11-14', '新增功能节点：功能代码=2205，功能名称=数据连接配置', ''),
	('20141114', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-14', '设置产品对应功能', ''),
	('20141114', 'admin', '超级管理员', 'SYSTEM', 'SYS02', '2014-11-14', '角色权限设置：角色名称=report1', ''),
	('20141114', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-11-14', '修改产品：产品名称=报表，原版本=1，修改后版本=0', ''),
	('20141204', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-12-04', '新增功能节点：功能代码=RPTCFG，功能名称=报表配置', ''),
	('20141204', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-12-04', '新增功能节点：功能代码=PARAMCFG，功能名称=报表参数配置', ''),
	('20141204', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-12-04', '修改功能节点：功能代码=PARAMCFG，功能名称=报表参数配置', ''),
	('20141204', 'admin', '超级管理员', 'SYSTEM', 'SYS14', '2014-12-04', '新增功能注册：功能链接=paramcfg_main.do，所属功能=报表参数配置 PARAMCFG', ''),
	('20141204', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-12-04', '设置产品对应功能', ''),
	('20141204', 'admin', '超级管理员', 'SYSTEM', 'SYS02', '2014-12-04', '角色权限设置：角色名称=report1', ''),
	('20141204', 'admin', '超级管理员', 'SYSTEM', 'SYS14', '2014-12-04', '修改功能注册：功能链接=paramcfg_main.do，所属功能=报表参数配置 PARAMCFG', ''),
	('20141206', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-12-06', '新增功能节点：功能代码=PARAMUSR，功能名称=参数与登录用户关联', ''),
	('20141206', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-12-06', '设置产品对应功能', ''),
	('20141206', 'admin', '超级管理员', 'SYSTEM', 'SYS02', '2014-12-06', '角色权限设置：角色名称=report1', ''),
	('20141206', 'admin', '超级管理员', 'SYSTEM', 'SYS02', '2014-12-06', '角色权限设置：角色名称=report1', ''),
	('20141206', 'admin', '超级管理员', 'SYSTEM', 'SYS02', '2014-12-06', '角色权限设置：角色名称=report1', ''),
	('20141208', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-12-08', '新增功能节点：功能代码=RPTCONF，功能名称=报表配置', ''),
	('20141210', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-12-10', '修改功能节点：功能代码=RPTCONF，功能名称=报表配置', ''),
	('20141210', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-12-10', '修改功能节点：功能代码=RPTCONF，功能名称=报表配置', ''),
	('20141210', 'admin', '超级管理员', 'SYSTEM', 'SYS13', '2014-12-10', '新增功能节点：功能代码=RPTROOT，功能名称=报表文档', ''),
	('20141210', 'admin', '超级管理员', 'SYSTEM', 'SYS12', '2014-12-10', '设置产品对应功能', ''),
	('20141210', 'admin', '超级管理员', 'SYSTEM', 'SYS02', '2014-12-10', '角色权限设置：角色名称=report1', '');
/*!40000 ALTER TABLE `rom_sys_op_log` ENABLE KEYS */;


-- Dumping structure for table rom.rom_sys_popedom
DROP TABLE IF EXISTS `rom_sys_popedom`;
CREATE TABLE IF NOT EXISTS `rom_sys_popedom` (
  `function_code` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation_code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  KEY `pk_ROM_SYS_POPEDOM` (`function_code`,`action_name`(191)),
  KEY `IDX_ROM_SYS_POPEDOM` (`function_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.rom_sys_popedom: ~75 rows (approximately)
/*!40000 ALTER TABLE `rom_sys_popedom` DISABLE KEYS */;
INSERT INTO `rom_sys_popedom` (`function_code`, `action_name`, `operation_code`) VALUES
	('SYS02', 'delRole.do', '3'),
	('SYS02', 'gotoSetPopedom.do', '4'),
	('SYS02', 'gotoAddRole.do', '1'),
	('SYS02', 'addRole.do', '1'),
	('SYS02', 'gotoUpdateRole.do', '2'),
	('SYS02', 'updateRole.do', '2'),
	('SYS02', 'setPopedom.do', '4'),
	('SYS02', 'role.do', NULL),
	('SYS03', 'loginMain.do', NULL),
	('SYS03', 'gotoAddLogin.do', '1'),
	('SYS03', 'setLoginRole.do', '2'),
	('SYS03', 'gotoSetLoginRole.do', '2'),
	('SYS03', 'addLogin.do', '1'),
	('SYS03', 'gotoUpdateLogin.do', '2'),
	('SYS03', 'delLogin.do', '3'),
	('SYS03', 'updateLogin.do', '2'),
	('SYS04', 'resetPassword.do', '2'),
	('SYS04', 'passMain.do', NULL),
	('SYS12', 'setProductFunction.do', '2'),
	('SYS12', 'gotoUpdateProduct.do', '2'),
	('SYS12', 'updateProduct.do', '1'),
	('SYS12', 'gotoUpdateProductFunc.do', '2'),
	('SYS12', 'delProduct.do', '1'),
	('SYS12', 'addProduct.do', '1'),
	('SYS12', 'gotoAddProduct.do', '1'),
	('SYS12', 'product.do', NULL),
	('SYS13', 'function.do', NULL),
	('SYS13', 'functionUpdate.do', '2'),
	('SYS13', 'gotoFuncUpdate.do', '2'),
	('SYS13', 'getFuncTree.do', NULL),
	('SYS13', 'functionAdd.do', '1'),
	('SYS13', 'gotoFuncAdd.do', '1'),
	('SYS13', 'getFuncDetail.do', NULL),
	('SYS13', 'functionDelete.do', '3'),
	('SYS14', 'gotoUpdatePopereg.do', '2'),
	('SYS14', 'updatePopereg.do', '2'),
	('SYS14', 'delPopereg.do', '3'),
	('SYS14', 'addPopereg.do', '1'),
	('SYS14', 'popereg.do', NULL),
	('SYS14', 'gotoAddPopereg.do', '1'),
	('SYS14', 'getFuncOpers.do', NULL),
	('SYSLOG1', 'logReportExport.do', NULL),
	('SYSLOG1', 'logMain.do', NULL),
	('SYSLOG1', 'getFunctionByProCode.do', NULL),
	('CMDCFG1', 'gotoInstructionConfig_browser.do', NULL),
	('CMDCFG1', 'gotoInstructionConfig.do', NULL),
	('SYS12', 'productList.do', NULL),
	('SYS02', 'roleList.do', NULL),
	('SYS03', 'loginList.do', NULL),
	('SYS14', 'poperegList.do', '1'),
	('2202', 'taskmain.do', '1'),
	('2202', 'tasklist.do', ''),
	('2205', 'dbconnsMain.do', '1'),
	('2205', 'dbconnsList.do', '1'),
	('2205', 'gotoAddDBConn.do', '1'),
	('2205', 'addDBConn.do', '1'),
	('2205', 'updateDBConn.do', '1'),
	('2205', 'delDBConn.do', '1'),
	('PARAMCFG', 'paramcfg_main.do', '1'),
	('PARAMCFG', 'addparamtype.do', '1'),
	('PARAMCFG', 'getparamdata.do', '1'),
	('PARAMCFG', 'addparamdata.do', '1'),
	('PARAMUSR', 'paramusr_main.do', '1'),
	('PARAMUSR', 'getparamusr.do', '1'),
	('PARAMUSR', 'getparamtree.do', '1'),
	('PARAMUSR', 'setparamuser.do', '1'),
	('RPTCONF', 'rptcfg_main.do', '1'),
	('RPTCONF', 'rptconf_main.do', '1'),
	('RPTCONF', 'getrpttree.do', '1'),
	('RPTCONF', 'addrptgroup.do', '1'),
	('RPTCONF', 'modrptgroup.do', '1'),
	('RPTCONF', 'delrptgroup.do', '1'),
	('RPTCONF', 'addrptdoc.do', '1'),
	('RPTCONF', 'modrptdoc.do', '1'),
	('RPTCONF', 'delrptdoc.do', '1'),
	('RPTCONF', 'adddocparam.do', '1'),
	('RPTCONF', 'moddocparam.do', '1'),
	('RPTCONF', 'deldocparam.do', '1'),
	('DOC0004', 'rptdoc_main.do', '1'),
	('DOC0007', 'rptdoc_main.do', '1'),
	('DOC0007', 'getparamtree.do', '1'),
	('RPTCONF', 'getrptparam.do', '1'),
	('DOC0009', 'rptdoc_main.do', '1'),
	('DOC0009', 'getparamtree.do', '1'),
	('DOC0010', 'rptdoc_main.do', '1'),
	('DOC0010', 'getparamtree.do', '1'),
	('RPTCONF', 'setparamuserex.do', '1'),
	('RPTCONF', 'getparamtree.do', '1');
/*!40000 ALTER TABLE `rom_sys_popedom` ENABLE KEYS */;


-- Dumping structure for table rom.rom_sys_pro_function
DROP TABLE IF EXISTS `rom_sys_pro_function`;
CREATE TABLE IF NOT EXISTS `rom_sys_pro_function` (
  `pro_code` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `function_code` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remarks` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pro_code`,`function_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.rom_sys_pro_function: ~28 rows (approximately)
/*!40000 ALTER TABLE `rom_sys_pro_function` DISABLE KEYS */;
INSERT INTO `rom_sys_pro_function` (`pro_code`, `function_code`, `remarks`) VALUES
	('P001', '2200', '设置产品功能'),
	('P001', '2201', '设置产品功能'),
	('P001', '2202', '设置产品功能'),
	('P001', '2203', '设置产品功能'),
	('P001', '2204', '设置产品功能'),
	('P001', '2205', '设置产品功能'),
	('P001', 'DOC0007', ' '),
	('P001', 'DOC0009', ' '),
	('P001', 'DOC0010', ' '),
	('P001', 'DOCG0006', ' '),
	('P001', 'DOCG0007', ' '),
	('P001', 'DOCG0008', ' '),
	('P001', 'DOCG0014', ' '),
	('P001', 'PARAMCFG', '设置产品功能'),
	('P001', 'PARAMUSR', '设置产品功能'),
	('P001', 'RPTCFG', '设置产品功能'),
	('P001', 'RPTCONF', '设置产品功能'),
	('P001', 'RPTROOT', '设置产品功能'),
	('SYSTEM', 'SYS01', '设置产品功能'),
	('SYSTEM', 'SYS02', '设置产品功能'),
	('SYSTEM', 'SYS03', '设置产品功能'),
	('SYSTEM', 'SYS04', '设置产品功能'),
	('SYSTEM', 'SYS12', '设置产品功能'),
	('SYSTEM', 'SYS13', '设置产品功能'),
	('SYSTEM', 'SYS14', '设置产品功能'),
	('SYSTEM', 'SYSLOG', '设置产品功能'),
	('SYSTEM', 'SYSLOG1', '设置产品功能');
/*!40000 ALTER TABLE `rom_sys_pro_function` ENABLE KEYS */;


-- Dumping structure for table rom.rom_sys_role
DROP TABLE IF EXISTS `rom_sys_role`;
CREATE TABLE IF NOT EXISTS `rom_sys_role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_state` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pro_code` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province_code` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tell_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.rom_sys_role: ~2 rows (approximately)
/*!40000 ALTER TABLE `rom_sys_role` DISABLE KEYS */;
INSERT INTO `rom_sys_role` (`role_id`, `role_name`, `role_type`, `role_state`, `pro_code`, `province_code`, `tell_type`, `remarks`) VALUES
	(1, '超级管理员,勿删', '0', '0', 'SYSTEM', NULL, NULL, '超级管理员'),
	(5, 'report1', '1', '0', 'P001', '010', '0', '新增角色');
/*!40000 ALTER TABLE `rom_sys_role` ENABLE KEYS */;


-- Dumping structure for table rom.rom_sys_role_function
DROP TABLE IF EXISTS `rom_sys_role_function`;
CREATE TABLE IF NOT EXISTS `rom_sys_role_function` (
  `role_id` int(11) NOT NULL,
  `function_code` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation_code` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`role_id`,`function_code`,`operation_code`),
  KEY `IDX_ROM_SYS_ROLE_FUNCTION` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.rom_sys_role_function: ~26 rows (approximately)
/*!40000 ALTER TABLE `rom_sys_role_function` DISABLE KEYS */;
INSERT INTO `rom_sys_role_function` (`role_id`, `function_code`, `operation_code`) VALUES
	(1, 'SYS01', 'NULL'),
	(1, 'SYS02', '1;2;3;4;'),
	(1, 'SYS03', '1;2;3;'),
	(1, 'SYS04', '2;'),
	(1, 'SYS12', '1;2;3;'),
	(1, 'SYS13', '1;2;3;'),
	(1, 'SYS14', '1;2;3;'),
	(1, 'SYSLOG', 'NULL'),
	(1, 'SYSLOG1', 'NULL'),
	(5, '2200', '1;2;3;4;'),
	(5, '2201', '1;2;3;4;'),
	(5, '2202', '1;2;3;'),
	(5, '2205', '1;2;3;'),
	(5, 'DOC0007', '1;'),
	(5, 'DOC0009', '1;'),
	(5, 'DOC0010', '1;'),
	(5, 'DOCG0006', '1;'),
	(5, 'DOCG0007', '1;'),
	(5, 'DOCG0008', '1;'),
	(5, 'DOCG0014', '1;'),
	(5, 'PARAMCFG', '1;2;3;'),
	(5, 'PARAMUSR', '1;2;'),
	(5, 'RPTCFG', 'NULL'),
	(5, 'RPTCONF', '1;2;3;'),
	(5, 'RPTROOT', 'NULL');
/*!40000 ALTER TABLE `rom_sys_role_function` ENABLE KEYS */;


-- Dumping structure for table rom.rom_tellcorp_code
DROP TABLE IF EXISTS `rom_tellcorp_code`;
CREATE TABLE IF NOT EXISTS `rom_tellcorp_code` (
  `tellcorp_code` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `tellcorp_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`tellcorp_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.rom_tellcorp_code: ~5 rows (approximately)
/*!40000 ALTER TABLE `rom_tellcorp_code` DISABLE KEYS */;
INSERT INTO `rom_tellcorp_code` (`tellcorp_code`, `tellcorp_name`, `remarks`) VALUES
	('0', '移动', NULL),
	('1', '电信', NULL),
	('2', '联通', NULL),
	('3', '广电', NULL),
	('4', '全行业', NULL);
/*!40000 ALTER TABLE `rom_tellcorp_code` ENABLE KEYS */;


-- Dumping structure for table rom.t_dbconns
DROP TABLE IF EXISTS `t_dbconns`;
CREATE TABLE IF NOT EXISTS `t_dbconns` (
  `label` varchar(60) NOT NULL,
  `host` varchar(64) NOT NULL,
  `user` varchar(32) NOT NULL,
  `pswd` varchar(64) NOT NULL,
  `db` varchar(64) DEFAULT NULL,
  `dbtype` varchar(20) NOT NULL,
  `remarks` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rom.t_dbconns: ~0 rows (approximately)
/*!40000 ALTER TABLE `t_dbconns` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_dbconns` ENABLE KEYS */;


-- Dumping structure for table rom.t_dbtypes
DROP TABLE IF EXISTS `t_dbtypes`;
CREATE TABLE IF NOT EXISTS `t_dbtypes` (
  `dbtype` varchar(20) NOT NULL,
  PRIMARY KEY (`dbtype`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rom.t_dbtypes: ~4 rows (approximately)
/*!40000 ALTER TABLE `t_dbtypes` DISABLE KEYS */;
INSERT INTO `t_dbtypes` (`dbtype`) VALUES
	('mssql'),
	('mysql'),
	('oracle'),
	('sybase');
/*!40000 ALTER TABLE `t_dbtypes` ENABLE KEYS */;


-- Dumping structure for table rom.t_doc
DROP TABLE IF EXISTS `t_doc`;
CREATE TABLE IF NOT EXISTS `t_doc` (
  `docid` int(11) NOT NULL,
  `group_func` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '报表所属功能分组的功能代码',
  `function_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '对应功能树的代码',
  `docname` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '报表名称',
  `baseurl` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'url of open document, include document id',
  `remarks` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`docid`),
  KEY `idx1_t_doc` (`function_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.t_doc: ~1 rows (approximately)
/*!40000 ALTER TABLE `t_doc` DISABLE KEYS */;
INSERT INTO `t_doc` (`docid`, `group_func`, `function_code`, `docname`, `baseurl`, `remarks`) VALUES
	(8, 'DOCG0007', 'DOC0007', '华北区收入', 'http://localhost:8081/rom/npage/test/test1.jsp', 'hello remarks'),
	(16, 'DOCG0006', 'DOC0009', '测试报表', 'http://1.1.1.1:123/url11222', '戴菲菲'),
	(17, 'DOCG0007', 'DOC0010', '2222', 'http://localhost:8081/rom/npage/test/test1.jsp', 'vvvv');
/*!40000 ALTER TABLE `t_doc` ENABLE KEYS */;


-- Dumping structure for table rom.t_docparam
DROP TABLE IF EXISTS `t_docparam`;
CREATE TABLE IF NOT EXISTS `t_docparam` (
  `docid` int(11) DEFAULT NULL,
  `param` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '拼在url里的参数名称',
  `default_value` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数默认值',
  `typeid` int(11) DEFAULT NULL COMMENT 'referenced by t_paramtype.typeid, 参数类型， 如果为0，则允许手工输入',
  `filterflag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否根据登录用户过滤可选参数值 1-yes， 0-no',
  `remarks` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `allowchange` int(11) DEFAULT NULL COMMENT '是否允许修改参数值，为0的话，则查看报表时不显示该参数',
  KEY `idx_docparam1` (`docid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.t_docparam: ~3 rows (approximately)
/*!40000 ALTER TABLE `t_docparam` DISABLE KEYS */;
INSERT INTO `t_docparam` (`docid`, `param`, `default_value`, `typeid`, `filterflag`, `remarks`, `allowchange`) VALUES
	(8, 'sRegion', '11', 16, '0', 'test111', 1),
	(8, 'sYear', '2005', 0, '0', '数据年份', 1),
	(16, 'user', '', 0, '0', '000', 1),
	(17, 'depid', '', 11, '1', 'undefined', 0),
	(8, 'sRegion1', '', 10, '1', 'test', 1);
/*!40000 ALTER TABLE `t_docparam` ENABLE KEYS */;


-- Dumping structure for table rom.t_paramdata
DROP TABLE IF EXISTS `t_paramdata`;
CREATE TABLE IF NOT EXISTS `t_paramdata` (
  `paramid` int(11) NOT NULL DEFAULT '0' COMMENT '使用序列产生， 不重复',
  `typeid` int(11) NOT NULL DEFAULT '0' COMMENT 'referenced by t_paramtype.typeid',
  `paramValue` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数值，如区域编码， 部门编码',
  `paramName` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数名称， 如区域名称， 部门名称等',
  `parentid` int(11) DEFAULT NULL COMMENT '上级id， 0为root',
  `remarks` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数值',
  PRIMARY KEY (`paramid`,`typeid`),
  KEY `idx1_paramdata` (`parentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.t_paramdata: ~27 rows (approximately)
/*!40000 ALTER TABLE `t_paramdata` DISABLE KEYS */;
INSERT INTO `t_paramdata` (`paramid`, `typeid`, `paramValue`, `paramName`, `parentid`, `remarks`) VALUES
	(3, 13, '33', '名称33', 0, '0'),
	(10, 13, '22', '22', 0, '0'),
	(11, 13, '44', '44', 0, '0'),
	(12, 13, '33', '33', 1, '0'),
	(13, 13, '55', 'name111', 10, '0'),
	(14, 13, '66', 'name66', 10, '0'),
	(15, 13, '77', 'name77', 10, '0'),
	(16, 13, '88', '说谎的', 15, '0'),
	(17, 16, 'hello', 'heloo111', 0, '了'),
	(18, 16, 'hello', '离开的时候没说', 0, '了'),
	(19, 16, 'hello', 'heloo111', 0, '了'),
	(20, 16, 'hello', 'heloo111', 19, '了'),
	(21, 16, 'hello111', '我回来了', 20, '了'),
	(22, 16, 'hello', 'heloo111', 21, '了'),
	(23, 16, 'hello', 'heloo111', 22, '了'),
	(24, 16, 'hello', '修改数据', 23, '了'),
	(25, 16, 'hello', 'heloo111', 21, '了'),
	(26, 16, 'hello', 'heloo111', 21, '了'),
	(27, 16, 'hello', '回来了就好', 0, '了'),
	(28, 10, 'sichuan', '四川省', 0, ''),
	(29, 10, 'chengdu', '成都市', 28, ''),
	(30, 10, 'chenghua', '成华区', 29, ''),
	(31, 10, 'wuhou', '武侯区', 29, ''),
	(32, 10, 'jinyang', '青羊区', 29, ''),
	(33, 10, 'jinniu', '金牛区', 29, ''),
	(34, 10, 'gaoxin', '高新区', 29, ''),
	(35, 11, 'manager', '总经理', 0, ''),
	(36, 11, 'it', 'IT部', 35, ''),
	(37, 11, 'hr', '人事部', 35, ''),
	(38, 11, 'finance', '财务部', 35, ''),
	(39, 11, 'sale', '销售部', 35, '');
/*!40000 ALTER TABLE `t_paramdata` ENABLE KEYS */;


-- Dumping structure for table rom.t_parameters
DROP TABLE IF EXISTS `t_parameters`;
CREATE TABLE IF NOT EXISTS `t_parameters` (
  `pname` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pvalue` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remarks` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.t_parameters: ~7 rows (approximately)
/*!40000 ALTER TABLE `t_parameters` DISABLE KEYS */;
INSERT INTO `t_parameters` (`pname`, `pvalue`, `remarks`) VALUES
	('doc.basefunc', 'RPTROOT', '报表挂载的功能树根节点'),
	('doc.baseprocode', 'P001', '报表所在的产品代码'),
	('doc.defaultaction', '../rptdoc_main.do', '报表文档查看的control名称，所有的报表都是用这个'),
	('doc.defaultrole', 'report1', '增加产品树时使用默认的用户角色'),
	('doc.popedoms', 'rptdoc_main.do,getparamtree.do', '报表访问需要设置的control名称'),
	('sap.cmsport', 'redtree1:6400', 'sap的cms地址'),
	('sap.password', '1qaz2wsx', 'sap登录密码'),
	('sap.user', 'test1', 'sap登录用户名');
/*!40000 ALTER TABLE `t_parameters` ENABLE KEYS */;


-- Dumping structure for table rom.t_paramtype
DROP TABLE IF EXISTS `t_paramtype`;
CREATE TABLE IF NOT EXISTS `t_paramtype` (
  `typeid` int(11) NOT NULL,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `datatype` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据类型  String Long Float Date',
  `remarks` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rom.t_paramtype: ~3 rows (approximately)
/*!40000 ALTER TABLE `t_paramtype` DISABLE KEYS */;
INSERT INTO `t_paramtype` (`typeid`, `name`, `datatype`, `remarks`) VALUES
	(0, '[手工输入]', 'String', '初始化生成你'),
	(10, '销售区域', 'String', '销售区域划分'),
	(11, '组织机构', 'String', '123'),
	(13, '部门', 'String', '备注111'),
	(16, '四川地区', 'String', 'abc');
/*!40000 ALTER TABLE `t_paramtype` ENABLE KEYS */;


-- Dumping structure for table rom.t_paramuser_rel
DROP TABLE IF EXISTS `t_paramuser_rel`;
CREATE TABLE IF NOT EXISTS `t_paramuser_rel` (
  `typeid` int(11) DEFAULT NULL COMMENT '参数类型id',
  `paramid` int(11) NOT NULL DEFAULT '0' COMMENT '参数id，因为在参数表中paramid是唯一的， 所以没有加入 typeid',
  `login_no` varchar(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`paramid`,`login_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rom.t_paramuser_rel: ~7 rows (approximately)
/*!40000 ALTER TABLE `t_paramuser_rel` DISABLE KEYS */;
INSERT INTO `t_paramuser_rel` (`typeid`, `paramid`, `login_no`) VALUES
	(13, 13, 'abc'),
	(13, 14, 'abc'),
	(16, 23, 'abc'),
	(16, 24, 'abc'),
	(16, 25, 'abc'),
	(10, 30, 'abc'),
	(10, 31, 'abc');
/*!40000 ALTER TABLE `t_paramuser_rel` ENABLE KEYS */;


-- Dumping structure for table rom.t_paramuser_rel_ex
DROP TABLE IF EXISTS `t_paramuser_rel_ex`;
CREATE TABLE IF NOT EXISTS `t_paramuser_rel_ex` (
  `typeid` int(11) DEFAULT NULL COMMENT '参数类型id',
  `docid` int(11) DEFAULT NULL COMMENT '报表id',
  `paramid` int(11) NOT NULL DEFAULT '0' COMMENT '参数id',
  `login_no` varchar(8) NOT NULL DEFAULT '' COMMENT '登录工号',
  `ex_flag` char(1) DEFAULT NULL COMMENT '例外方式，1为添加 0为排除',
  PRIMARY KEY (`paramid`,`login_no`),
  KEY `idx1_t_paramuser_rel_ex` (`docid`,`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='参数值与登录用户(ROM_SYS_LOGIN) 及 报表（t_doc）关系表 ， 这个与t_paramuser_rel相对而言的例外设置， 有这个配置时， 可对默认的关系做补充';

-- Dumping data for table rom.t_paramuser_rel_ex: ~2 rows (approximately)
/*!40000 ALTER TABLE `t_paramuser_rel_ex` DISABLE KEYS */;
INSERT INTO `t_paramuser_rel_ex` (`typeid`, `docid`, `paramid`, `login_no`, `ex_flag`) VALUES
	(10, 8, 32, 'abc', '1'),
	(10, 8, 33, 'abc', '1'),
	(11, 17, 37, 'abc', '1');
/*!40000 ALTER TABLE `t_paramuser_rel_ex` ENABLE KEYS */;


-- Dumping structure for table rom.t_user
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE IF NOT EXISTS `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(60) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table rom.t_user: ~8 rows (approximately)
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` (`id`, `username`, `password`) VALUES
	(1, 'User412', '654321'),
	(2, 'User480', '654321'),
	(3, 'User225', '654321'),
	(4, 'User254', '654321'),
	(5, 'User147', '654321'),
	(6, 'User271', '654321'),
	(7, 'User197', '654321'),
	(8, 'User64', '654321');
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
