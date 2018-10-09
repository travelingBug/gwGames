/*
SQLyog Enterprise v12.09 (64 bit)
MySQL - 5.5.23 : Database - shiro
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`shiro` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `shiro`;

/*Table structure for table `u_permission` */

DROP TABLE IF EXISTS `u_permission`;

CREATE TABLE `u_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(256) DEFAULT NULL COMMENT 'url地址',
  `name` varchar(64) DEFAULT NULL COMMENT 'url描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `u_permission` */

insert  into `u_permission`(`id`,`url`,`name`) values (4,'/permission/index.shtml','权限列表'),(6,'/permission/addPermission.shtml','权限添加'),(7,'/permission/deletePermissionById.shtml','权限删除'),(8,'/member/list.shtml','用户列表'),(9,'/member/online.shtml','在线用户'),(10,'/member/changeSessionStatus.shtml','用户Session踢出'),(11,'/member/forbidUserById.shtml','用户激活&禁止'),(12,'/member/deleteUserById.shtml','用户删除'),(13,'/permission/addPermission2Role.shtml','权限分配'),(14,'/role/clearRoleByUserIds.shtml','用户角色分配清空'),(15,'/role/addRole2User.shtml','角色分配保存'),(16,'/role/deleteRoleById.shtml','角色列表删除'),(17,'/role/addRole.shtml','角色列表添加'),(18,'/role/index.shtml','角色列表'),(19,'/permission/allocation.shtml','权限分配'),(20,'/role/allocation.shtml','角色分配'),(24,'/player/list.shtml','选手列表'),(25,'/player/auditById.shtml','审核选手'),(26,'/dealer/list.shtml','经销商列表'),(27,'/dealer/addDealer.shtml','增加经销商'),(28,'/dealer/editDealer.shtml','编辑经销商'),(29,'/dealer/forbidUserById.shtml','禁止/激活 经销商登录'),(30,'/dealer/employeeList.shtml','员工管理');

/*Table structure for table `u_role` */

DROP TABLE IF EXISTS `u_role`;

CREATE TABLE `u_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '角色名称',
  `type` varchar(10) DEFAULT NULL COMMENT '角色类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `u_role` */

insert  into `u_role`(`id`,`name`,`type`) values (1,'系统管理员','888888'),(3,'权限角色','100003'),(4,'用户中心','100002'),(5,'经销商','200001'),(6,'员工','200002'),(7,'会员','300001');

/*Table structure for table `u_role_permission` */

DROP TABLE IF EXISTS `u_role_permission`;

CREATE TABLE `u_role_permission` (
  `rid` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `pid` bigint(20) DEFAULT NULL COMMENT '权限ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `u_role_permission` */

insert  into `u_role_permission`(`rid`,`pid`) values (5,30),(4,8),(4,9),(4,10),(4,11),(4,12),(3,4),(3,6),(3,7),(3,13),(3,14),(3,15),(3,16),(3,17),(3,18),(3,19),(3,20),(1,4),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,24),(1,25),(1,26),(1,27),(1,28),(1,29);

/*Table structure for table `u_user` */

DROP TABLE IF EXISTS `u_user`;

CREATE TABLE `u_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) DEFAULT NULL COMMENT '用户昵称',
  `email` varchar(128) DEFAULT NULL COMMENT '邮箱|登录帐号',
  `pswd` varchar(32) DEFAULT NULL COMMENT '密码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `status` bigint(1) DEFAULT '1' COMMENT '1:有效，0:禁止登录',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `u_user` */

insert  into `u_user`(`id`,`nickname`,`email`,`pswd`,`create_time`,`last_login_time`,`status`) values (1,'管理员','admin','57dd03ed397eabaeaa395eb740b770fd','2016-06-16 11:15:33','2017-02-04 08:55:11',1),(11,'soso','8446666@qq.com','d57ffbe486910dd5b26d0167d034f9ad','2016-05-26 20:50:54','2016-06-16 11:24:35',1),(12,'8446666','8446666','4afdc875a67a55528c224ce088be2ab8','2016-05-27 22:34:19','2016-06-15 17:03:16',1);

/*Table structure for table `u_user_role` */

DROP TABLE IF EXISTS `u_user_role`;

CREATE TABLE `u_user_role` (
  `uid` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `rid` bigint(20) DEFAULT NULL COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `u_user_role` */

insert  into `u_user_role`(`uid`,`rid`) values (12,4),(11,3),(11,4),(1,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;



/*==============================================================*/
/* Table: tb_player                                             */
/*==============================================================*/
DROP TABLE IF EXISTS `tb_player`;
CREATE TABLE `tb_player` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(20) NOT NULL,
  `ID_CARD` varchar(20) NOT NULL,
  `TEL_PHONE` varchar(20) NOT NULL,
  `DEL_FLAG` tinyint(4) NOT NULL,
  `AUDIT_FLAG` tinyint(4) NOT NULL,
  `ACCOUNT_NAME` varchar(20) NOT NULL,
  `CRT_TIME` datetime DEFAULT NULL,
  `MOD_TIME` datetime DEFAULT NULL,
  `ACCOUNT_NUM` varchar(50) NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




drop table if exists tb_gains_info;

/*==============================================================*/
/* Table: tb_palyer_gains_Iinfo                                 */
/*==============================================================*/
create table tb_gains_info
(
   ID                   bigint not null auto_increment comment '主键',
   ACCOUNT         varchar(50)  not null comment '资金账号',
   SHARES_CODE          varchar(10) not null comment '股票代码',
   SHARES_NAME          varchar(50) not null comment '股票名称',
   BUSINESS_FLAG        tinyint not null comment '买卖标致',
   VOLUME               int not null comment '成交量',
   PRICE                varchar(20) not null comment '成交价格',
   AMOUNT               varchar(20) not null comment '成交价总金额',
--    BALANCE_MONEY varchar(20) not null comment '资金余额',
--    TOTAL_MONEY varchar(20) not null comment '总资产',
   BUSINESS_TIME        datetime not null comment '交易时间',
   CRT_TIME             datetime not null comment '创建时间',
   MOD_TIME             datetime comment '修改时间',
   primary key (ID)
);
ALTER TABLE `tb_gains_info` ADD INDEX index_idCard ( `ACCOUNT` ) ;

create table tb_player_money
(
   ID                   bigint not null auto_increment comment '主键',
   ACCOUNT         varchar(50)  not null comment '资金账号',
   BALANCE_MONEY varchar(20) not null comment '资金余额',
   TOTAL_MONEY varchar(20) not null comment '总资产',
   BUSINESS_TIME        datetime not null comment '交易时间',
   CRT_TIME             datetime not null comment '创建时间',
   MOD_TIME             datetime comment '修改时间',
   primary key (ID)
);

/*==============================================================*/
/* Table: tb_dealer                                             */
/*==============================================================*/
DROP TABLE IF EXISTS `tb_dealer`;
CREATE TABLE `tb_dealer` (
  `ID` varchar(32) NOT NULL,
  `PARENT_ID` varchar(32) DEFAULT NULL,
  `NAME` varchar(50) NOT NULL,
  `FK_USER_ID` bigint(20) NOT NULL,
  `DEL_FLAG` tinyint(4) NOT NULL,
  `CRT_TIME` datetime DEFAULT NULL,
  `MOD_TIME` datetime DEFAULT NULL,
  `ADDRESS` varchar(32) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  `TYPE` tinyint(4) DEFAULT NULL,
  `SEAT_NUM` varchar(10) DEFAULT NULL,
  `INVITE_NUM` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

drop table if exists TB_VIP;

/*==============================================================*/
/* Table: TB_VIP     会员表                                           */
/*==============================================================*/
CREATE TABLE `tb_vip` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `INVITAION_CODE` varchar(64) NOT NULL,
  `LEVEL` tinyint(4) NOT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `PASSWORD` varchar(32) NOT NULL,
  `NICKNAME` varchar(32) DEFAULT NULL,
  `DEL_FLAG` tinyint(4) NOT NULL,
  `PHONE` varchar(11) DEFAULT NULL,
  `ADDRESS` varchar(20) DEFAULT NULL,
  `CRT_TIME` datetime DEFAULT NULL,
  `MOD_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8

/*==============================================================*/
/* Table: tb_vip_record     会员记录表                                           */
/*==============================================================*/
DROP TABLE IF EXISTS `tb_vip_record`;
CREATE TABLE `tb_vip_record` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `vip_id` varchar(32) NOT NULL,
  `level` tinyint(4) NOT NULL,
  `crt_time` datetime NOT NULL,
  `amount` int(12) NOT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*选手表补充字段*/
ALTER TABLE tb_player ADD BZ VARCHAR(200);
ALTER TABLE tb_player ADD ACCOUNT VARCHAR(32);
ALTER TABLE tb_player ADD CAPITAL VARCHAR(20);

CREATE TABLE `tb_vip_record` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `vip_id` INT(10) NOT NULL,
  `level` TINYINT(4) NOT NULL,
  `crt_time` DATETIME NOT NULL,
  `amount` INT(12) NOT NULL,
  `remark` VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8

ALTER TABLE tb_dealer ADD SEAT_NUM varchar(10);
ALTER TABLE tb_dealer ADD INVITE_NUM varchar(10);

/**
 * 会员关注选手表
 */
DROP TABLE IF EXISTS `tb_vip_follow_player`;
CREATE TABLE `tb_vip_follow_player` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `VIP_PHONE` varchar(11) NOT NULL,
  `ACCOUNT` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

drop table if exists tb_top_by_month;

/*==============================================================*/
/* Table: tb_top_by_month                                 */
/*==============================================================*/
create table tb_top_by_month
(
   ID                   bigint not null auto_increment comment '主键',
   MONTH                varchar(10)  not null comment '月份',
   ACCOUNT_NAME         varchar(50) not null comment '选手昵称',
   ACCOUNT              varchar(50) not null comment '选手资金账号',
   TOTAL_MONEY          varchar(20) not null comment '总资产',
   CAPITAL              varchar(20) not null comment '本金',
   YIELD                varchar(20) not null comment '收益',
   YIELD_RATE           varchar(20) not null comment '收益率',
   BUY_MONEY            varchar(20) not null comment '购买总金额',
   BUY_FOR_ALL_RATE     varchar(20) not null comment '持仓比',
   RANK                 int(5) not null comment '排名',
   primary key (ID)
);

drop table if exists tb_stop_date;

/*==============================================================*/
/* Table: tb_stop_date                                 */
/*==============================================================*/
create table tb_stop_date
(
   ID                   bigint not null auto_increment comment '主键',
   STOP_FLAG               tinyint(4) NOT NULL comment '停止标示（0：未停止，1：已停止）',
   BGN_TIME           datetime comment '开始时间',
   END_TIME              datetime comment '结束时间',
   USER_ID           bigint(20)  comment '操作人员',
   primary key (ID)
);

INSERT INTO tb_stop_date (ID,STOP_FLAG) VALUES(1,0);


drop table if exists tb_stop_date_his;

/*==============================================================*/
/* Table: tb_stop_date                                 */
/*==============================================================*/
create table tb_stop_date_his
(
   ID                   bigint not null auto_increment comment '主键',
   BGN_TIME           datetime comment '开始时间',
   END_TIME              datetime comment '结束时间',
   BGN_USER_ID           bigint(20)  comment '开始操作人员',
	 END_USER_ID           bigint(20)  comment '结束操作人员',
   primary key (ID)
);

/*==============================================================*/
/* Table: tb_event_report 赛事报道                              */
/*==============================================================*/
DROP TABLE IF EXISTS `tb_event_report`;
CREATE TABLE `tb_event_report` (
  `ID` varchar(32) NOT NULL,
  `TITLE` varchar(200) DEFAULT NULL,
  `COVER` varchar(200) DEFAULT NULL,
  `DESCRIBED` varchar(2000) DEFAULT NULL,
  `CONTENT` text DEFAULT NULL,
  `CRT_TIME` datetime DEFAULT NULL,
  `VOLUME` int(5) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8