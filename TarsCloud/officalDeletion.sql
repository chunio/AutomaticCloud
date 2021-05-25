-- CREATE TABLE `t_server_notifys` (
-- 	`id` int(11) NOT NULL AUTO_INCREMENT,
-- 	`application` varchar(128) DEFAULT '',
-- 	`server_name` varchar(128) DEFAULT NULL,
-- 	`container_name` varchar(128) DEFAULT '',
-- 	`node_name` varchar(128) NOT NULL DEFAULT '',
-- 	`set_name` varchar(16) DEFAULT NULL,
-- 	`set_area` varchar(16) DEFAULT NULL,
-- 	`set_group` varchar(16) DEFAULT NULL,
-- 	`server_id` varchar(100) DEFAULT NULL,
-- 	`thread_id` varchar(20) DEFAULT NULL,
-- 	`command` varchar(50) DEFAULT NULL,
-- 	`result` text,
-- 	`notifytime` datetime DEFAULT NULL,
-- 	PRIMARY KEY(`id`),KEY `index_name`(`server_name`,`set_name`,`set_area`,`set_group`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

USE db_tars;

DROP TABLE IF EXISTS `t_server_notifys`;
CREATE TABLE `t_server_notifys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application` varchar(128) DEFAULT '',
  `server_name` varchar(128) DEFAULT NULL,
  `container_name` varchar(128) DEFAULT '',
  `node_name` varchar(128) NOT NULL DEFAULT '',
  `set_name` varchar(16) DEFAULT NULL,
  `set_area` varchar(16) DEFAULT NULL,
  `set_group` varchar(16) DEFAULT NULL,
  `server_id` varchar(100) DEFAULT NULL,
  `thread_id` varchar(20) DEFAULT NULL,
  `command` varchar(50) DEFAULT NULL,
  `result` text,
  `notifytime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_name` (`server_name`),
  KEY `servernoticetime_i_1` (`notifytime`),
  KEY `indx_1_server_id` (`server_id`),
  KEY `query_index` (`application`,`server_name`,`node_name`,`set_name`,`set_area`,`set_group`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

USE db_tars_web;

DROP TABLE IF EXISTS `t_kafka_queue`;

CREATE TABLE `t_kafka_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic` varchar(16) NOT NULL DEFAULT '',
  `partition` int(4) NOT NULL DEFAULT '0',
  `offset` int(11) NOT NULL DEFAULT '0',
  `task_no` varchar(64) NOT NULL DEFAULT '' COMMENT '任务ID',
  `status` varchar(16) NOT NULL DEFAULT 'waiting' COMMENT '任务状态',
  `message` varchar(256) DEFAULT '',
  PRIMARY KEY (`id`,`task_no`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `t_patch_task`;

CREATE TABLE `t_patch_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server` varchar(50) DEFAULT NULL,
  `tgz` text,
  `task_id` varchar(64) DEFAULT NULL COMMENT '任务ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `t_tars_files`;

CREATE TABLE `t_tars_files` (
  `f_id` int(11) NOT NULL AUTO_INCREMENT,
  `application` varchar(64) NOT NULL DEFAULT '' COMMENT '应用名',
  `server_name` varchar(128) NOT NULL DEFAULT '' COMMENT '服务名',
  `file_name` varchar(64) NOT NULL DEFAULT '' COMMENT '文件名',
  `posttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `context` text COMMENT '解析后的JSON对象',
  PRIMARY KEY (`server_name`,`file_name`),
  UNIQUE KEY `f_id` (`f_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=gbk COMMENT='接口测试tars文件表';