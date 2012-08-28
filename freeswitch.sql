-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 22, 2012 at 06:11 PM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `freeswitch`
--

-- --------------------------------------------------------

--
-- Table structure for table `aliases`
--

DROP TABLE IF EXISTS `aliases`;
CREATE TABLE IF NOT EXISTS `aliases` (
  `sticky` int(11) DEFAULT NULL,
  `alias` varchar(128) DEFAULT NULL,
  `command` varchar(4096) DEFAULT NULL,
  `hostname` varchar(256) DEFAULT NULL,
  KEY `alias1` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `calls`
--

DROP TABLE IF EXISTS `calls`;
CREATE TABLE IF NOT EXISTS `calls` (
  `call_created` varchar(128) DEFAULT NULL,
  `call_created_epoch` int(11) DEFAULT NULL,
  `function` varchar(1024) DEFAULT NULL,
  `caller_cid_name` varchar(1024) DEFAULT NULL,
  `caller_cid_num` varchar(256) DEFAULT NULL,
  `caller_dest_num` varchar(256) DEFAULT NULL,
  `caller_chan_name` varchar(1024) DEFAULT NULL,
  `caller_uuid` varchar(256) DEFAULT NULL,
  `callee_cid_name` varchar(1024) DEFAULT NULL,
  `callee_cid_num` varchar(256) DEFAULT NULL,
  `callee_dest_num` varchar(256) DEFAULT NULL,
  `callee_chan_name` varchar(1024) DEFAULT NULL,
  `callee_uuid` varchar(256) DEFAULT NULL,
  `hostname` varchar(256) DEFAULT NULL,
  KEY `eruuindex` (`caller_uuid`(255),`hostname`(255)),
  KEY `eeuuindex` (`callee_uuid`(255),`hostname`(255)),
  KEY `calls1` (`hostname`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `carriers`
--

DROP TABLE IF EXISTS `carriers`;
CREATE TABLE IF NOT EXISTS `carriers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carrier_name` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `carriers`
--

INSERT INTO `carriers` (`id`, `carrier_name`, `enabled`) VALUES
(1, 'FPT', 0),
(2, 'Viettel', 1);

-- --------------------------------------------------------

--
-- Table structure for table `carrier_gateway`
--

DROP TABLE IF EXISTS `carrier_gateway`;
CREATE TABLE IF NOT EXISTS `carrier_gateway` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carrier_id` int(11) DEFAULT NULL,
  `prefix` varchar(255) CHARACTER SET latin1 NOT NULL,
  `suffix` varchar(255) CHARACTER SET latin1 NOT NULL,
  `codec` varchar(255) CHARACTER SET latin1 NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `carrier_id` (`carrier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cdr`
--

DROP TABLE IF EXISTS `cdr`;
CREATE TABLE IF NOT EXISTS `cdr` (
  `caller_id_name` varchar(30) DEFAULT NULL,
  `caller_id_number` varchar(30) DEFAULT NULL,
  `destination_number` varchar(30) DEFAULT NULL,
  `context` varchar(20) DEFAULT NULL,
  `start_stamp` timestamp NULL DEFAULT NULL,
  `answer_stamp` timestamp NULL DEFAULT NULL,
  `end_stamp` timestamp NULL DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `billsec` int(11) DEFAULT NULL,
  `hangup_cause` varchar(50) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `cdr`
--

INSERT INTO `cdr` (`caller_id_name`, `caller_id_number`, `destination_number`, `context`, `start_stamp`, `answer_stamp`, `end_stamp`, `duration`, `billsec`, `hangup_cause`, `id`) VALUES
('09001', '09001', '5000', 'default', '2012-06-21 15:38:57', '2012-06-21 15:38:57', '2012-06-21 15:39:04', 7, 7, 'NORMAL_CLEARING', 1),
('09001', '09001', '0808', 'default', '2012-06-21 15:39:06', NULL, '2012-06-21 15:39:06', 0, 0, 'NO_ROUTE_DESTINATION', 2),
('09001', '09001', '0909', 'default', '2012-06-21 15:39:14', NULL, '2012-06-21 15:39:15', 1, 0, 'ORIGINATOR_CANCEL', 3),
('09001', '09001', '5000', 'default', '2012-06-21 15:42:16', '2012-06-21 15:42:16', '2012-06-21 15:42:51', 35, 35, 'NORMAL_CLEARING', 4),
('09001', '09001', '5000', 'default', '2012-06-22 10:53:53', '2012-06-22 10:53:53', '2012-06-22 10:54:02', 9, 9, 'NORMAL_CLEARING', 5),
('09001', '09001', '5000', 'default', '2012-06-22 10:54:37', '2012-06-22 10:54:37', '2012-06-22 10:54:47', 10, 10, 'NORMAL_CLEARING', 6);

-- --------------------------------------------------------

--
-- Table structure for table `channels`
--

DROP TABLE IF EXISTS `channels`;
CREATE TABLE IF NOT EXISTS `channels` (
  `uuid` varchar(256) DEFAULT NULL,
  `direction` varchar(32) DEFAULT NULL,
  `created` varchar(128) DEFAULT NULL,
  `created_epoch` int(11) DEFAULT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `state` varchar(64) DEFAULT NULL,
  `cid_name` varchar(1024) DEFAULT NULL,
  `cid_num` varchar(256) DEFAULT NULL,
  `ip_addr` varchar(256) DEFAULT NULL,
  `dest` varchar(1024) DEFAULT NULL,
  `application` varchar(128) DEFAULT NULL,
  `application_data` varchar(4096) DEFAULT NULL,
  `dialplan` varchar(128) DEFAULT NULL,
  `context` varchar(128) DEFAULT NULL,
  `read_codec` varchar(128) DEFAULT NULL,
  `read_rate` varchar(32) DEFAULT NULL,
  `write_codec` varchar(128) DEFAULT NULL,
  `write_rate` varchar(32) DEFAULT NULL,
  `secure` varchar(32) DEFAULT NULL,
  `hostname` varchar(256) DEFAULT NULL,
  `presence_id` varchar(4096) DEFAULT NULL,
  `presence_data` varchar(4096) DEFAULT NULL,
  KEY `uuindex` (`uuid`(255),`hostname`(255)),
  KEY `channels1` (`hostname`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `complete`
--

DROP TABLE IF EXISTS `complete`;
CREATE TABLE IF NOT EXISTS `complete` (
  `sticky` int(11) DEFAULT NULL,
  `a1` varchar(128) DEFAULT NULL,
  `a2` varchar(128) DEFAULT NULL,
  `a3` varchar(128) DEFAULT NULL,
  `a4` varchar(128) DEFAULT NULL,
  `a5` varchar(128) DEFAULT NULL,
  `a6` varchar(128) DEFAULT NULL,
  `a7` varchar(128) DEFAULT NULL,
  `a8` varchar(128) DEFAULT NULL,
  `a9` varchar(128) DEFAULT NULL,
  `a10` varchar(128) DEFAULT NULL,
  `hostname` varchar(256) DEFAULT NULL,
  KEY `complete1` (`a1`,`hostname`(255)),
  KEY `complete2` (`a2`,`hostname`(255)),
  KEY `complete3` (`a3`,`hostname`(255)),
  KEY `complete4` (`a4`,`hostname`(255)),
  KEY `complete5` (`a5`,`hostname`(255)),
  KEY `complete6` (`a6`,`hostname`(255)),
  KEY `complete7` (`a7`,`hostname`(255)),
  KEY `complete8` (`a8`,`hostname`(255)),
  KEY `complete9` (`a9`,`hostname`(255)),
  KEY `complete10` (`a10`,`hostname`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `complete`
--

INSERT INTO `complete` (`sticky`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `a7`, `a8`, `a9`, `a10`, `hostname`) VALUES
(0, 'console', 'help', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'loglevel', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'loglevel', 'help', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'loglevel', 'console', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'loglevel', 'alert', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'loglevel', 'crit', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'loglevel', 'err', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'loglevel', 'warning', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'loglevel', 'notice', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'loglevel', 'info', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'loglevel', 'debug', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'colorize', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'colorize', 'help', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'colorize', 'on', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'colorize', 'off', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'console', 'colorize', 'toggle', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'xml_curl', 'debug_on', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'xml_curl', 'debug_off', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'alias', 'add', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'alias', 'del', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'complete', 'add', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'complete', 'del', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'db_cache', 'status', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'debug_level', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'default_dtmf_duration', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'hupall', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'loglevel', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'loglevel', 'console', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'loglevel', 'alert', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'loglevel', 'crit', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'loglevel', 'err', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'loglevel', 'warning', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'loglevel', 'notice', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'loglevel', 'info', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'loglevel', 'debug', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'max_dtmf_duration', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'max_sessions', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'min_dtmf_duration', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'pause', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'reclaim_mem', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'resume', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'shutdown', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'shutdown', 'asap', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'shutdown', 'now', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'shutdown', 'asap', 'restart', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'shutdown', 'cancel', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'shutdown', 'elegant', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'shutdown', 'elegant', 'restart', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'shutdown', 'restart', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'shutdown', 'restart', 'asap', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'shutdown', 'restart', 'elegant', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'sps', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'sync_clock', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'flush_db_handles', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'min_idle_cpu', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fsctl', 'send_sighup', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'nat_map', 'reinit', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'nat_map', 'republish', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'nat_map', 'status', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'reloadacl', 'reloadxml', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'aliases', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'api', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'application', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'calls', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'channels', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'channels', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'chat', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'codec', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'complete', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'dialplan', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'distinct_channels', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'endpoint', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'file', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'interfaces', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'interface_types', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'tasks', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'management', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'modules', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'nat_map', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'say', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'show', 'timer', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'shutdown', '', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'sql_escape', '', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_audio', '::console::list_uuid', 'start', 'read', 'mute', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_audio', '::console::list_uuid', 'start', 'read', 'level', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_audio', '::console::list_uuid', 'start', 'write', 'mute', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_audio', '::console::list_uuid', 'start', 'write', 'level', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_audio', '::console::list_uuid', 'stop', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_bridge', '::console::list_uuid', '::console::list_uuid', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_broadcast', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_chat', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_debug_audio', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_deflect', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_displace', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_display', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_dump', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_exists', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_flush_dtmf', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_getvar', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_hold', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_kill', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_loglevel', '::console::list_uuid', 'console', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_loglevel', '::console::list_uuid', 'alert', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_loglevel', '::console::list_uuid', 'crit', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_loglevel', '::console::list_uuid', 'err', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_loglevel', '::console::list_uuid', 'warning', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_loglevel', '::console::list_uuid', 'notice', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_loglevel', '::console::list_uuid', 'info', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_loglevel', '::console::list_uuid', 'debug', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_media', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_park', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_preprocess', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_record', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_recv_dtmf', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_send_dtmf', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_session_heartbeat', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_setvar_multi', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_setvar', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_transfer', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'version', '', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'uuid_warning', '::console::list_uuid', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, '...', '', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fifo', 'list', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fifo', 'list_verbose', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fifo', 'count', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'fifo', 'importance', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'db', 'insert', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'db', 'delete', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'db', 'select', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'hash', 'insert', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'hash', 'delete', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'hash', 'select', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'group', 'insert', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'group', 'delete', '', '', '', '', '', '', '', '', 'localhost.localdomain'),
(0, 'group', 'call', '', '', '', '', '', '', '', '', 'localhost.localdomain');

-- --------------------------------------------------------

--
-- Table structure for table `gateways`
--

DROP TABLE IF EXISTS `gateways`;
CREATE TABLE IF NOT EXISTS `gateways` (
  `gateway_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gateway_ip` varchar(16) NOT NULL,
  `group` varchar(15) NOT NULL,
  `limit` int(10) unsigned NOT NULL,
  `techprofile` varchar(128) NOT NULL,
  PRIMARY KEY (`gateway_id`),
  KEY `gateway_ip` (`gateway_ip`,`group`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Gateways Table' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `interfaces`
--

DROP TABLE IF EXISTS `interfaces`;
CREATE TABLE IF NOT EXISTS `interfaces` (
  `type` varchar(128) DEFAULT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `description` varchar(4096) DEFAULT NULL,
  `ikey` varchar(1024) DEFAULT NULL,
  `filename` varchar(4096) DEFAULT NULL,
  `syntax` varchar(4096) DEFAULT NULL,
  `hostname` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `lcr`
--

DROP TABLE IF EXISTS `lcr`;
CREATE TABLE IF NOT EXISTS `lcr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `digits` varchar(15) DEFAULT NULL,
  `rate` float(11,5) unsigned NOT NULL,
  `intrastate_rate` float(11,5) unsigned NOT NULL,
  `intralata_rate` float(11,5) unsigned NOT NULL,
  `carrier_id` int(11) NOT NULL,
  `lead_strip` int(11) NOT NULL,
  `trail_strip` int(11) NOT NULL,
  `prefix` varchar(16) NOT NULL,
  `suffix` varchar(16) NOT NULL,
  `lcr_profile` varchar(32) DEFAULT NULL,
  `date_start` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `date_end` datetime NOT NULL DEFAULT '2030-12-31 00:00:00',
  `quality` float(10,6) NOT NULL,
  `reliability` float(10,6) NOT NULL,
  `cid` varchar(32) NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `carrier_id` (`carrier_id`),
  KEY `digits` (`digits`),
  KEY `lcr_profile` (`lcr_profile`),
  KEY `rate` (`rate`),
  KEY `digits_profile_cid_rate` (`digits`,`rate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `nat`
--

DROP TABLE IF EXISTS `nat`;
CREATE TABLE IF NOT EXISTS `nat` (
  `sticky` int(11) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `proto` int(11) DEFAULT NULL,
  `hostname` varchar(256) DEFAULT NULL,
  KEY `nat_map_port_proto` (`port`,`proto`,`hostname`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `npa_nxx_company_ocn`
--

DROP TABLE IF EXISTS `npa_nxx_company_ocn`;
CREATE TABLE IF NOT EXISTS `npa_nxx_company_ocn` (
  `npa` smallint(6) NOT NULL,
  `nxx` smallint(6) NOT NULL,
  `company_type` text,
  `ocn` text,
  `company_name` text,
  `lata` int(11) DEFAULT NULL,
  `ratecenter` text,
  `state` text,
  UNIQUE KEY `npanxx_idx` (`npa`,`nxx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `numbers`
--

DROP TABLE IF EXISTS `numbers`;
CREATE TABLE IF NOT EXISTS `numbers` (
  `number_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gateway_id` int(10) unsigned NOT NULL,
  `number` varchar(16) NOT NULL,
  `acctcode` varchar(16) NOT NULL,
  `translated` varchar(16) NOT NULL,
  PRIMARY KEY (`number_id`),
  UNIQUE KEY `number` (`number`),
  KEY `gateway_id` (`gateway_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Numbers Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sip_authentication`
--

DROP TABLE IF EXISTS `sip_authentication`;
CREATE TABLE IF NOT EXISTS `sip_authentication` (
  `nonce` varchar(255) DEFAULT NULL,
  `expires` int(11) DEFAULT NULL,
  `profile_name` varchar(255) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `last_nc` int(11) DEFAULT NULL,
  KEY `sa_nonce` (`nonce`),
  KEY `sa_hostname` (`hostname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sip_dialogs`
--

DROP TABLE IF EXISTS `sip_dialogs`;
CREATE TABLE IF NOT EXISTS `sip_dialogs` (
  `call_id` varchar(255) DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `sip_to_user` varchar(255) DEFAULT NULL,
  `sip_to_host` varchar(255) DEFAULT NULL,
  `sip_from_user` varchar(255) DEFAULT NULL,
  `sip_from_host` varchar(255) DEFAULT NULL,
  `contact_user` varchar(255) DEFAULT NULL,
  `contact_host` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `direction` varchar(255) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `profile_name` varchar(255) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `presence_id` varchar(255) DEFAULT NULL,
  `presence_data` varchar(255) DEFAULT NULL,
  `call_info` varchar(255) DEFAULT NULL,
  `call_info_state` varchar(255) DEFAULT NULL,
  `expires` int(11) DEFAULT '0',
  KEY `sd_uuid` (`uuid`),
  KEY `sd_hostname` (`hostname`),
  KEY `sd_presence_data` (`presence_data`),
  KEY `sd_call_info` (`call_info`),
  KEY `sd_call_info_state` (`call_info_state`),
  KEY `sd_expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sip_presence`
--

DROP TABLE IF EXISTS `sip_presence`;
CREATE TABLE IF NOT EXISTS `sip_presence` (
  `sip_user` varchar(255) DEFAULT NULL,
  `sip_host` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `rpid` varchar(255) DEFAULT NULL,
  `expires` int(11) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `profile_name` varchar(255) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `network_ip` varchar(255) DEFAULT NULL,
  `network_port` varchar(6) DEFAULT NULL,
  KEY `sp_hostname` (`hostname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sip_recovery`
--

DROP TABLE IF EXISTS `sip_recovery`;
CREATE TABLE IF NOT EXISTS `sip_recovery` (
  `runtime_uuid` varchar(255) DEFAULT NULL,
  `profile_name` varchar(255) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `metadata` text,
  KEY `sr_1` (`runtime_uuid`),
  KEY `sr_2` (`profile_name`),
  KEY `sr_3` (`hostname`),
  KEY `sr_4` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sip_registrations`
--

DROP TABLE IF EXISTS `sip_registrations`;
CREATE TABLE IF NOT EXISTS `sip_registrations` (
  `call_id` varchar(255) DEFAULT NULL,
  `sip_user` varchar(255) DEFAULT NULL,
  `sip_host` varchar(255) DEFAULT NULL,
  `presence_hosts` varchar(255) DEFAULT NULL,
  `contact` varchar(1024) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `rpid` varchar(255) DEFAULT NULL,
  `expires` int(11) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `server_user` varchar(255) DEFAULT NULL,
  `server_host` varchar(255) DEFAULT NULL,
  `profile_name` varchar(255) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `network_ip` varchar(255) DEFAULT NULL,
  `network_port` varchar(6) DEFAULT NULL,
  `sip_username` varchar(255) DEFAULT NULL,
  `sip_realm` varchar(255) DEFAULT NULL,
  `mwi_user` varchar(255) DEFAULT NULL,
  `mwi_host` varchar(255) DEFAULT NULL,
  `orig_server_host` varchar(255) DEFAULT NULL,
  `orig_hostname` varchar(255) DEFAULT NULL,
  KEY `sr_call_id` (`call_id`),
  KEY `sr_sip_user` (`sip_user`),
  KEY `sr_sip_host` (`sip_host`),
  KEY `sr_profile_name` (`profile_name`),
  KEY `sr_presence_hosts` (`presence_hosts`),
  KEY `sr_contact` (`contact`(255)),
  KEY `sr_expires` (`expires`),
  KEY `sr_hostname` (`hostname`),
  KEY `sr_status` (`status`),
  KEY `sr_network_ip` (`network_ip`),
  KEY `sr_network_port` (`network_port`),
  KEY `sr_sip_username` (`sip_username`),
  KEY `sr_sip_realm` (`sip_realm`),
  KEY `sr_orig_server_host` (`orig_server_host`),
  KEY `sr_orig_hostname` (`orig_hostname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sip_shared_appearance_dialogs`
--

DROP TABLE IF EXISTS `sip_shared_appearance_dialogs`;
CREATE TABLE IF NOT EXISTS `sip_shared_appearance_dialogs` (
  `profile_name` varchar(255) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `contact_str` varchar(255) DEFAULT NULL,
  `call_id` varchar(255) DEFAULT NULL,
  `network_ip` varchar(255) DEFAULT NULL,
  `expires` int(11) DEFAULT NULL,
  KEY `ssd_profile_name` (`profile_name`),
  KEY `ssd_hostname` (`hostname`),
  KEY `ssd_contact_str` (`contact_str`),
  KEY `ssd_call_id` (`call_id`),
  KEY `ssd_expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sip_shared_appearance_subscriptions`
--

DROP TABLE IF EXISTS `sip_shared_appearance_subscriptions`;
CREATE TABLE IF NOT EXISTS `sip_shared_appearance_subscriptions` (
  `subscriber` varchar(255) DEFAULT NULL,
  `call_id` varchar(255) DEFAULT NULL,
  `aor` varchar(255) DEFAULT NULL,
  `profile_name` varchar(255) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `contact_str` varchar(255) DEFAULT NULL,
  `network_ip` varchar(255) DEFAULT NULL,
  KEY `ssa_hostname` (`hostname`),
  KEY `ssa_network_ip` (`network_ip`),
  KEY `ssa_subscriber` (`subscriber`),
  KEY `ssa_profile_name` (`profile_name`),
  KEY `ssa_aor` (`aor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sip_subscriptions`
--

DROP TABLE IF EXISTS `sip_subscriptions`;
CREATE TABLE IF NOT EXISTS `sip_subscriptions` (
  `proto` varchar(255) DEFAULT NULL,
  `sip_user` varchar(255) DEFAULT NULL,
  `sip_host` varchar(255) DEFAULT NULL,
  `sub_to_user` varchar(255) DEFAULT NULL,
  `sub_to_host` varchar(255) DEFAULT NULL,
  `presence_hosts` varchar(255) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `contact` varchar(1024) DEFAULT NULL,
  `call_id` varchar(255) DEFAULT NULL,
  `full_from` varchar(255) DEFAULT NULL,
  `full_via` varchar(255) DEFAULT NULL,
  `expires` int(11) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `accept` varchar(255) DEFAULT NULL,
  `profile_name` varchar(255) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `network_port` varchar(6) DEFAULT NULL,
  `network_ip` varchar(255) DEFAULT NULL,
  KEY `ss_call_id` (`call_id`),
  KEY `ss_hostname` (`hostname`),
  KEY `ss_network_ip` (`network_ip`),
  KEY `ss_sip_user` (`sip_user`),
  KEY `ss_sip_host` (`sip_host`),
  KEY `ss_presence_hosts` (`presence_hosts`),
  KEY `ss_event` (`event`),
  KEY `ss_proto` (`proto`),
  KEY `ss_sub_to_user` (`sub_to_user`),
  KEY `ss_sub_to_host` (`sub_to_host`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `task_id` int(11) DEFAULT NULL,
  `task_desc` varchar(4096) DEFAULT NULL,
  `task_group` varchar(1024) DEFAULT NULL,
  `task_sql_manager` int(11) DEFAULT NULL,
  `hostname` varchar(256) DEFAULT NULL,
  KEY `tasks1` (`hostname`(255),`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`task_id`, `task_desc`, `task_group`, `task_sql_manager`, `hostname`) VALUES
(1, 'heartbeat', 'core', 0, 'localhost.localdomain');

-- --------------------------------------------------------

--
-- Table structure for table `thm_auth_assignment`
--

DROP TABLE IF EXISTS `thm_auth_assignment`;
CREATE TABLE IF NOT EXISTS `thm_auth_assignment` (
  `itemname` varchar(64) NOT NULL,
  `userid` int(64) NOT NULL,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`itemname`,`userid`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `thm_auth_assignment`
--

INSERT INTO `thm_auth_assignment` (`itemname`, `userid`, `bizrule`, `data`) VALUES
('Admin', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `thm_auth_item`
--

DROP TABLE IF EXISTS `thm_auth_item`;
CREATE TABLE IF NOT EXISTS `thm_auth_item` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `thm_auth_item`
--

INSERT INTO `thm_auth_item` (`name`, `type`, `description`, `bizrule`, `data`) VALUES
('Admin', 2, NULL, NULL, NULL),
('CDR.Management', 1, NULL, NULL, NULL),
('CDR.View', 0, NULL, NULL, NULL),
('Fsman.Carrier.Admin', 0, NULL, NULL, NULL),
('Fsman.Carrier.Create', 0, NULL, NULL, NULL),
('Fsman.Carrier.Delete', 0, NULL, NULL, NULL),
('Fsman.Carrier.Edit', 0, NULL, NULL, NULL),
('Fsman.Carrier.View', 0, NULL, NULL, NULL),
('Fsman.CarrierGateway.Admin', 0, NULL, NULL, NULL),
('Fsman.CarrierGateway.Create', 0, NULL, NULL, NULL),
('Fsman.CarrierGateway.Delete', 0, NULL, NULL, NULL),
('Fsman.CarrierGateway.Edit', 0, NULL, NULL, NULL),
('Fsman.CarrierGateway.View', 0, NULL, NULL, NULL),
('Fsman.CarrierGatewayManagement', 1, NULL, NULL, NULL),
('Fsman.CarrierManagement', 1, NULL, NULL, NULL),
('Fsman.Gateway.Admin', 0, NULL, NULL, NULL),
('Fsman.Gateway.Create', 0, NULL, NULL, NULL),
('Fsman.Gateway.Delete', 0, NULL, NULL, NULL),
('Fsman.Gateway.Edit', 0, NULL, NULL, NULL),
('Fsman.Gateway.View', 0, NULL, NULL, NULL),
('Fsman.GatewayManagement', 1, NULL, NULL, NULL),
('Fsman.Lcr.Admin', 0, NULL, NULL, NULL),
('Fsman.Lcr.Create', 0, NULL, NULL, NULL),
('Fsman.Lcr.Delete', 0, NULL, NULL, NULL),
('Fsman.Lcr.Edit', 0, NULL, NULL, NULL),
('Fsman.Lcr.View', 0, NULL, NULL, NULL),
('Fsman.LcrManagement', 1, NULL, NULL, NULL),
('Fsman.Number.Admin', 0, NULL, NULL, NULL),
('Fsman.Number.Create', 0, NULL, NULL, NULL),
('Fsman.Number.Delete', 0, NULL, NULL, NULL),
('Fsman.Number.Edit', 0, NULL, NULL, NULL),
('Fsman.Number.View', 0, NULL, NULL, NULL),
('Fsman.NumberManagement', 1, NULL, NULL, NULL),
('Role.Create', 0, NULL, NULL, NULL),
('Role.Delete', 0, NULL, NULL, NULL),
('Role.Edit', 0, NULL, NULL, NULL),
('Role.View', 0, NULL, NULL, NULL),
('RoleManagement', 1, NULL, NULL, NULL),
('Subscriber.Admin', 0, NULL, NULL, NULL),
('Subscriber.Create', 0, NULL, NULL, NULL),
('Subscriber.Delete', 0, NULL, NULL, NULL),
('Subscriber.Edit', 0, NULL, NULL, NULL),
('Subscriber.View', 0, NULL, NULL, NULL),
('SubscriberManagement', 1, NULL, NULL, NULL),
('User.Admin', 0, NULL, NULL, NULL),
('User.Create', 0, NULL, NULL, NULL),
('User.Delete', 0, NULL, NULL, NULL),
('User.Edit', 0, NULL, NULL, NULL),
('User.View', 0, NULL, NULL, NULL),
('UserManagement', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `thm_auth_item_child`
--

DROP TABLE IF EXISTS `thm_auth_item_child`;
CREATE TABLE IF NOT EXISTS `thm_auth_item_child` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `thm_auth_item_child`
--

INSERT INTO `thm_auth_item_child` (`parent`, `child`) VALUES
('Admin', 'CDR.Management'),
('CDR.Management', 'CDR.View'),
('Fsman.CarrierManagement', 'Fsman.Carrier.Admin'),
('Fsman.CarrierManagement', 'Fsman.Carrier.Create'),
('Fsman.CarrierManagement', 'Fsman.Carrier.Delete'),
('Fsman.CarrierManagement', 'Fsman.Carrier.Edit'),
('Fsman.CarrierManagement', 'Fsman.Carrier.View'),
('Fsman.CarrierGatewayManagement', 'Fsman.CarrierGateway.Admin'),
('Fsman.CarrierGatewayManagement', 'Fsman.CarrierGateway.Create'),
('Fsman.CarrierGatewayManagement', 'Fsman.CarrierGateway.Delete'),
('Fsman.CarrierGatewayManagement', 'Fsman.CarrierGateway.Edit'),
('Fsman.CarrierGatewayManagement', 'Fsman.CarrierGateway.View'),
('Admin', 'Fsman.CarrierGatewayManagement'),
('Admin', 'Fsman.CarrierManagement'),
('Fsman.GatewayManagement', 'Fsman.Gateway.Admin'),
('Fsman.GatewayManagement', 'Fsman.Gateway.Create'),
('Fsman.GatewayManagement', 'Fsman.Gateway.Delete'),
('Fsman.GatewayManagement', 'Fsman.Gateway.Edit'),
('Fsman.GatewayManagement', 'Fsman.Gateway.View'),
('Admin', 'Fsman.GatewayManagement'),
('Fsman.LcrManagement', 'Fsman.Lcr.Admin'),
('Fsman.LcrManagement', 'Fsman.Lcr.Create'),
('Fsman.LcrManagement', 'Fsman.Lcr.Delete'),
('Fsman.LcrManagement', 'Fsman.Lcr.Edit'),
('Fsman.LcrManagement', 'Fsman.Lcr.View'),
('Admin', 'Fsman.LcrManagement'),
('Fsman.NumberManagement', 'Fsman.Number.Admin'),
('Fsman.NumberManagement', 'Fsman.Number.Create'),
('Fsman.NumberManagement', 'Fsman.Number.Delete'),
('Fsman.NumberManagement', 'Fsman.Number.Edit'),
('Fsman.NumberManagement', 'Fsman.Number.View'),
('Admin', 'Fsman.NumberManagement'),
('RoleManagement', 'Role.Create'),
('RoleManagement', 'Role.Delete'),
('RoleManagement', 'Role.Edit'),
('RoleManagement', 'Role.View'),
('Admin', 'RoleManagement'),
('SubscriberManagement', 'Subscriber.Admin'),
('SubscriberManagement', 'Subscriber.Create'),
('SubscriberManagement', 'Subscriber.Delete'),
('SubscriberManagement', 'Subscriber.Edit'),
('SubscriberManagement', 'Subscriber.View'),
('Admin', 'SubscriberManagement'),
('UserManagement', 'User.Admin'),
('UserManagement', 'User.Create'),
('UserManagement', 'User.Delete'),
('UserManagement', 'User.Edit'),
('UserManagement', 'User.View'),
('Admin', 'UserManagement');

-- --------------------------------------------------------

--
-- Table structure for table `thm_dictionary`
--

DROP TABLE IF EXISTS `thm_dictionary`;
CREATE TABLE IF NOT EXISTS `thm_dictionary` (
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `thm_dictionary_values`
--

DROP TABLE IF EXISTS `thm_dictionary_values`;
CREATE TABLE IF NOT EXISTS `thm_dictionary_values` (
  `DictionaryName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Value` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Order` int(11) NOT NULL DEFAULT '0',
  `Description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DictionaryName`,`Value`),
  KEY `fk_dictionary-value_dictionary` (`DictionaryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `thm_subscriber`
--

DROP TABLE IF EXISTS `thm_subscriber`;
CREATE TABLE IF NOT EXISTS `thm_subscriber` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `Number` varchar(45) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `UserContext` varchar(45) DEFAULT NULL,
  `Enabled` bit(1) NOT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CreatedBy` int(11) NOT NULL,
  `UpdatedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UpdatedBy` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name_UNIQUE` (`Number`),
  KEY `UserId` (`UserId`),
  KEY `UserId_Name` (`UserId`,`Number`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='SIP account' AUTO_INCREMENT=9 ;

--
-- Dumping data for table `thm_subscriber`
--

INSERT INTO `thm_subscriber` (`Id`, `UserId`, `Number`, `Password`, `UserContext`, `Enabled`, `CreatedDate`, `CreatedBy`, `UpdatedDate`, `UpdatedBy`) VALUES
(3, 1, '09001', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'default', '1', '2012-06-19 17:54:56', 0, '2012-07-03 15:54:08', 0),
(4, 1, '9876', '622624bc436e3205074e919e52ec75b8', 'default', '1', '2012-06-22 14:57:20', 0, '2012-07-04 15:16:34', 0),
(5, 2, '08001', '123456', 'default', '1', '2012-06-23 20:49:15', 0, '2012-06-23 20:49:15', 0),
(7, 1, '07001', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'default', '1', '2012-07-03 15:54:50', 0, '2012-07-03 15:54:50', 0),
(8, 1, '123456', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'default', '0', '2012-07-04 14:08:39', 0, '2012-07-04 13:27:43', 0);

-- --------------------------------------------------------

--
-- Table structure for table `thm_user`
--

DROP TABLE IF EXISTS `thm_user`;
CREATE TABLE IF NOT EXISTS `thm_user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Password` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Enabled` bit(1) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CreatedBy` int(11) DEFAULT NULL,
  `UpdatedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UpdatedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Username_UNIQUE` (`Username`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Back office users' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `thm_user`
--

INSERT INTO `thm_user` (`Id`, `Username`, `Password`, `Email`, `Enabled`, `CreatedDate`, `CreatedBy`, `UpdatedDate`, `UpdatedBy`) VALUES
(1, 'root', 'bd5a8156923ea4c948bbbae3888eb735b86f31372d2e3e49447c2f8a2c470dbc', 'root@abc.com', '1', '2012-07-03 15:42:07', NULL, '2012-07-03 15:26:58', NULL),
(2, 'dung.nguyen', 'bd5a8156923ea4c948bbbae3888eb735b86f31372d2e3e49447c2f8a2c470dbc', 'dung.nguyen@abc.com', '1', '2012-06-17 16:25:52', 1, '2012-07-03 15:47:40', 1),
(3, 'hadn', 'welkom01', 'hadn@fpt.net', '1', '2012-06-17 16:25:52', 1, '2012-06-17 16:24:07', 1),
(4, 'vunt', 'bd5a8156923ea4c948bbbae3888eb735b86f31372d2e3e49447c2f8a2c470dbc', 'vunt@abc.com', '0', '2012-07-03 15:48:11', 1, '2012-07-03 15:48:11', 1),
(5, 'abc', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'abc@abc.com', '1', '2012-07-04 13:26:30', 1, '2012-07-04 13:26:30', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_cdr`
--
DROP VIEW IF EXISTS `view_cdr`;
CREATE TABLE IF NOT EXISTS `view_cdr` (
`CallerNumber` varchar(30)
,`CallerName` varchar(50)
,`CalleeNumber` varchar(30)
,`CalleeName` varchar(50)
,`Context` varchar(20)
,`InitTime` timestamp
,`AnswerTime` timestamp
,`EndTime` timestamp
,`SessionDuration` int(11)
,`CallDuration` int(11)
,`HangupCause` varchar(50)
);
-- --------------------------------------------------------

--
-- Structure for view `view_cdr`
--
DROP TABLE IF EXISTS `view_cdr`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cdr` AS select `oc`.`caller_id_number` AS `CallerNumber`,`us1`.`Username` AS `CallerName`,`oc`.`destination_number` AS `CalleeNumber`,`us2`.`Username` AS `CalleeName`,`oc`.`context` AS `Context`,`oc`.`start_stamp` AS `InitTime`,`oc`.`answer_stamp` AS `AnswerTime`,`oc`.`end_stamp` AS `EndTime`,`oc`.`duration` AS `SessionDuration`,`oc`.`billsec` AS `CallDuration`,`oc`.`hangup_cause` AS `HangupCause` from ((((`cdr` `oc` left join `thm_subscriber` `sub1` on((`oc`.`caller_id_number` = `sub1`.`Number`))) left join `thm_user` `us1` on((`sub1`.`UserId` = `us1`.`Id`))) left join `thm_subscriber` `sub2` on((`oc`.`destination_number` = `sub2`.`Number`))) left join `thm_user` `us2` on((`sub2`.`UserId` = `us2`.`Id`)));

--
-- Constraints for dumped tables
--

--
-- Constraints for table `lcr`
--
ALTER TABLE `lcr`
  ADD CONSTRAINT `carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `carriers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `thm_auth_assignment`
--
ALTER TABLE `thm_auth_assignment`
  ADD CONSTRAINT `thm_auth_assignment_ibfk_1` FOREIGN KEY (`itemname`) REFERENCES `thm_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `thm_auth_assignment_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `thm_user` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `thm_auth_item_child`
--
ALTER TABLE `thm_auth_item_child`
  ADD CONSTRAINT `thm_auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `thm_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `thm_auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `thm_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `thm_dictionary_values`
--
ALTER TABLE `thm_dictionary_values`
  ADD CONSTRAINT `fk_dictionary-value_dictionary` FOREIGN KEY (`DictionaryName`) REFERENCES `thm_dictionary` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `thm_subscriber`
--
ALTER TABLE `thm_subscriber`
  ADD CONSTRAINT `thmUser_thmSubscriber_UserId` FOREIGN KEY (`UserId`) REFERENCES `thm_user` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
