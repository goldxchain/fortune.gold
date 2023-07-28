#
# TABLE STRUCTURE FOR: dbt_admin
#

DROP TABLE IF EXISTS `dbt_admin`;

CREATE TABLE `dbt_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `about` text DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(32) NOT NULL,
  `password_reset_token` varchar(20) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_logout` datetime DEFAULT NULL,
  `ip_address` varchar(33) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `is_admin` tinyint(4) NOT NULL DEFAULT 0,
  `lang` varchar(20) NOT NULL DEFAULT 'english',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_admin` (`id`, `firstname`, `lastname`, `about`, `email`, `password`, `password_reset_token`, `image`, `last_login`, `last_logout`, `ip_address`, `status`, `is_admin`, `lang`) VALUES (1, NULL, NULL, NULL, 'admin@demo.com', 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, '2022-09-01 13:34:41', NULL, '::1', 1, 1, 'english');


#
# TABLE STRUCTURE FOR: dbt_admin_wallet
#

DROP TABLE IF EXISTS `dbt_admin_wallet`;

CREATE TABLE `dbt_admin_wallet` (
  `awid` bigint(20) NOT NULL AUTO_INCREMENT,
  `wallet_address` varchar(50) DEFAULT NULL,
  `balance` double(26,12) DEFAULT NULL,
  `version` tinyint(4) DEFAULT NULL,
  `id` varchar(40) DEFAULT NULL,
  `ciphertext` varchar(70) DEFAULT NULL,
  `iv` varchar(35) DEFAULT NULL,
  `cipher` varchar(15) DEFAULT NULL,
  `kdf` varchar(8) DEFAULT NULL,
  `dklen` tinyint(4) DEFAULT NULL,
  `salt` varchar(70) DEFAULT NULL,
  `n` int(11) DEFAULT NULL,
  `r` tinyint(4) DEFAULT NULL,
  `p` tinyint(4) DEFAULT NULL,
  `mac` varchar(70) DEFAULT NULL,
  `encrypt_val` text DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1 COMMENT '1=Active/0=Inactive',
  `earned_fees` double(22,8) NOT NULL DEFAULT 0.00000000,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`awid`),
  KEY `wallet_address` (`wallet_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_blockchain_network
#

DROP TABLE IF EXISTS `dbt_blockchain_network`;

CREATE TABLE `dbt_blockchain_network` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_name` varchar(100) DEFAULT NULL,
  `network_slug` varchar(100) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `rpc_url` varchar(255) DEFAULT NULL,
  `chain_id` int(11) DEFAULT NULL,
  `currency_symbol` varchar(20) DEFAULT NULL,
  `explore_url` varchar(255) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `server_ip` varchar(22) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_blockchain_network` (`id`, `network_name`, `network_slug`, `logo`, `rpc_url`, `chain_id`, `currency_symbol`, `explore_url`, `port`, `server_ip`, `created_at`, `created_by`, `status`) VALUES (1, 'Polygon', 'polygon', NULL, 'https://polygon-rpc.com/', 137, 'MATIC', 'https://polygonscan.com/', 81, 'localhost', '2022-08-03 07:11:28', NULL, 1);
INSERT INTO `dbt_blockchain_network` (`id`, `network_name`, `network_slug`, `logo`, `rpc_url`, `chain_id`, `currency_symbol`, `explore_url`, `port`, `server_ip`, `created_at`, `created_by`, `status`) VALUES (2, 'Mumbai Testnet(Polygon)', 'polygon-testnet', NULL, 'https://rpc-mumbai.maticvigil.com/', 80001, 'MATIC', 'https://mumbai.polygonscan.com/', 81, 'localhost', '2022-08-03 07:12:27', NULL, 0);
INSERT INTO `dbt_blockchain_network` (`id`, `network_name`, `network_slug`, `logo`, `rpc_url`, `chain_id`, `currency_symbol`, `explore_url`, `port`, `server_ip`, `created_at`, `created_by`, `status`) VALUES (3, 'Ropsten (Ethereum testnet)', 'ropsten', NULL, 'https://ropsten.infura.io/v3/1913a8567db645fdac901f8c7e9c0015', 3, 'ETH', 'https://ropsten.etherscan.io/', 81, 'localhost', NULL, NULL, 0);


#
# TABLE STRUCTURE FOR: dbt_contract_setup
#

DROP TABLE IF EXISTS `dbt_contract_setup`;

CREATE TABLE `dbt_contract_setup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_name` varchar(100) NOT NULL,
  `contract_symbol` varchar(50) NOT NULL,
  `max_token_supply` int(11) DEFAULT NULL,
  `contract_address` varchar(50) NOT NULL,
  `tnx_hash` varchar(128) NOT NULL,
  `status` int(11) NOT NULL COMMENT '0 = Inactive, 1 = Active',
  `network_id` int(11) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# TABLE STRUCTURE FOR: dbt_email_sms_gateway
#

DROP TABLE IF EXISTS `dbt_email_sms_gateway`;

CREATE TABLE `dbt_email_sms_gateway` (
  `es_id` int(11) NOT NULL AUTO_INCREMENT,
  `gatewayname` varchar(10) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `protocol` varchar(100) DEFAULT NULL,
  `host` varchar(100) DEFAULT NULL,
  `port` varchar(100) DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  `userid` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `mailtype` varchar(100) DEFAULT NULL,
  `charset` varchar(100) DEFAULT NULL,
  `api` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`es_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_email_sms_gateway` (`es_id`, `gatewayname`, `title`, `protocol`, `host`, `port`, `user`, `userid`, `password`, `mailtype`, `charset`, `api`) VALUES (1, 'budgetsms', 'Bdtask', NULL, 'https://api.budgetsms.net/sendsms/?', NULL, 'bdtask', '2345', NULL, NULL, NULL, 'r44ee7b6b3bd16cc69aec82f6tt');
INSERT INTO `dbt_email_sms_gateway` (`es_id`, `gatewayname`, `title`, `protocol`, `host`, `port`, `user`, `userid`, `password`, `mailtype`, `charset`, `api`) VALUES (2, 'smtp', 'nftbox', 'gsmtp', 'ssl:', '465', 'demo@gmail.com', '', '1234', 'html', 'utf-8', NULL);


#
# TABLE STRUCTURE FOR: dbt_envato_purchase_info
#

DROP TABLE IF EXISTS `dbt_envato_purchase_info`;

CREATE TABLE `dbt_envato_purchase_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_key` varchar(100) NOT NULL,
  `purchase_key` varchar(100) NOT NULL,
  `sold_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `supported_until` timestamp NULL DEFAULT NULL,
  `item_name` varchar(500) NOT NULL,
  `item_id` varchar(50) NOT NULL,
  `create_at` datetime DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

INSERT INTO `dbt_envato_purchase_info` (`id`, `product_key`, `purchase_key`, `sold_at`, `supported_until`, `item_name`, `item_id`, `create_at`, `update_at`) VALUES (1, '38375099', '83438b0e-8d17-4dda-b255-f5122c19d3e5', '2022-07-26 16:43:30', '2023-01-25 08:43:30', 'NFTBOX - NFT Marketplace Script', '38375099', '2022-08-23 10:08:41', NULL);


#
# TABLE STRUCTURE FOR: dbt_eth_network
#

DROP TABLE IF EXISTS `dbt_eth_network`;

CREATE TABLE `dbt_eth_network` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_name` varchar(100) DEFAULT NULL,
  `network_slug` varchar(100) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `rpc_url` varchar(255) DEFAULT NULL,
  `chain_id` int(11) DEFAULT NULL,
  `currency_symbol` varchar(20) DEFAULT NULL,
  `explore_url` varchar(255) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `server_ip` varchar(22) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO `dbt_eth_network` (`id`, `network_name`, `network_slug`, `logo`, `rpc_url`, `chain_id`, `currency_symbol`, `explore_url`, `port`, `server_ip`, `created_at`, `created_by`, `status`) VALUES (1, 'Polygon', 'polygon', NULL, 'https://polygon-rpc.com/', 137, 'MATIC', 'https://polygonscan.com/', 81, 'localhost', '2022-08-03 01:11:28', NULL, 0);
INSERT INTO `dbt_eth_network` (`id`, `network_name`, `network_slug`, `logo`, `rpc_url`, `chain_id`, `currency_symbol`, `explore_url`, `port`, `server_ip`, `created_at`, `created_by`, `status`) VALUES (2, 'Mumbai Testnet(Polygon)', 'polygon-testnet', NULL, 'https://rpc-mumbai.maticvigil.com/', 80001, 'MATIC', 'https://mumbai.polygonscan.com/', 81, 'localhost', '2022-08-03 01:12:27', NULL, 0);
INSERT INTO `dbt_eth_network` (`id`, `network_name`, `network_slug`, `logo`, `rpc_url`, `chain_id`, `currency_symbol`, `explore_url`, `port`, `server_ip`, `created_at`, `created_by`, `status`) VALUES (3, 'ETHEREUM', 'eth', NULL, 'https://mainnet.infura.io/v3/1913a8567db645fdac901f8c7e9c0015', 1, 'ETH', 'https://etherscan.io/', 81, NULL, '2022-08-24 05:51:26', NULL, 0);
INSERT INTO `dbt_eth_network` (`id`, `network_name`, `network_slug`, `logo`, `rpc_url`, `chain_id`, `currency_symbol`, `explore_url`, `port`, `server_ip`, `created_at`, `created_by`, `status`) VALUES (4, 'Ropsten (Ethereum testnet)', 'ropsten', NULL, 'https://ropsten.infura.io/v3/1913a8567db645fdac901f8c7e9c0015', 3, 'ETH', 'https://ropsten.etherscan.io/', 81, NULL, '2022-08-24 05:51:26', NULL, 0);


#
# TABLE STRUCTURE FOR: dbt_external_api_setup
#

DROP TABLE IF EXISTS `dbt_external_api_setup`;

CREATE TABLE `dbt_external_api_setup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `data` text NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `dbt_external_api_setup` (`id`, `name`, `data`, `status`) VALUES (4, 'Google Map API', '{\"api_key\":\"AIzaSyAUmj7I0GuGJWRcol-pMUmM4rrnHS90DE8\"}', 1);


#
# TABLE STRUCTURE FOR: dbt_favorite_items
#

DROP TABLE IF EXISTS `dbt_favorite_items`;

CREATE TABLE `dbt_favorite_items` (
  `fv_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(12) DEFAULT NULL,
  `nft_id` int(11) DEFAULT NULL,
  `network_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`fv_id`),
  KEY `fv_id` (`fv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_fees_tbl
#

DROP TABLE IF EXISTS `dbt_fees_tbl`;

CREATE TABLE `dbt_fees_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` text DEFAULT NULL,
  `fees` float DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_file_gateway
#

DROP TABLE IF EXISTS `dbt_file_gateway`;

CREATE TABLE `dbt_file_gateway` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gateway_name` varchar(55) DEFAULT NULL,
  `api_key` varchar(255) DEFAULT NULL,
  `secret_key` varchar(255) DEFAULT NULL,
  `end_point` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_language
#

DROP TABLE IF EXISTS `dbt_language`;

CREATE TABLE `dbt_language` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phrase` text NOT NULL,
  `english` text DEFAULT NULL,
  `french` text DEFAULT NULL,
  `korean` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=983 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (1, 'email', 'Email Address', 'Email', '이메일');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (2, 'password', 'Password', 'Mot de passe', '비밀번호');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (3, 'login', 'Log In', 'Connexion', '로그인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (4, 'incorrect_email_password', 'Incorrect Email/Password!', 'Mot de passe ou email incorrect', '받은 편지함 메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (5, 'user_role', 'User Role', 'Rôle Utilisateur', '사용자 역할');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (6, 'please_login', 'Please Log In', 'Veuillez vous connecter', '로그인 해주세요');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (7, 'setting', 'Setting', 'Reglages', '환경');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (8, 'profile', 'Profile', 'Profil', '프로필');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (9, 'logout', 'Log Out', 'Déconnexion', '로그 아웃');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (10, 'please_try_again', 'Please Try Again', 'Essayez encore !', '다시 시도하십시오');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (11, 'admin', 'Admin', 'Administrateur', '사용자 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (12, 'dashboard', 'Dashboard ', 'Tableau de Bord', '계기반');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (13, 'language_setting', 'Language Setting', 'Reglage Langue', '언어 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (14, 'status', 'Status', 'Status', '상태');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (15, 'active', 'Active', 'Actif', '활동적인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (16, 'inactive', 'Inactive', 'Inactif', '비활성');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (17, 'cancel', 'Cancel', 'Annuler', '취소');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (18, 'save', 'Save', 'Sauvegarder', '저장');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (19, 'serial', 'SL.NO', 'Serial', '연속물');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (20, 'action', 'Action', 'Action', '동작');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (21, 'edit', 'Edit ', 'Editer', '편집하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (22, 'delete', 'Delete', 'Supprimer', '삭제');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (23, 'save_successfully', 'Save Successfully!', 'Sauvegarde reussi', '성공적으로 저장');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (24, 'update_successfully', 'Update Successfully!', 'Mise à jour reussi', '성공적으로 업데이트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (25, 'delete_successfully', 'Delete successfully!', 'Suppression Reussi', '성공적으로 삭제');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (26, 'are_you_sure', 'Are You Sure ? ', 'Etes-vous sure?', '확실합니까');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (27, 'ip_address', 'IP Address', 'Adresse IP', 'IP 주소');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (28, 'application_title', 'Application Title', 'Titre appli', '신청서 제목');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (29, 'favicon', 'Favicon', 'favicon', '파비콘');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (30, 'logo', 'Logo', 'Logo', '심벌 마크');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (31, 'footer_text', 'Footer Text', 'Titre Footer', '바닥글 텍스트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (32, 'language', 'Language', 'Langue', '언어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (33, 'website_title', 'Website Title', 'Titre site web', '웹사이트 제목');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (34, 'invalid_logo', 'Invalid Logo', 'Logo invalide', '잘못된 로고');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (35, 'submit_successfully', 'Submit Successfully!', 'Envoi reussi', '성공적으로 제출');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (36, 'application_setting', 'Application Setting', 'Reglages appli', '애플리케이션 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (37, 'invalid_favicon', 'Invalid Favicon', 'Favicon Invalide', '잘못된 파비콘');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (38, 'submit', 'Submit', 'Envoyez', '제출하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (39, 'site_align', 'Website Align', 'Alignement site', '사이트 정렬');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (40, 'right_to_left', 'Right to Left', 'Doite vers la gauche', '오른쪽에서 왼쪽으로');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (41, 'left_to_right', 'Left to Right', 'Gauche Vers la droite', '왼쪽 아니면 오른쪽');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (42, 'subject', 'Subject', 'Sujet', '주제');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (43, 'receiver_name', 'Send To', 'Nom Bénéficiaire', '수취인 성명');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (44, 'select_user', 'Select User', 'Selectionner Utilisateur', '사용자 선택');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (45, 'message_sent', 'Messages Sent', 'Message Envoyé', '메시지 보내기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (46, 'mail', 'Mail', 'Mail', '우편');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (47, 'send_mail', 'Send Mail', 'Envoyer Mail', '메일을 보내다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (48, 'mail_setting', 'Mail Setting', 'Reglage mail', '마이 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (49, 'protocol', 'Protocol', 'Protocole', '규약');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (50, 'mailpath', 'Mail Path', 'Repertoire Mail', '메일 경로');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (51, 'mailtype', 'Mail Type', 'Type mail', '우편물');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (52, 'validate_email', 'Validate Email Address', 'Validez votre Email', '유효한 이메일');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (53, 'true', 'True', 'Vraie', '진실');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (54, 'false', 'False', 'faux', '거짓');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (55, 'attach_file', 'Attach File', 'Joindre un document', '첨부파일');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (56, 'wordwrap', 'Enable Word Wrap', 'Wordwrap', '줄 바꿈');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (57, 'send', 'Send', 'Envoyer', '보내다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (58, 'app_setting', 'App Setting', 'Reglages appli', '앱 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (59, 'sms', 'SMS', 'SMS', 'SMS');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (60, 'gateway_setting', 'Gateway Setting', 'Reglage portail', '게이트웨이 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (61, 'time_zone', 'Time Zone', 'Time Zone', '시간대');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (62, 'provider', 'Provider', 'Fournisseur', '공급자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (63, 'sms_template', 'SMS Template', 'Template SMS', 'SMS 템플릿');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (64, 'template_name', 'Template Name', 'Nom du template', '템플릿 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (65, 'sms_schedule', 'SMS Schedule', 'Emploi du temps SMS', 'SMS 일정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (66, 'schedule_name', 'Schedule Name', 'Nom d\'horaire', '일정 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (67, 'time', 'Time', 'Heure', '시각');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (68, 'already_exists', 'Already Exists', 'Existe déjà', '이미 확인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (69, 'send_custom_sms', 'Send Custom SMS', 'Envoyer SMS personalisé', '맞춤 SMS 보내기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (70, 'sms_sent', 'SMS Sent!', 'SMS envoyé', '보낸 SMS');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (71, 'custom_sms_list', 'Custom SMS List', 'List SMS personalisé', '고객 SMS 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (72, 'reciver', 'Reciver', 'Bénéficiaire', '수화기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (73, 'auto_sms_report', 'Auto SMS Report', 'Rapport SMS Auto', '경매 종료 보고서');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (74, 'user_sms_list', 'User SMS List', 'Liste SMS utilisateurs', '사용자 SMS 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (75, 'send_sms', 'Send SMS', 'Envoyer SMS', '문자를 보내다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (76, 'new_sms', 'New SMS', 'Nouveau Message', '새로운 SMS');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (77, 'update', 'Update', 'Mettre à jour', '업데이트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (78, 'reset', 'Reset', 'Reinitialiser', '초기화');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (79, 'messages', 'Messages', 'Messages', '메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (80, 'inbox', 'Inbox', 'Boite de réception', '받은 편지함');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (81, 'sent', 'Sent', 'Envoyé', '전송된');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (82, 'captcha', 'Captcha', 'Captcha', '보안 문자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (83, 'welcome_back', 'Welcome back ', 'Bienvenue à nouveau !', '다시 오신 것을 환영합니다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (84, 'inbox_message', 'Inbox Message', 'SMS Boite de réception', '받은 편지함 메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (85, 'image_upload_successfully', 'Image Upload Successfully.', 'Upload d\'image reussi', '이미지 업로드 성공');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (87, 'users', 'Users', 'Utilisateurs', '사용자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (88, 'add_user', 'Add User', 'Ajouter utilisateur', '사용자 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (89, 'user_list', 'User List', 'Liste Utilisateurs', '사용자 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (90, 'firstname', 'First Name', 'Nom', '이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (91, 'lastname', 'Last Name', 'Prénoms', '성');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (92, 'about', 'About', 'A propos de nous', '~에 대한');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (93, 'preview', 'Preview', 'Visualliser', '시사');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (94, 'last_login', 'Last Login', 'Dernière connexion', '마지막 로그인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (95, 'last_logout', 'Last Logout', 'Dernière Déconnexion', '마지막 로그아웃');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (96, 'image', 'Image', 'Image', '영상');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (97, 'fullname', 'Full Name', 'Nom Complet', '성명');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (98, 'new_message', 'New Message', 'Nouveau Message', '새로운 메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (99, 'message', 'Message', 'Message', '메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (100, 'sender_name', 'Sender Name', 'Nom de l\'expéditeur', '보낸 사람 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (101, 'sl_no', 'SL No.', 'Numéro SL', '슬 아니오');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (103, 'message_details', 'Message Details', 'Détails message', '메시지 세부정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (104, 'date', 'Date', 'Date', '데이트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (105, 'select_option', 'Select Option', 'Selectionner Option', '선택 옵션');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (106, 'edit_profile', 'Edit Profile', 'Editer Profile', '프로필 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (107, 'edit_user', 'Edit User', 'Editer utilisateur', '사용자 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (108, 'sent_message', 'Sent Message', 'Message Envoyé', '보낸 메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (109, 'sub_admin', 'Sub Admin', 'Sub Administrateur', '하위 관리자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (110, 'admin_list', 'Admin List', 'List Administrateurs', '관리자 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (111, 'add_admin', 'Add Admin', 'Ajouter Administrateur', '관리자 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (112, 'edit_admin', 'Edit Admin', 'Editer Admin', '관리자 수정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (113, 'username', 'Username', 'Nom utilisateur', '사용자 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (114, 'sponsor_id', 'Sponsor ID', 'ID sponsor', '스폰서 아이디');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (115, 'mobile', 'Mobile', 'Mobile', '이동하는');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (116, 'register', 'Register', 'Enregistrer', '등록하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (117, 'conf_password', 'Confirm Password', 'Reglage mot de passe', '비밀번호 확인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (118, 'user_id', 'User ID', 'ID utilisateur', '사용자 ID');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (119, 'package', 'Package', 'Pack', '패키지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (120, 'create', 'Create', 'Créer', '만들다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (121, 'package_name', 'Package Name', 'Nom du pack', '패키지 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (122, 'package_deatils', 'Package Deatils', 'Detail pack', '패키지 세부 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (123, 'package_amount', 'Package Amount', 'Montant pack', '패키지 금액');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (124, 'daily_roi', 'Daily ROI', 'ROI journalier', '일일 투자 수익');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (125, 'weekly_roi', 'Weekly ROI', 'ROI Hebdomadaire', '주간 투자 수익');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (126, 'monthly_roi', 'Monthly ROI', 'ROI Mensuel', '월별 ROI');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (127, 'yearly_roi', 'Yearly ROI', 'ROI annuel', '연간 투자수익');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (128, 'total_percent', 'Total Percent', 'Poucentage Total', '총 백분율');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (129, 'add_package', 'Add Package', 'Ajouter un Pack', '네트워크 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (130, 'edit_package', 'Edit Package', 'Editer Pack', '패키지 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (131, 'package_list', 'Package List', 'Liste Packs', '패키지 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (132, 'withdraw', 'Withdraw', 'Retraits', '철회하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (133, 'request', 'Request', 'Requête', '요구');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (134, 'success', 'Success', 'Succès ! ', '성공');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (135, 'request_date', 'Request Date', 'Date Requête', '요청 날짜');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (136, 'payment_method', 'Payment Method', 'Methode de paiement', '지불 방법');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (137, 'amount', 'Amount', 'Montant', '양');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (138, 'charge', 'Charge', 'Frais', '요금');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (139, 'total', 'Total', 'Total', '총');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (140, 'comments', 'Comments', 'Commentaires', '코멘트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (141, 'pending', 'Pending', 'En cours', '보류 중');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (142, 'cancel_date', 'Cancel Date', 'Annuler date', '취소 날짜');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (143, 'block_list', 'Block List', 'Liste Noire', '차단리스트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (144, 'commission', 'Commission', 'Commission', '수수료');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (145, 'setup', 'Setup', 'Regler', '설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (146, 'setup_list', 'Setup List', 'Liste de reglage', '설정 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (147, 'commission_list', 'Commission List', 'Liste Commission', '커미션 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (148, 'level_name', 'Level Name', 'Nom du stage', '레벨 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (149, 'personal_invest', 'Personal Invest', 'Mon investissement', '개인 투자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (150, 'total_invest', 'Total Invest', 'Total Investissement', '총 투자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (151, 'team_bonous', 'Team Bonous', 'Bonus d\'Equipe', '팀 보너스');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (152, 'referral_bonous', 'Referral Bonous', 'Bonus parrainage', '추천 보너스');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (154, 'form_submit_msg', 'Insert Successfully', 'Envoyer formulaire', '양식 제출 메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (155, 'transection_category', 'Transaction Category', 'Catégorie Transaction', '거래 카테고리');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (156, 'transfer_add_msg', 'Transfer Successfully', 'Ajouter SMS transfert', '전송 추가 메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (157, 'transfer', 'Transfer', 'Transfert', '옮기다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (158, 'diposit', 'Deposit', 'Depot', '보증금');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (159, 'add_deposit', 'Add Deposit', 'Effectuer un Depot', '보증금을 추가하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (160, 'deposit_list', 'Deposit List', 'Liste depot', '예금 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (161, 'team', 'Team', 'Equipe', '팀');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (162, 'investment', 'Investment', 'Investissement personnel', '투자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (163, 'notification', 'Notification', 'Notification', '공고');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (164, 'receiver_id', 'Receiver Id', 'ID Bénéficiaire', '수신기 ID');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (165, 'comment', 'Comments', 'Commentaire', '논평');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (166, 'otp_send_to', 'OTP Send To', 'OTP envoyer à', 'otp로 보내기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (167, 'transection', 'Transaction', 'Transactions', '거래');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (168, 'buy', 'Buy', 'Acheter', '구입');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (169, 'balance', 'Balance', 'Solde de compte', '균형');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (170, 'deposit_amount', 'Deposit Amount', 'Montant Depot', '입금 금액');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (171, 'deposit_method', 'Deposit Method', 'Methode depot', '입금 방법');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (172, 'deposit_wallet_id', 'Deposit Wallet Id', 'Wallet ID', '입금 지갑 아이디');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (174, 'confirm_transfer', 'Confirm Transfer', 'Confirmer transfert', '전송 확인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (175, 'transfer_amount', 'Transfer Amount', 'Montant Transfert', '송금액');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (176, 'enter_verify_code', 'Enter Verification Code', 'Entrer code de vérification', '인증 코드 입력');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (177, 'confirm', 'Confirm', 'Confirmer', '확인하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (178, 'deopsit_add_msg', 'Deposit Add Successfully.', 'Depot effectué avec succès', '입금 추가 메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (179, 'transfar_recite', 'Transfer Recite', 'Reçu de transfert', '거래 영수증');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (180, 'earn', 'Earn', 'Gagner', '벌다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (181, 'balance_is_unavailable', 'Balance Is not sufficient', 'Solde insuffisant', '잔액을 사용할 수 없습니다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (182, 'package_buy_successfully', 'Package Buy Successfully!', 'Achat du package reussi ! ', '패키지 구매 성공');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (184, 'withdraw_recite', 'Withdraw Recite', 'Reçu de retrait', '낭독을 철회하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (185, 'withdraw_confirm', 'withdraw Confirm', 'Confirmation Retrait', '철회 확인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (187, 'change_verify', 'Confirm Verify', 'Changer Verification', '비밀번호 변경');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (188, 'change_password', 'Password Change', 'Changer mot de passe', '비밀번호 변경');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (189, 'enter_confirm_password', 'Enter Confirm Password', 'Confirmer mot de passe', '비밀번호 확인 입력');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (190, 'enter_new_password', 'Enter New Password', 'Entrer nouveau mot de passe', '새로운 암호를 입력하세요');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (191, 'enter_old_password', 'Enter Old Password', 'Entrer ancien mot de passe', '이전 비밀번호 입력');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (192, 'change', 'Change', 'Changer', '변화');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (193, 'password_change_successfull', 'Password Change Successfully', 'Mot de passe changé avec succès', '비밀번호 변경 성공');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (194, 'old_password_is_wrong', 'Old Password Is Wrong', 'Entrer ancien mot de passe incorrect', '이전 비밀번호가 잘못되었습니다.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (195, 'fees_setting', 'Fees Setting', 'Reglages frais', '수수료 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (196, 'level', 'Level', 'Stage', '수준');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (197, 'select_level', 'Select Level', 'Selectionner stage', '레벨 선택');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (198, 'fees_setting_successfully', 'Fees Setting Successfully', 'Reglages Frais reussi', '수수료 설정 성공');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (199, 'bitcoin', 'Bitcoin', 'Bitcoin', '바이낸스 문서');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (200, 'payeer', 'Payeer', 'Payeer', '지불인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (201, 'name', 'Name', 'Nom', '이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (202, 'order_id', 'Order Id', 'ID de commande', '주문 아이디');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (203, 'fees', 'Fees', 'Frais', '수수료');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (204, 'period', 'Period', 'Période', '기간');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (205, 'commission_ret', 'Commission Ret', 'Commission ret', '커미션 렛');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (206, 'title', 'Title', 'Titre', '시간 제목');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (207, 'details', 'Details', 'Details', '세부');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (208, 'personal_info', 'Personal Information', 'Informations personnels', '개인적인 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (209, 'sponsor_info', 'Sponsor Information', 'Info Sponsor', '스폰서 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (210, 'affiliate_url', 'Affiliate Url', 'Lien parrainage', '제휴 URL');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (211, 'copy', 'Copy', 'Copier', '복사');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (212, 'my_payout', 'My Payout', 'Mes Paiements', '내 지불금');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (213, 'personal_sales', 'Personal Sales', 'Ventes Personnelles', '개인 판매');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (214, 'bank_details', 'Bank Details', 'Details de banque', '은행 계좌 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (215, 'beneficiary_name', 'Beneficiary Name', 'Nom Beneficiaire', '수취인 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (216, 'bank_name', 'Bank Name', 'Nom de banque', '은행 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (217, 'branch', 'Branch', 'Branche', '나뭇가지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (218, 'account_number', 'Account Number', 'Numéro de compte', '계좌 번호');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (219, 'ifsc_code', 'IFC Code', 'Code IFSC', 'SC 코드인 경우');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (220, 'account', 'Account', 'Compte', '계정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (221, 'my_commission', 'My Commission', 'Mes commissions', '내 커미션');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (222, 'finance', 'Finance', 'Finance', '재원');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (223, 'exchange', 'Exchange', 'Echange', '교환');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (224, 'bitcoin_setting', 'Bitcoin Setting', 'Reglages bitcoin', '비트코인 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (225, 'payeer_setting', 'Payeer Setting', 'Reglages Payeer', '지급인 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (226, 'bank_information', 'Bank Information', 'Infos de banque', '은행 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (227, 'bitcoin_wallet_id', 'Bitcoin Wallet ID', 'Wallet Bitcoin', '비트코인 지갑 아이디');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (228, 'payment_method_setting', 'Payment Method Setting', 'Reglage methode de paiement', '결제 수단 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (229, 'payeer_wallet_id', 'Payeer Wallet Id', 'ID Payeer', '지급인 지갑 ID');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (230, 'my_package', 'My Package', 'Mes packs', '내 패키지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (231, 'my_team', 'My Team', 'Mon Equipe', '내 팀');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (232, 'receipt', 'Receipt', 'Réçu', '영수증');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (233, 'withdraw_successfull', 'Withdraw Successfully', 'Retrait reussi !', '성공적으로 철회');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (234, 'team_bonus', 'Team Bonus', 'Bonus d\'Equipe', '팀 보너스');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (235, 'withdraw_list', 'Withdraw List', 'Liste retraits', '철회 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (236, 'pending_withdraw', 'Pending Withdraw', 'Demande de retrat en cours', '보류중인 철회');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (237, 'reciver_account', 'Receiver Account', 'Compte Bénéficiaire', '받은 금액');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (238, 'french', 'French', 'Français', '프랑스 국민');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (239, 'commission_setup', 'Comission Setup', 'Reglage comission', '수수료 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (240, 'personal_investment', 'Personal Investment', 'Investissement personnel', '개인 투자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (241, 'total_investment', 'Total investment', 'Total Investissement', '총 투자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (242, 'transfer_list', 'Transfer List', 'Liste transfert', '번역 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (243, 'form_to', 'From To', '', '형태');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (244, 'receive', 'Receive', '', '받았다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (245, 'wallet_id', 'Wallet Id', 'ID Wallet', '지갑 아이디');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (246, 'withdraw_details', 'Withdraw Details', 'Details retraits', '세부 정보를 철회');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (247, 'generation_one', 'Generation One', 'Génération 1', '1세대');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (248, 'generation_two', 'Generation Two', 'Génération 2', '2세대');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (249, 'generation_three', 'Generation Three', 'Génération 3', '3세대');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (250, 'generation_four', 'Generation Four', 'Génération 4', '4세대');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (251, 'generation_five', 'Generation Five', 'Génération 5', '5세대');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (252, 'generation_empty_message', 'You Have No Generation', '', '생성 빈 메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (253, 'view', 'View', 'Aperçu', '보다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (254, 'cancle', 'Cancel', 'Annuler', '취소');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (255, 'type', 'Type', 'Type', '유형');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (256, 'your_total_balance_is', 'Your Total Balance Is', 'Votre montant total est de', '귀하의 총 잔액은');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (257, 'bonus', 'Bonus', 'Bonus', '부우스');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (258, 'personal_turnover', 'Sponsor Turnover', 'Chiffre d\'affaires sponsor', '개인 회전율');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (259, 'team_turnover', 'Team Turnover', 'Chiffre d\'affaire Equipe', '팀 회전율');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (260, 'post_article', 'Post Article', '', '기사를 게시하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (261, 'article_list', 'Article List', 'LIste article', '기사 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (262, 'add_article', 'Add Article', 'Ajouter article', '기사 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (263, 'headline_en', 'Headline English', 'Titre EN', '헤드라인 영어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (264, 'headline_fr', 'Headline French', 'Titre  FR', '제목 프랑스어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (265, 'article_en', 'Article English', 'Article EN', '기사 영어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (266, 'article_fr', 'Article French', 'Article FR', '기사 프랑스');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (267, 'edit_article', 'edit Article', 'Editer article', '기사를 편집하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (268, 'cat_list', 'Category List', 'Liste panier', '카테고리 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (269, 'add_cat', 'Add Category', 'Ajouter au panier', '카테고리 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (270, 'parent_cat', 'Parent Category', '', '상위 카테고리');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (271, 'cat_name_en', 'Category Name English', 'Nom panier EN', '카테고리 이름 영어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (272, 'cat_name_fr', 'Category Name French', 'Nom panier FR', '카테고리 이름 신선한');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (273, 'cat_title_en', 'Category Title English', 'Titre Panier EN', '카테고리 제목 영어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (274, 'cat_title_fr', 'Category Title French', 'Titre panier FR', '카테고리 제목 프랑스어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (275, 'select_cat', 'Select Category', 'Selectionner Cat', '카테고리 선택');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (276, 'edit_cat', 'Edit Category', 'Editer Panier', '고양이 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (277, 'position_serial', 'Position Serial', '', '직위 직렬');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (278, 'currency_list', 'Currency List', 'Liste de devise', '통화 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (279, 'currency', 'Currency', 'Devise', '통화');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (280, 'cryptocurrency_name', 'CryptoCurrency  Name', 'Nom Crypto monnaie', '암호화폐 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (281, 'select_cryptocurrency', 'Select Cryptocurrency', 'Selectionner Crypto', '암호화폐 선택');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (282, 'edit_currency', 'Edit Currency', 'Editer Devise', '통화 수정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (283, 'exchange_list', 'Exchange List', 'Liste échanges', '모든 요청 교환');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (284, 'add_exchange', 'Add Exchange', 'Ajouter Echange', '교환 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (285, 'edit_exchange', 'Edit Exchange', 'Editer Echange', '교환 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (286, 'wallet_data', 'Wallet ID', 'Données Wallet', '지갑 데이터');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (287, 'sell_adjustment', 'Sell Adjustment', 'Ajustement Vente', '조정 판매');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (288, 'buy_adjustment', 'Buy Adjustment', '', '조정 구매');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (289, 'exchange_wallet', 'Exchange Wallet', 'Wallet Echange', '지갑을 교환하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (290, 'exchange_wallet_list', 'Exchange Wallet List', 'Liste Wallet echange', '교환 지갑 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (291, 'add_exchange_wallet', 'Add Exchange Wallet', 'Ajouter Wallet', '교환 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (292, 'edit_exchange_wallet', 'Edit Exchange Wallet', 'Modifier Wallet echange', '거래소 지갑 수정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (293, 'local_currency_list', 'Local Currency List', 'LIste  Monnaies locales', '현지 통화 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (294, 'local_currency', 'Local Currency', 'Devise Locale', '현지 통화로');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (295, 'add_local_currency', 'Add Local Currency', 'Ajouter Monnaie', '현지 통화 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (296, 'edit_local_currency', 'Edit Local Currency', 'Editer Devise locale', '현지 통화 수정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (297, 'currency_name', 'Currency Name', 'Nom devise', '통화 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (298, 'currency_iso_code', 'Currency ISO Code', 'Code ISO devise ', '통화 ISO 코드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (299, 'usd_exchange_rate', 'USD Exchange Rate', 'Taux d\'echange USD', 'USD 환율');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (300, 'currency_symbol', 'Currency Symbol', 'Symboles Devise', '통화 기호');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (301, 'symbol_position', 'Symbol Position', 'Position symbole', '기호 위치');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (302, 'currency_position', 'Currency Position', 'Position devise', '통화 위치');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (303, 'payment_gateway', 'Payment Gateway', 'Portail de paiement', '지불 게이트웨이');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (304, 'gateway_name', 'Gateway Name', 'Nom passerelle', '게이트웨이 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (305, 'gateway_setting', 'Gateway Setting', 'Reglage portail', '게이트웨이 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (306, 'add_payment_gateway', 'Add Payment Gateway', 'Ajouter Methode paiment', '지불 게이트웨이 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (307, 'public_key', 'Public Key', 'Clé publique', '공개 키');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (308, 'private_key', 'Private Key', '', '개인 키');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (309, 'shop_id', 'Shop ID', 'ID shop', '가게 아이디');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (310, 'secret_key', 'Secret Key', 'Clé secrete', '비밀 키');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (311, 'edit_payment_gateway', 'Edit Payment Gateway', 'Editer Methode de paiement', '결제 게이트웨이 수정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (312, 'slider_list', 'Slider List', '', '슬라이더 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (313, 'add_slider', 'Add Slider', 'Ajouter Slider', '슬라이더 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (314, 'headline', 'Headline', 'Titre', '표제');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (315, 'edit_slider', 'Edit Slider', '', '슬라이더 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (316, 'social_app', 'Social App', 'Social App', '소셜 앱');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (317, 'edit_social_app', 'Edit Social App', 'Editer RS appli', '소셜 앱 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (318, 'social_link', 'Social Link', 'Social Link', '소셜 링크');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (319, 'add_link', 'Add Link', 'Ajouter Lien', '링크 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (320, 'link', 'Link', 'Lien', '링크');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (321, 'icon', 'Icon', 'Icône', '상');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (322, 'edit_social_link', 'Edit Social Link', 'Edit les liens RS', '소셜 링크 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (323, 'transection_info', 'Transection Info', 'Info transaction', '거래 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (324, 'sell', 'Sell', 'Vendre', '팔다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (325, 'article', 'Article', 'Article', '기사');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (326, 'coin_amount', 'Coin Amount', 'Montat Crypto', '동전 금액');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (327, 'coin_name', 'Coin Name', 'Nom Crypto', '동전 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (328, 'buy_amount', 'Buy Amount', 'Montant achat', '구매 금액');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (329, 'sell_amount', 'Sell Amount', 'Montant à vendre', '판매 금액');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (330, 'wallet_data', 'Wallet ID', 'Données Wallet', '지갑 데이터');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (331, 'usd_amount', 'USD Amount', 'Montant USD', 'USD 금액');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (332, 'rate_coin', 'Coin Rate', 'Taux coin', '평가 동전');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (333, 'local_amount', 'Local Amount', 'Montant Local', '현지 금액');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (334, 'om_name', 'OM Name', 'Nom OM', '옴 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (335, 'om_mobile_no', 'OM Phone No', 'N° OM', '옴 모바일 아니');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (336, 'transaction_no', 'Transaction No', 'N° de transaction', '거래 없음');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (337, 'idcard_no', 'ID Card No', 'N° CNI', '아이디 카드 아니요');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (338, 'buy_list', 'Buy List', 'Buy list', '구매 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (339, 'add_buy', 'Add Buy', 'Ajouter Achat', '추가 구매');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (340, 'transection_type', 'Transection Type', 'Type de transaction', '거래 유형');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (341, 'payment_successfully', 'Payment Successfully', 'Paiement effectué', '성공적으로 지불');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (342, 'payment_cancel', 'Payment Cancel', 'Paiement annulé', '결제 취소');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (343, 'payment_successfully', 'Payment Successfully', 'Paiement effectué', '성공적으로 지불');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (344, 'sell_list', 'Sell List', 'LIste de vente ', '판매 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (345, 'add_sell', 'Add Sell', 'Ajouter Vente', '추가 판매');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (346, 'edit_sell', 'Edit Sell', '', '편집 판매');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (347, 'account_active_mail', 'Please check Email to activate your account', 'Activer votre mail', ' 계정 활성 메일');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (348, 'accept_terms_privacy', 'Crypto Privacy policy and Terms of Use', 'Accepter conditions et termes', '약관 개인 ​​정보 보호에 동의');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (349, 'username_used', 'Username Already Used', 'Nom d\'utilisateur déjà utilisé', '사용된 사용자 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (350, 'account_create_success_social', 'Account Created Successfully and Your Account activated', 'Compte crée avec succès', '계정 만들기 성공 소셜');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (351, 'email_used', 'Email Already Used', 'Adresse mail déjà utilisé', '이메일 SMS 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (352, 'account_create_active_link', 'Account Created Successfully. Activation link send your Email address', 'Lien d\'activation', '계정 생성 활성 링크');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (353, 'active_account', 'Active Account', 'Compte actif', '활성 계정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (354, 'wrong_try_activation', 'Wrong Try', 'Mauvaise activation', '잘못된 시도 활성화');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (355, 'pay_now', 'Pay Now', 'Payer maintenant', '지금 지불하세요');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (356, 'payment_successfully', 'Payment Successfully', 'Paiement effectué', '성공적으로 지불');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (357, 'sell_successfully', 'Sell Successfully', 'Vente effectuée avec succès', '성공적으로 판매');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (358, 'already_clicked', 'Already Clicked There', 'Déja Validé', '이미 클릭');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (359, 'user_info', 'User Info', 'info utilisateur', '사용자 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (361, 'registered_ip', 'Registered IP', '', '등록 IP');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (362, 'requested_ip', 'Requested IP', '', '요청한 IP');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (363, 'transaction_status', 'Transaction Status', 'Status de la transaction', '거래 상태');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (364, 'receive_status', 'receive_status', '', '수신 상태');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (365, 'receive_complete', 'Receive Complete', '', '수신기 완료');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (366, 'payment_status', 'Payment Status', 'Status de paiement', '지불 상태');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (367, 'payment_complete', 'Payment Complete', 'Paiement complet', '결제 완료');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (368, 'url', 'URL', 'url', 'URL');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (369, 'app_id', 'App ID', 'ID appli', '앱 아이디');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (370, 'app_secret', 'App Secret', 'Secret Appli', '앱 비밀');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (371, 'api_key', 'API Key', 'Clé API', '에이키');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (372, 'app_name', 'App Name', 'Nom Appli', '앱 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (373, 'social_list', 'Social List', 'Social List', '소셜 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (374, 'select_payment_method', 'Select Payment Method', 'Selectionner mode de paiement', '지불 방법 선택');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (375, 'payable', 'Payable', '', '지불 가능한');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (376, 'rate', 'Rate', 'Taux', '비율');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (377, 'how_do_you_receive_money', 'How do you receive money', 'Comment Reçevoir votre argent', '돈은 어떻게 받나요');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (378, 'withdraw_method', 'Withdraw Method', 'Methode de retrait', '철회 방법');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (379, 'select_withdraw_method', 'Select Withdraw Method', 'Selectionner méthode de retrait', '인출 방법 선택');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (380, 'account_info', 'Account Info', 'Info compte', '계정 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (381, 'upload_docunemts', 'Upload Docunemts', 'Ajouter fichier', '문서 업로드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (382, 'my_generation', 'My Generation', 'Mon Equipe', '내 세대');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (383, 'category', 'Category', 'Catégorie', '범주');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (384, 'slider_h1_en', 'Slider H1 English', '', '슬라이더 h1 영어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (385, 'slider_h1_fr', 'Slider H1 French', '', '슬라이더 h1 프랑스어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (386, 'slider_h2_en', 'Slider H2 English', '', '슬라이더 h2 영어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (387, 'slider_h2_fr', 'Slider H2 French', '', '슬라이더 h2 프랑스어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (388, 'slider_h3_en', 'Slider H3 English', '', '슬라이더 h3 영어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (389, 'slider_h3_fr', 'Slider H3 French', '', '슬라이더 h3 프랑스어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (390, 'complete', 'Complete', 'Complet', '완벽한');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (391, 'refresh_currency', 'Refresh Currency', '', '통화 새로 고침');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (392, 'cryptocurrency', 'Crypto Currency', 'Crypto Monnaie', '암호화폐');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (393, 'symbol', 'Symbol', 'Symbole', '상징');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (394, 'please_select_cryptocurrency_first', 'Please Select CryptoCurrency First', 'Veuillez choisir une crypto monnaie', '먼저 암호 화폐를 선택하십시오');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (395, 'please_select_diffrent_payment_method', 'Please select Diffrent Payment Method', 'Selectionner une autre méthode de paiement', '다른 지불 방법을 선택하십시오');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (396, 'add_credit', 'Add Credit', 'Crediter Compte', '신용 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (397, 'credit', 'Credit', 'Crédit', '신용 거래');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (398, 'credit_list', 'Credit List', 'Liste de Credit', '신용 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (399, 'notes', 'Note', 'Notes', '메모');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (400, 'my_level_info', 'My Level Info', 'Info Niveau', '내 레벨 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (401, 'slider', 'Slider', 'Slider', '슬라이더');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (402, 'exchange_setting', 'Exchange Setting', 'Reglage Echange', '교환 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (403, 'exchange_all_request', 'Exchange all Request', 'Toutes requêtes echanges', '모든 요청 교환');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (404, 'total_user', 'Total User', 'Nombre d\'utilisateurs', '총 사용자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (405, 'total_roi', 'Total ROI', 'Total ROI', '총 투자수익');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (406, 'total_commission', 'Total Commission', 'Total commission', '총 수수료');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (407, 'download_pdf', 'Download PDF', 'Télécharger ', 'PDF 다운로드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (408, 'view_all_news', 'View all news', 'Aperçu News', '모든 뉴스 보기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (409, 'download_company_brochure', 'Download Company Brochure', 'Téléchargez notre brochure', '회사 브로셔 다운로드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (410, 'get_in_touch', 'Get in touch', 'Contactez-nous', '연락하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (411, 'read_more', 'Read More', 'Lire plus', '더 읽기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (412, 'know_more', 'Know more', 'Savoir plus', '더 알고');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (413, 'choose_plan', 'Choose plan', 'acheter', '계획을 선택');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (414, 'latest_jobs', 'Latest Jobs', 'Latest Jobs', '최신 작업');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (415, 'website', 'Website', 'website', '웹사이트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (416, 'chose_one_of_the_following_methods', 'Chose One of the Following Methods.', 'chose_one_of_the_following_methods.', '다음 방법 중 하나를 선택');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (417, 'sign_in_using_your_email_address', 'Sign in Using Your Email Address', 'Connectez-vous avec votre username ou email', '이메일 주소를 사용하여 로그인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (418, 'forgot_password', 'Forgot Password', 'Forgot Password', '바닥글 텍스트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (419, 'remember_me', 'Remember me', 'Remember me', '날 기억해');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (420, 'username_or_email', 'Username or email', 'Username or email', '아이디 또는 이메일');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (421, 'dont_have_an_account', 'Don\'t have an account', 'Don\'t have an account', '계정이 없다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (422, 'sign_up_now', 'Sign up Now', 'Créer un compte maintenant', '지금 등록하세요');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (423, 'send_code', 'Send Code', 'Send Code', '코드 보내기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (424, 'sign_up', 'Sign Up', 'Créer un compte', '가입하기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (425, 'already_user', 'Already User', 'Already User', '이미 사용자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (426, 'sign_in_now', 'Sign In Now', 'Connectez-vous maintenant', '지금 로그인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (427, 'sign_up_for_free', 'Sign Up For Free', 'Créer un compte gratuitement', '무료 가입');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (428, 'join_thousands_of_companies_that_Use_globalcrypt_every_day', 'Join Thousands of Companies that Use Global Crypto Every Day', 'Join Thousands of Companies that Use Global Crypto Every Day', '매일 globalcrypt를 사용하는 수천 개의 회사에 합류하십시오.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (429, 'your_password_at_global_crypto_are_encrypted_and_secured', 'Your Password at Global Crypto are encrypted and Secured', 'Votre mot de passe Global Crypto est crypté et securisé', '글로벌 크립토의 비밀번호는 암호화되어 안전합니다.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (430, 'email_username_used', 'Email/Username Already Used', 'Email/Username Already Used', '이메일 사용자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (431, 'address', 'Address', 'Address', '주소');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (432, 'phone', 'Phone', 'Phone', '핸드폰');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (433, 'admin_align', 'Admin Align', 'Admin Align', '사용자 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (434, 'office_time', 'Office Time', 'Office Time', '사무실 시간');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (435, 'logo_web', 'WebSite Logo', 'WebSite Logo', '로고 웹');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (436, 'dashboard_logo', 'Dashboard Logo', 'Dashboard Logo', '대시보드 로고');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (437, 'advertisement', 'Advertisement', 'Advertisement', '광고');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (438, 'script', 'Script', 'Script', '스크립트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (439, 'add_advertisement', 'Add Advertisement', 'Add Advertisement', '광고를 추가하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (440, 'page', 'Page', 'Page', '페이지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (441, 'embed_code', 'Embed code', 'Embed code', '사용된 이메일 사용자 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (442, 'add_type', 'Add Type', 'Add Type', '유형 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (443, 'edit_advertisement', 'Edit Advertisement', 'Edit Advertisement', '광고 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (444, 'host', 'Host', 'Host', '주최자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (445, 'port', 'Port', 'Port', '포트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (446, 'apikey', 'API Key', 'API Key', '에이키');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (447, 'mail_type', 'Mail Type', 'Mail Type', '마이 타입');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (448, 'charset', 'Charset', 'Charset', '문자 집합');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (449, 'news', 'News', 'News', '소식');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (450, 'news_list', 'News List', 'News List', '뉴스 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (451, 'edit_news', 'Edit News', 'Edit News', '뉴스 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (452, 'post_news', 'Post News', 'Post News', '뉴스를 게시하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (453, 'close', 'Close', 'Close', '닫다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (454, 'contact_us', 'Contact Us', 'Contact Us', '문의하기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (455, 'watch_video', 'WATCH VIDEO', 'WATCH VIDEO', '지갑 비디오');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (456, 'about_bitcoin', 'About Bitcoin', 'About Bitcoin', '비트코인에 대해');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (457, 'get_start', 'Get Start', 'Get Start', '시작하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (458, 'cryptocoins', 'Crypto Coins', 'Crypto Coins', '암호화폐');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (459, 'subscribe_to_our_newsletter', 'Subscribe to our newsletter!', 'Subscribe to our newsletter!', '뉴스레터 구독');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (460, 'email_newslatter', 'Email Newslatter', 'Email Newslatter', '이메일 뉴스레터');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (461, 'services', 'Services', 'Services', '서비스');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (462, 'our_company', 'Our Company', 'Our Company', '우리 회사');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (463, 'sign_in', 'Sign In', 'Connectez-vous', '로그인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (464, 'join_the_new_yera_of_cryptocurrency_exchange', 'Join the new Yera of cryptocurrency exchange', 'Join the new Yera of cryptocurrency exchange', '암호화폐 거래소의 새해를 맞이하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (465, 'access_the_cryptocurrency_experience_you_deserve', 'Access the cryptocurrency experience you deserve', 'Access the cryptocurrency experience you deserve', '가치 있는 암호화폐 경험에 액세스');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (466, 'home', 'Home', 'Home', '집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (467, 'scroll_to_top', 'Scroll to Top', 'Scroll to Top', '맨위로 스크롤');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (468, 'ticker', 'Ticker', 'Ticker', '증권 시세 표시기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (469, 'price', 'Price', 'Price', '가격');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (470, 'capitalization', 'Capitalization', 'Capitalization', '자본화');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (471, '1d_change', 'English  Names', 'French ', ' 1일 변경');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (472, 'graph_24h', 'Graph 24H', 'Graph 24H', '그래프 24시간');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (473, 'recent_post', 'Recent Post', 'Recent Post', '최근 게시물');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (474, 'my_social_link', 'My Social link', 'My Social link', '내 소셜 링크');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (475, 'tell_us_about_your_project', 'Tell Us About Your Project', 'Tell Us About Your Project', '프로젝트에 대해 알려주세요');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (476, 'company', 'Company', 'Company', '회사');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (477, 'reset_your_password', 'Reset Your Password', 'Reset Your Password', '비밀번호를 재설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (478, '24h_change', '24H change', '24H change', '24시간 변경');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (479, '24h_volume', '24H Volume', '24H Volume', '24시간 볼륨');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (480, 'latitudelongitude', 'Latitude, Longitude', 'Latitude, Longitude', '위도 경도');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (481, 'send_money', 'Send Money', 'Send Money', '돈을 보내다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (483, 'contact', 'Contact', 'contact', '연락하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (484, 'team', 'Team', 'team', '팀');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (485, 'client', 'Client', 'client', '고객');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (486, 'service', 'Service', 'service', '서비스');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (487, 'testimonial', 'Testimonial', 'testimonial', '증명서');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (488, 'faq', 'FAQ', 'faq', '자주하는 질문');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (489, 'short_description_en', 'Short description english', 'Short Description', '짧은 설명 영어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (490, 'long_description_en', 'Long description English', 'Long Description', '긴 설명 영어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (491, 'short_description_fr', 'Short description english', 'Short Description', '짧은 설명 프랑스어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (492, 'long_description_fr', 'Long description English', 'Long Description', '긴 설명 프랑스어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (493, 'info', 'Information', 'Information', '정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (494, 'quote', 'Quote', 'Quote', '인용하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (495, 'question_fr', 'Question French', 'Question French', '질문 프랑스어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (496, 'question_en', 'Question English', 'Question English', '질문 영어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (497, 'answer_en', 'Answer English', 'Answer English', '프랑스어로 대답하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (498, 'answer_fr', 'Answer French', 'Answer French', '프랑스어로 대답하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (499, 'content', 'Content', 'Content', '문의하기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (500, 'add_content', 'Add Content', 'Add Content', '콘텐츠 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (501, 'edit_content', 'Edit Content', 'Edit Content', '연락처 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (502, 'video', 'video (If Youtube Link)', 'video', '동영상');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (503, 'add_faq', 'Add F.A.Q', 'Add faq', '자주 묻는 질문 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (504, 'add_testimonial', 'Add Testimonial', 'Add testimonial', '평가를 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (505, 'add_service', 'Add Service', 'Add service', '서비스 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (506, 'add_client', 'Add Client', 'Add client', '카테고리 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (507, 'add_team', 'Add Team', 'Add team', '팀 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (508, 'add_contact', 'Add Contact', 'Add contact', '카테고리 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (510, 'edit_article', 'edit Article', 'edit article', '기사를 편집하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (511, 'edit_contact', 'Edit Contact', 'Edit Contact', '연락처 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (512, 'edit_team', 'edit Team', 'edit team', '팀 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (513, 'edit_client', 'Edit Client', 'Edit client', '클라이언트 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (514, 'edit_service', 'edit Service', 'edit service', '편집 서비스');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (515, 'edit_testimonial', 'edit Testimonial', 'edit testimonial', '평가를 편집하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (516, 'edit_faq', 'edit F.A.Q', 'edit faq', '자주하는 질문 수정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (517, 'article_list', 'Article List', 'article', '기사 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (518, 'contact_list', 'Contact List', 'contact', '연락처 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (519, 'team_list', 'Team List', 'team', '팀 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (520, 'client_list', 'Client List', 'client', '클라이언트 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (521, 'service_list', 'Service List', 'service', '서비스 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (522, 'testimonial_list', 'Testimonial List', 'testimonial', '평가 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (523, 'faq_list', 'F.A.Q List', 'faq', '자주 묻는 질문 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (524, 'content_list', 'Page Content', 'Page Content', '콘텐츠 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (525, 'add_teammember', 'Add Teammember', 'Add Teammember', '팀원 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (526, 'tooltip_package_name', 'Example: Silver Package', 'Example: Silver Package', '툴팁 패키지 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (527, 'tooltip_package_details', 'This is for Package Short Details', 'This is for Package Short Details.', '툴팁 패키지 세부 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (528, 'tooltip_package_amount', 'Package Amount in Dollar. Example: 200', 'Package Amount in Dollar. Example: 200', '툴팁 패키지 금액');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (529, 'tooltip_package_daily_roi', 'Please Set this field with Zero. Example: 0', 'Please Set this field with Zero. Example: 0', '툴팁 패키지 일일 ROI');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (530, 'tooltip_package_weekly_roi', 'Who buy this package they will get weekly ROI in Dollar. Example: 5. They will get every week 5 till them package period', 'Who buy this package they will get weekly ROI in Dollar. Example: 5. They will get every week 5 till them package period', '툴팁 패키지 주간 ROI');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (531, 'tooltip_package_monthly_roi', 'Sum of weekly ROI in a month', 'Sum of weekly ROI in a month', '툴팁 패키지 월별 ROI');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (532, 'tooltip_package_yearly_roi', 'Sum of weekly ROI in a Year', 'Sum of weekly ROI in a Year', '툴팁 패키지 연간 ROI');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (533, 'tooltip_package_total_percent_roi', 'Total Persent Of ROI', 'Total Persent Of ROI', '툴팁 패키지 총 투자수익(%)');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (534, 'tooltip_package_period', 'Package Period', 'Package Period', '툴팁 패키지 기간');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (535, 'flag', 'Flag', 'Flag', '깃발');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (536, 'code', 'Code', 'Code', '암호');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (537, 'for_flag_use_country_code_bellow_table', 'For flag icon, country code below', 'For flag icon, country code below', '국기 사용 국가 코드는 아래 표');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (538, 'update_website_language', 'Update Website Language', 'Update Website Language', '웹사이트 언어 업데이트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (539, 'description', 'Description', 'Description', '설명');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (540, 'short_description', 'Short Description', 'Short Description', '간단한 설명');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (541, 'long_description', 'Long Description', 'Long Description', '긴 설명');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (542, 'question', 'Question', 'Question', '의문');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (543, 'answer', 'Answer', 'Answer', '대답');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (544, 'cat_name', 'Category Name', 'Category Name', '카테고리 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (545, 'cat_title', 'Category Title', 'Category Title', '카테고리 제목');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (546, 'slider_h1', 'Slider H1', 'Slider H1', '슬라이더 h1');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (547, 'slider_h2', 'Slider H2', 'Slider H2', '슬라이더 h2');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (548, 'slider_h3', 'Slider H3', 'Slider H3', '슬라이더 h3');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (549, 'deposit', 'Deposit', 'Depot', '보증금');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (550, 'pending_deposit', 'Pending Deposit', 'Dépôt en attente', '보류 중인 예금');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (551, 'email_and_sms_setting', 'Email And Sms Setting', 'Email And Sms Setting', '이메일 및 SMS 게이트웨이');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (552, 'email_and_sms_gateway', 'Email And Sms Gateway', 'Email And Sms Gateway', '이메일 및 SMS 게이트웨이');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (553, 'client_id', 'Client ID', NULL, '클라이언트 ID');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (554, 'client_secret', 'Client Secret', NULL, '클라이언트 비밀');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (555, 'page_content', 'Page Content', 'Page Content', '페이지 내용');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (557, 'contact_info', 'Contact Information', 'Informations de contact', '연락처 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (558, 'contact_info', 'Contact Information', 'Informations de contact', '연락처 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (559, 'client_info', 'Client Information', 'Information client', '클라이언트 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (560, 'client_info', 'Client Information', 'Information client', '클라이언트 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (561, 'list', 'LIST', 'LIST', '목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (562, 'list', 'LIST', 'LIST', '목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (563, 'advertisement_list', 'Advertisement List', 'Advertisement List', '광고 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (564, 'advertisement_list', 'Advertisement List', 'Advertisement List', '광고 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (565, 'web_language', 'Web Language', 'langage web', '웹 언어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (566, 'web_language', 'Web Language', 'langage web', '웹 언어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (567, 'admin_information', 'Admin Information', 'Admin Information', '관리자 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (569, 'email_sms_setting', 'Email and SMS Setting', 'Email and SMS Setting', '이메일 SMS 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (570, 'email_sms_setting', 'Email and SMS Setting', 'Email and SMS Setting', '이메일 SMS 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (571, 'externalapi', 'External Api', 'External Api', '외부 API');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (573, 'external_api_setup', 'External Api Setup', 'External Api Setup', '외부 API 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (574, 'new', NULL, NULL, '새로운');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (575, 'phrase_list', NULL, NULL, '구문 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (576, 'home_page', 'Home Page', 'Page d\'accueil', '홈페이지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (577, 'home_page', 'Home Page', 'Page d\'accueil', '홈페이지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (578, 'package_info', 'Package Info', 'Informations sur le paquet', '패키지 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (579, 'language_list', 'Language List', 'Liste des langues', '언어 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (580, 'Customer', 'Customer', 'Client', '고객');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (581, 'payout_receipt', 'Payout Receipt', 'Reçu de paiement', '지불 영수증');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (582, 'commission_receipt', 'Commission Receipt', 'Réception de la Commission', '수수료 영수증');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (583, 'mylevel_info', 'My Level Info', 'Mon Niveau Info', '마이레벨 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (584, 'send_details', 'Send Details', 'envoyer les détails', '세부 정보를 보내');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (585, 'receive_details', 'Receive Details', 'Recevoir les détails', '세부 사항을 수신');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (586, 'withdraw_money', 'Withdraw Money', 'retirer de l\'argent', '돈을 인출');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (587, 'payment_process', 'Payment Process', 'Processus de paiement', '지불 과정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (588, 'show_list', 'Show List', 'afficher la liste', '쇼 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (589, 'confirm_package', 'Confirm Package', 'Confirmer le paquet', '패키지 확인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (590, 'buy_success', 'Buy Success', 'Achetez Success', '구매 성공');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (591, 'payment_form', 'Payment Form', 'Formulaire de paiement', '지불 양식');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (592, 'buy_form', 'Buy Crypto', 'Acheter Crypto', '구매 양식');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (593, 'settings', 'Settings', 'Settings', '설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (594, 'a_lowercase_letter', 'A lowercase', 'Une minuscule', '소문자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (595, 'a_capital_uppercase_letter', 'A Capital Uppercase', 'Une majuscule majuscule', '대문자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (596, 'a_special', 'A Special Character', 'Un personnage spécial', '특별한');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (597, 'a_number', 'A Number', 'Un numéro', '숫자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (598, 'minimum_8_characters', 'Minimum 8 Characters', 'Minimum 8 caractères', '최소 8자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (599, 'login_or_register', 'Login/Register', 'S\'identifier S\'enregistrer', '로그인 또는 등록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (600, 'currency_info', 'Currency Info', 'Currency Info', '통화 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (601, 'exchangewallet_info', 'Exchange Wallet Info', 'Exchange Wallet Info', '지갑 정보 교환');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (602, 'profile_info', 'Profile Info', 'Profile Info', '프로필 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (603, 'reset_password', 'Reset Password', 'réinitialiser le mot de passe', '암호를 재설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (604, 'new_password', 'New Password', 'nouveau mot de passe', '새 비밀번호');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (605, 'auto_update', 'Auto Update', 'Mise à jour automatique', '자동 업데이트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (606, 'backend', 'Backend', 'Backend', '백엔드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (607, 'credit_details', 'Credit Details', 'Détails du crédit', '신용 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (608, 'select_country', 'Select Country', 'Choisissez le pays', '국가를 선택');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (609, 'review', 'Review', 'Review', '검토');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (610, 'borrow', 'Borrow', 'Emprunter', '빌리다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (611, 'b2x', 'b2x', 'b2x\r\n', 'b2x');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (612, 'Image_1', 'Image 1', 'Image 1', '이미지 1');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (613, 'Image_2', 'Image 2', 'Image 2', '이미지 2');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (614, 'Image_2', 'Image 2', 'Image 2', '이미지 2');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (615, 'Image_3', 'Image 3', 'Image 3', '이미지 3');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (616, 'Image_4', 'Image 4', 'Image 4', '이미지 4');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (617, 'Image_5', 'Image 5', 'Image 5', '이미지 5');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (618, 'Image_6', 'Image 6', 'Image 6', '이미지 6');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (619, 'gallery', 'Gallery', 'Gallery', '갤러리');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (620, 'security', 'Security', 'Sécurité', '보안');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (621, 'privacy', 'Privacy', 'Privacy', '은둔');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (622, 'add_privacy', 'Add Privacy', 'Add Privacy', '지불 게이트웨이 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (623, 'verified', 'Verified', 'Verified', '확인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (624, 'not_verified', 'Not Verified', 'Non vérifié', '확인되지 않음');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (625, 'given_name', 'Given Name', 'prénom', '주어진 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (626, 'passport', 'passport', 'passport', '비밀번호');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (627, 'drivers_license', 'drivers_license', NULL, '운전 면허증');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (628, 'government_issued_id_card', 'Government Issued Id Card', 'Government Issued Id Card', 'government_issued_id_card');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (629, 'surname', 'Surname', 'Surname', '성');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (630, 'verify_type', 'Verify Type', 'Verify Type', '유형 확인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (631, 'passport_nid_license_number', 'Passport Nid License Number', 'Passport Nid License Number', '비밀번호 id 라이센스 번호');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (632, 'gender', 'Gender', 'Gender', '성별');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (633, 'male', 'Male', 'Male', '남성');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (634, 'female', 'Female', 'Female', '여자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (635, 'verify_user', 'Verify User', 'Vérifier l\'utilisateur', '사용자 확인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (636, 'add_module', 'Add Module', 'Ajouter un module', '모듈 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (637, 'add_theme', 'Add Theme', 'Ajouter un thème', '테마 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (638, 'module', 'Module', 'Module', '기준 치수');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (639, 'purchase_key', 'Purchase Key', 'Purchase Key', '구매 키');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (640, 'theme_name', 'Theme Name', 'Theme Name', '테마 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (641, 'upload', 'Upload', 'Upload', '업로드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (642, 'invalid_purchase_key', 'Invalid Purchase Key', 'Invalid Purchase Key', '잘못된 구매 키');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (643, 'theme_active_successfully', 'Theme Active Successfully', 'Thème actif avec succès', '테마 활성화 성공');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (644, 'there_was_a_problem_with_the_upload', 'There Was a Problem With The Upload', 'Il y a eu un problème avec le téléchargement', '업로드에 문제가 있는 테마');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (645, 'invalid_file_format', 'Invalid File Format', 'Format de fichier non valide', '잘못된 파일 형식');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (646, 'buy_now', 'Buy Now', 'Buy Now', '지금 구매');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (647, 'overwrite', 'Overwrite', 'Overwrite', '덮어쓰다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (648, 'download', 'Download', 'Download', '다운로드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (649, 'install', 'Install', 'Install', '설치');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (650, 'module_added_successfully', 'Module Added Successfully', 'Module Added Successfully', '모듈이 성공적으로 추가되었습니다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (651, 'no_tables_are_registered_in_config', 'No tables are registered in config', 'No tables are registered in config', '구성에 등록된 테이블이 없습니다.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (652, 'inventory', 'Inventory', NULL, '목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (653, 'hrm', 'HRM', NULL, '흠');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (654, 'payrol', 'Payrol', NULL, '급여');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (655, 'download', 'Download', 'Download', '다운로드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (656, 'uninstall', 'Uninstall', 'Uninstall', '제거');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (657, 'inventory', 'Inventory', NULL, '목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (658, 'hrm', 'HRM', NULL, '흠');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (659, 'payrol', 'Payrol', NULL, '급여');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (660, 'sell_form', 'Sell Information', 'Sell Information', '판매 양식');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (661, 'notification_list', 'Notification List', 'Notification List', '알림 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (662, 'email_details', 'Notification Details', 'Notification Details', '이메일 및 SMS 게이트웨이');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (663, 'transection_list', 'Transaction List', 'Transection List', '거래 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (664, 'mehedi', 'mehedi', 'mehedi', '메헤디');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (665, 'googlemapapikey', 'Google Map Api Key', 'Clé API Google Map', '구글 지도 API 키');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (666, 'email_user', 'Email', 'Email', '이메일 사용자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (667, 'transfer_recite', 'Transfer Recite', 'Transfer Recite', '낭송하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (668, 'already_confirmed', 'Already Confirmed', 'Déjà confirmé', '이미 확인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (669, 'already_canceled', 'Already canceled', 'Déjà annulé', '이미 취소');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (670, 'withdraw_cancel', 'Withdraw Cancel', 'Retirer Annuler', '취소 취소');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (671, 'confirm_withdraw', 'Confirm Withdraw', 'Confirm Withdraw', '철회 확인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (672, 'user', 'Users', 'utilisatrices', '사용자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (673, 'user_details', 'User Details', 'Détails de l\'utilisateur', '사용자 세부 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (674, 'payout', 'Payout', 'Paiement', '지불금');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (675, 'all_payout', 'Payout List', 'liste de paiement', '모든 지불금');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (676, 'comission', 'Commission', 'Commission', '커미션');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (677, 'all_comission', 'Commission List', 'Liste des commissions', '모든 수수료');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (678, 'package_id', 'Package Id', 'Identifiant du package', '패키지 ID');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (679, 'all_investment', 'Investment List', 'Liste des investissements', '모든 투자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (680, 'Télécharger la base de données', 'Download Database', 'Télécharger la base de données', '텔레차저 라 베이스 드 도네');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (681, 'download_backup', 'Download Database', 'Télécharger la base de données', '백업 다운로드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (682, 'download_theme', 'Download Theme', 'Télécharger le thème', '테마 다운로드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (683, 'theme', 'Theme', 'Thème', '주제');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (684, 'download_module', 'Download Module', 'Télécharger le module', '모듈 다운로드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (685, 'Wrong_payment', 'Wrong Payment', NULL, '잘못된 지불');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (686, 'Server_problem', 'Server problem, contact with the administrator', NULL, '서버 문제');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (687, 'Invalid_payment', 'Invalid Payment', NULL, '잘못된 로고');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (689, 'merchant_key', 'Merchant Key', NULL, '판매자 키');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (690, 'merchant_mid', 'Merchant MID', NULL, '상인 중반');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (692, 'gourl_setting', 'Gourl Setting', NULL, '굴 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (693, 'paypal_setting', 'Payment Setting', NULL, '지불금 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (694, 'paystack_setting', 'Paystack Setting', NULL, '급여 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (695, 'paytm_setting', 'Paytm Setting', NULL, '지불 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (696, 'phone_setting', 'Phone Setting', NULL, '전화 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (697, 'stripe_setting', 'Stripe Setting', NULL, '스트라이프 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (714, 'verification_code', 'Verification Code', 'Verification Code', '확인 코드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (715, 'nft_cat_list', 'NFT Category List', 'Luokkaluettelo', 'NFT 카테고리 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (716, 'nft_collection_list', 'All Collections', NULL, 'NFT 컬렉션 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (717, 'By_logging', 'By logging in you indicate that you have read and agree to our', '', '로깅으로');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (718, 'iam_interested_register', 'I am interested in receiving marketing emails for updates on upcoming events, promotions, and new features', '', '나는 관심이있다 등록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (719, 'by_logging_in_you_indicate_that_you_have_read_and_agree', 'By logging in you indicate that you have read and agree', '', '로그인함으로써 귀하는 읽고 동의했음을 나타냅니다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (720, 'Profile_picture_ecommended', 'Profile picture recommended (300x300px)', '', '프로필 사진');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (721, 'Banner_picture_recommended', 'Banner picture recommended (1400px x 400px)', '', '배너 사진 추천');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (722, 'add_image_file', 'Add Image/Audio/Video', '', '자주 묻는 질문 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (723, 'support_file', 'Support: JPG, PNG, GIF, MP3, MP4, Max size: 10 MB', '', '지원 파일');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (724, 'gas_deducted', 'Gas fee required, it will deducted from your wallet.', '', '가스 공제');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (725, 'Collection_logo_recommended', 'Collection logo recommended (350x350px)', '', '컬렉션 로고 권장');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (726, 'Collection_banner_recommended', 'Collection banner recommended (1400 x 400px)', '', '컬렉션 배너 권장');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (727, 'Gas_fees_will_be_deducted_from_your_wallet', 'Gas fees will be deducted from your wallet.', '', '가스 요금이 지갑에서 차감됩니다.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (728, 'Content_Manager_System', 'Content Manager System', '', '콘텐츠 관리자 시스템');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (729, 'home_section', 'Home (section 1)', '', '홈 섹션');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (730, 'recommended_to', 'Recommended to', '', '추천');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (731, 'contract_deploy_msg', 'The contract deploy function will no longer be visible once a contract has been deployed. And the hash of the contract transaction will appear here.', '', '계약 주소');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (732, 'wallet_import_msg', 'Please import your private key with some balance for contract deploy and others transaction. We ensure this private key will be encrypted in blockchain.', '', '지갑 가져오기 메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (733, 'fees_msg', 'Fees of sale percentage calculate on item price & Transfer fees deducted from transferred user.', '', '수수료 메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (734, 'cornjob_msg', 'You can use above link for cron job. Copy and paste at cron job Command box.', '', '옥수수 메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (735, 'mint', 'Mint', NULL, '민트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (736, 'search', 'Search', NULL, '검색');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (737, 'search_your_nfts', 'Search Your NFTS', NULL, 'nfts 검색');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (738, 'create_your_nft', 'Create Your NFT', NULL, '당신의 nft를 만들었습니다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (739, 'all_nfts', 'All NFTs', NULL, '모든 nfts');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (740, 'my_nfts', 'My NFTs', NULL, '내 NFTS');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (741, 'favorites', 'Favorites', NULL, '즐겨찾기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (742, 'my_collections', 'My Collections', NULL, '마이컬렉션');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (743, 'favourites', 'Favourites', NULL, '즐겨찾기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (744, 'about_us', 'About Us', NULL, '우리에 대해');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (745, 'join_our_community', 'Join Our Community', NULL, '우리 커뮤니티에 가입');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (746, 'terms', 'Terms', NULL, '자귀');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (747, 'privacy_policy', 'Privacy Policy', NULL, '개인 정보 정책');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (748, 'data_not_found', 'Data not Found', NULL, '데이터를 찾을 수 없습니다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (749, 'blockchain', 'Blockchain', NULL, '블록체인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (750, 'all', 'All', NULL, '모두');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (751, 'collections', 'Collections', NULL, '컬렉션');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (752, 'load_more', 'Load More', NULL, '더 로드');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (753, 'created_by', 'Created By', NULL, '만든 사람');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (754, 'items', 'Items', NULL, '아이템');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (755, 'owners', 'Owners', NULL, '소유자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (756, 'minimum_price', 'Minimum Price', NULL, '최저 가격');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (757, 'exception', 'Exception', NULL, '예외');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (758, 'please_login_to_continue', 'Please Login to Continue', NULL, '계속하려면 로그인하십시오');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (759, 'usersignin', 'User Sign IN', NULL, '사용자 로그인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (760, 'continue', 'Continue', NULL, '계속하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (761, 'terms_of_use', 'Terms Of Use', NULL, '이용약관');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (762, 'display', 'Display', NULL, '표시하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (763, 'no_account', 'No Account', NULL, '계정 없음');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (764, 'owner', 'Owner', NULL, '소유자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (765, 'auction_ends_in', 'Auction Ends in', NULL, '경매 종료');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (766, 'make_offer', 'Make Offer', NULL, '제안을');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (767, 'list_for_sell', 'List for Sell', NULL, '판매 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (768, 'bids', 'Bids', NULL, '입찰');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (769, 'blockchain_info', 'Blockchain Info', NULL, '블록체인 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (770, 'characteristics', 'Characteristics', NULL, '형질');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (771, 'empty', 'Empty', NULL, '비어 있는');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (772, 'blockchain_network', 'Blockchain Network', NULL, '블록체인 네트워크');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (773, 'contract', 'Contract', NULL, '계약');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (774, 'token_id', 'Token ID', NULL, '토큰 ID');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (775, 'token_standard', 'Token Standard', NULL, '토큰 표준');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (776, 'nft_activity', 'NFT Activity', NULL, 'NFT 활동');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (777, 'event', 'Event', NULL, '이벤트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (778, 'from', 'From', NULL, '~에서');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (779, 'to', 'To', NULL, '시간');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (780, 'nft_listings', 'NFT Listings', NULL, 'NFT 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (781, 'more_nfts_from_this_collection', 'More NFTs From This Collection', NULL, '이 컬렉션에서 더 많은 nfts');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (782, 'make_an_offer', 'Make an Offer', NULL, '제안을 하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (783, 'available', 'Available', NULL, '사용 가능');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (784, 'complete_checkout', 'Complete Checkout', NULL, '결제 완료');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (785, 'registration', 'Registration', NULL, '등록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (786, 'create_an_account', 'Create an Account', NULL, '계정을 만들었습니다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (787, 'choose_user_name', 'Choose User Name', NULL, '사용자 이름 선택');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (788, 'enter_your_email_address', 'Enter Your Email Address', NULL, '이메일 주소를 입력하세요');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (789, 'enter_your_password', 'Enter Your Password', NULL, '비밀번호를 입력하세요');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (790, 'confirm_password', 'Confirm Password', NULL, '비밀번호 확인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (791, 'lowercase', 'Lowercase', NULL, '소문자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (792, 'uppercase', 'Uppercase', NULL, '대문자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (793, 'number', 'Number', NULL, '숫자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (794, 'special_character', 'Special Character', NULL, '특수 문자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (795, 'atleast_8_character', 'Atleast 8 Character', NULL, '기사 8 문자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (796, 'to_our', 'To Our', NULL, '우리에게');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (797, 'and', 'And', NULL, '그리고');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (798, 'have_an_account', 'Have an Account', NULL, '계정이있다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (799, 'activity', 'Activity', NULL, '활동');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (800, 'ethereum', 'Ethereum', NULL, '이더 리움');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (801, 'active_users', 'Active Users', NULL, '활성 계정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (802, 'person', 'Person', NULL, '사람');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (803, 'see_all_user', 'See All User', NULL, '모두 보기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (804, 'total_nfts', 'Total NFTs', NULL, '총 NFTS');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (805, 'see_all_nft', 'See All NFT', NULL, '모두 보기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (806, 'total_list_for_sale', 'Total List for Sale', NULL, '총 판매 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (807, 'total_sell', 'Total Sell', NULL, '총 판매');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (808, 'total_earned_fees', 'Total Earned Fees', NULL, '총 적립 수수료');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (809, 'inactive_users', 'Inactive Users', NULL, '비활성 사용자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (810, 'inactive_total_user', 'Inactive Total User', NULL, '비활성 총 사용자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (811, 'monthly_nfts_minted_reports', 'Monthly NFTs Minted Reports', NULL, '모듈 nfts 발행 보고서');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (812, 'yearly_nfts_report', 'Yearly NFTs Report', NULL, '연간 NFTS 보고서');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (813, 'created_nft', 'Created NFT', NULL, '만든 NFT');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (814, 'collected_nft', 'Collected NFT', NULL, '수집된 nft');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (815, 'my_favourite', 'My Favourite', NULL, '내가 좋아하는');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (816, 'copy_link', 'Copy Link', NULL, '링크 복사');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (817, 'menu', 'Menu', NULL, '메뉴');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (818, 'top_menu', 'Top Menu', NULL, '상위 메뉴');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (819, 'footer_menu', 'Footer Menu', NULL, '바닥글 메뉴');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (820, 'top_and_footer', 'Top and Footer', NULL, '상단 및 바닥글');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (821, 'not_menu', 'Not Menu', NULL, '메뉴가 아닌');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (822, 'policy', 'Policy', NULL, '정책');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (823, 'social', 'Social', NULL, '사회의');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (824, 'section', 'Section', NULL, '부분');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (825, 'subtitle', 'Subtitle', NULL, '부제');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (826, 'sub_title', 'Sub Title', NULL, '부제');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (827, 'banner_background', 'Banner Background', NULL, '은행 배경');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (828, 'logo_image', 'Logo Image', NULL, '로고 이미지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (829, 'banner_image', 'Banner Image', NULL, '배너 이미지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (830, 'collection_name', 'Collection Name', NULL, '컬렉션 로고 권장');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (831, 'create_new_collection', 'Create New Collection', NULL, '새 컬렉션을 만들었습니다.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (832, 'your_smart_contract_to_verify_in', 'Your smart contract to verify in', NULL, '확인을 위한 스마트 연락처');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (833, 'contract_name', 'Contract Name', NULL, '계약명');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (834, 'token_symbol', 'Token Symbol', NULL, '토큰 기호');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (835, 'max_supply', 'Max Supply', NULL, '최대 공급');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (836, 'add_lebel', 'Add Lebel', NULL, '레이블 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (837, 'deploy', 'Deploy', NULL, '전개하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (838, 'blockchain_networks', 'Blockchain Networks', NULL, '블록체인 네트워크');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (839, 'only_binance_smart_chain', 'Only Binance Smart Chain', NULL, '바이낸스 스마트체인 전용');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (840, 'add_network', 'Add Network', NULL, '네트워크 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (841, 'network_name', 'Network Name', NULL, '네트워크 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (842, 'chain_id', 'Chain ID', NULL, '체인 아이디');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (843, 'rpc', 'RPC', NULL, 'rpc');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (844, 'block_explorer_url', 'Block Explorer URL', NULL, '블록체인 익스플로러 URL');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (845, 'server_ip', 'Server IP', NULL, '서버 아이피');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (846, 'not_found', 'Not Found', NULL, '찾을 수 없음');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (847, 'admin_wallet', 'Admin Wallet', NULL, '관리자 지갑');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (848, 'wallet_address', 'Wallet Address', NULL, '지갑 주소');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (849, 'please_get_your_network_information_from', 'Please get your network information from', NULL, '에서 네트워크 정보를 얻으십시오.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (850, 'binance_document', 'Binance document', NULL, '바이낸스 문서');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (851, 'rpc_url', 'RPC Url', NULL, 'rpc url');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (852, 'blockchain_explorer_url', 'Blockchain Explorer URL', NULL, '블록체인 익스플로러 URL');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (853, 'nft_selling_type', 'NFT Selling Type', NULL, 'NFT 판매 유형');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (854, 'enter_your_private_key', 'Enter your Private Key', NULL, '개인 키를 입력');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (855, 'owner_name', 'Owner name', NULL, '소유자 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (856, 'properties', 'Properties', NULL, '속성');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (857, 'suspend_message', 'Suspend message', NULL, '일시 중단 메시지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (858, 'is_featured', 'Is featured', NULL, 'IP 추천');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (859, 'owner_wallet', 'Owner wallet', NULL, '소유자 지갑');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (860, 'contract_address', 'Contract address', NULL, '계약 주소');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (861, 'transcation_hash', 'Transcation hash', NULL, '트랜잭션 해시');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (862, 'please_set_your_wallet_address', 'Please set your wallet address', NULL, '지갑 주소를 설정해주세요');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (863, 'collection_title', 'Collection Title', NULL, '컬렉션 제목');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (864, 'collection_url', 'Collection URL', NULL, '컬렉션 URL');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (865, 'collection_description', 'Collection Description', NULL, '컬렉션 설명');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (866, 'write_our_collection_description', 'Write our collection description', NULL, '컬렉션 설명 작성');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (867, 'collection_category', 'Collection Category', NULL, '컬렉션 카테고리');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (868, 'create_collection', 'Create Collection', NULL, '생성된 컬렉션');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (869, 'nft_title', 'NFT Title', NULL, 'NFT 타이틀');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (870, 'nft_description', 'NFT Description', NULL, 'NFT 설명');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (871, 'write_your_item_description', 'Write your item description', NULL, '당신의 항목 설명을 작성');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (872, 'nft_characteristics', 'NFT Characteristics', NULL, 'NFT 특성');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (873, 'nft_collection', 'NFT Collection', NULL, 'NFT 컬렉션');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (874, 'write_your_collection_description', 'Write your collection description', NULL, '컬렉션 설명 작성');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (875, 'list_item_for_sale', 'List item for sale', NULL, '판매 목록 항목');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (876, 'auction', 'Auction', NULL, '경매');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (877, 'fixed_price', 'Fixed Price', NULL, '고정 가격');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (878, 'starting_price', 'Starting Price', NULL, '시작 가격');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (879, 'completelisting', NULL, NULL, '전체 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (880, 'complete_listing', 'Complete listing', NULL, '완전한 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (881, 'transfer_item', 'Transfer Item', NULL, '전송 항목');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (882, 'transfer_fees', 'Transfer Fees', NULL, '송금 수수료');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (883, 'to_wallet', 'To Wallet', NULL, '지갑에');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (884, 'note', 'Note', NULL, '노트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (885, 'if_problem_with_google_smtp_then_please_use_another_third_party_smtp_server', 'If problem with google smtp then please use another third party smtp server', NULL, 'Google smtp에 문제가 있는 경우 다른 타사 smtp 서버를 사용하십시오.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (886, 'test_your_smtp_email_server', 'Test Your SMTP Email Server', NULL, 'smtp 이메일 서버 테스트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (887, 'template_subject', 'Template Subject', NULL, '템플릿 주제');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (888, 'template', 'Template', NULL, '주형');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (889, 'use_these_text_on_message_template_where_you_want_to_use_this_type_of_data_in_your_message', 'Use these text on message template where you want to use this type of data in your Message', NULL, '메시지에서 이러한 유형의 데이터를 사용하려는 메시지 템플릿에 thess 텍스트를 사용하십시오.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (890, 'template_en_subject', 'Template EN subject', NULL, '템플릿 영어 과목');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (891, 'template_en', 'Template EN', NULL, '템플릿 영어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (892, 'header_background_img', 'Header Background Img', NULL, '헤더 배경 이미지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (893, 'footer_background_img', 'Footer Background Img', NULL, '바닥글 배경 이미지');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (894, 'for_daily_auction_close', 'for daily auction close', NULL, '일일 경매 마감');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (895, 'api_name', 'API Name', NULL, 'API 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (896, 'merchant_id', 'Merchant Id', NULL, '판매자 아이디');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (897, 'click_to_change_password', 'Click to change password', NULL, '클릭하여 비밀번호 변경');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (898, 'registered_date', 'Registered Date', NULL, '등록 날짜');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (899, 'wallet_info', 'Wallet Info', NULL, '지갑 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (900, 'get_balance', 'Get Balance', NULL, '균형을 잡다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (901, 'check_your_email', 'Check your email', NULL, '이메일을 확인');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (902, 'transactions', 'Transactions', NULL, '업무');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (903, 'biography', 'Biography', NULL, '전기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (904, 'personal_website_link', 'Personal website link', NULL, '개인 홈페이지 링크');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (905, 'copy_to_clipboard', 'Copy to clipboard', NULL, '클립 보드에 복사');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (906, 'update_profile', 'Update Profile', NULL, '프로필 업데이트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (907, 'important', 'Important', NULL, '중요한');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (908, 'please_check_your_balance_and_deposit_your_any_wallet', 'Please check your balance and deposit your any wallet', NULL, '잔액을 확인하고 지갑을 입금하세요.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (909, 'copy_address', 'Copy Address', NULL, '주소 복사');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (910, 'hold_balance', 'Hold Balance', NULL, '제목 프랑스어');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (911, 'reload_balance', 'Reload Balance', NULL, '재장전 균형');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (912, 'please_reload_your_balance_then_send_amount_less_than_balance', 'Please reload your balance then send amount less than balance', NULL, '잔액을 다시 로드한 다음 잔액보다 적은 금액을 보내십시오.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (913, 'please_wait', 'Please wait', NULL, '기다리세요.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (914, 'sidebar_toggle', 'sidebar toggle', NULL, '사이드바 토글');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (915, 'my_profile', 'My Profile', NULL, '내 프로필');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (916, 'sign_out', 'Sign Out', NULL, '로그아웃');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (917, 'support', 'Support', NULL, '지원하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (918, 'send_message', 'Send Message', NULL, '문자 보내');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (919, 'auction_ends', 'Auction Ends', NULL, '경매 종료');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (920, 'latest_nfts', 'Latest NFTs', NULL, '최신 NFT');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (921, '0_nfts', '0 NFTs', NULL, '0 NFT');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (922, 'demo', 'Demo', NULL, '데모');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (923, 'nfts', 'NFTs', NULL, 'NFTS');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (924, 'top_sellers', 'Top Sellers', NULL, '제일 잘 팔리는 물품들');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (925, 'in_collection', 'in collection', NULL, '수집 중');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (926, 'top_collections', 'Top Collections', NULL, '최고의 컬렉션');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (927, 'log_in', 'Log in', NULL, '로고');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (928, 'nft_setup', NULL, NULL, 'NFT 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (929, 'categories', NULL, NULL, '카테고리');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (930, 'add_category', NULL, NULL, '카테고리 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (933, 'add_collection', NULL, NULL, '컬렉션 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (934, 'contract_deploy', NULL, NULL, '계약 배포');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (935, 'content_manager', NULL, NULL, '콘텐츠 관리자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (936, 'selling_type', NULL, NULL, '판매 유형');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (937, 'email_gateway', NULL, NULL, '이메일 게이트웨이');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (938, 'external_api', NULL, NULL, '외부 API');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (939, 'email_template', NULL, NULL, '이메일 템플릿');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (940, 'admin_users', NULL, NULL, '관리자 사용자');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (941, 'add_admin_user', NULL, NULL, '관리자 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (942, 'customers', NULL, NULL, '고객');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (943, 'add_new_customer', NULL, NULL, '새 고객 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (944, 'nft_list', NULL, NULL, 'NFT 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (945, 'customer_list', NULL, NULL, '고객 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (946, 'customer_info', NULL, NULL, '고객 정보');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (947, 'category_name', NULL, NULL, '카테고리 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (948, 'create_new_category', NULL, NULL, '새 카테고리 만들기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (949, 'update_category', NULL, NULL, '카테고리 업데이트');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (950, 'add_new_collection', NULL, NULL, '새 컬렉션 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (951, 'select_category', NULL, NULL, '카테고리 선택');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (952, 'import_wallet', NULL, NULL, '지갑 가져오기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (953, 'contract_setup', NULL, NULL, '계약 설정');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (954, 'for_token_id_update', NULL, NULL, '토큰 ID 업데이트용');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (955, 'sale_type_control', NULL, NULL, '판매 유형 관리');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (956, 'id', NULL, NULL, 'ID');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (957, 'api_list', NULL, NULL, 'API 목록');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (958, 'emailsms_template', NULL, NULL, '이메일/sms 템플릿');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (959, 'smsemail_template', NULL, NULL, 'SMS/이메일 템플릿');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (960, 'language_name', NULL, NULL, '언어 이름');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (961, 'add_phrase', NULL, NULL, '구문 추가');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (962, 'modal_title', NULL, NULL, '모달 제목');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (963, 'export_phrase', NULL, NULL, '구문 내보내기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (964, 'import_phrase', NULL, NULL, '구문 가져오기');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (965, 'edit_phrase', NULL, NULL, '구문 편집');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (966, 'art', NULL, NULL, '미술');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (967, 'change_language', NULL, NULL, '언어 변경');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (968, 'connect_wallet', NULL, NULL, '지갑 연결');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (969, 'connect_metamask', NULL, NULL, '메타마스크 연결');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (970, 'please_connect_your_metamask_if_you_dont_have_a_metamask_yet_you_can_install_now', NULL, NULL, '메타마스크를 연결하세요. 아직 메타마스크가 없다면 지금 설치할 수 있습니다.');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (971, 'connect', NULL, NULL, '연결하다');
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (972, 'auction_completed_nfts', 'Auction completed nfts', NULL, NULL);
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (973, 'auction_completed', 'Auction completed', NULL, NULL);
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (974, 'your_transcation_succefully_save_please_wait_admin_approve', 'Your transaction successfully saved please wait admin approve', NULL, NULL);
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (975, 'your_one_transcation_is_pending', 'Your one transaction is pending', NULL, NULL);
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (976, 'customers_withdraw_request_list', 'Customers withdraw request list', NULL, NULL);
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (977, 'this_is_demo', 'This is demo!', NULL, NULL);
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (978, 'allow_url_fopen', 'Its required the servers allow_url_fopen is enabled, should work well', NULL, NULL);
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (979, 'server_configuration', 'Found in the server configuration by allow_url_fopen=0', NULL, NULL);
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (980, 'addons', 'Addons', NULL, NULL);
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (981, 'eth_settings', 'ETH Settings', NULL, NULL);
INSERT INTO `dbt_language` (`id`, `phrase`, `english`, `french`, `korean`) VALUES (982, 'eth_network', 'ETH Network', NULL, NULL);


#
# TABLE STRUCTURE FOR: dbt_module
#

DROP TABLE IF EXISTS `dbt_module`;

CREATE TABLE `dbt_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `directory` varchar(100) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (1, 'Ethereum Network', 'Blockchain network', 'app/Modules/Eth_network/Assets/Images/thumbnail.jpg', 'Eth_network', 1);


#
# TABLE STRUCTURE FOR: dbt_nft_biding
#

DROP TABLE IF EXISTS `dbt_nft_biding`;

CREATE TABLE `dbt_nft_biding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nft_listing_id` int(11) DEFAULT NULL,
  `nft_id` int(11) DEFAULT NULL,
  `bid_from_id` varchar(11) DEFAULT NULL,
  `bid_start_at` datetime DEFAULT NULL,
  `bid_end_at` datetime DEFAULT NULL,
  `bid_amount` double(22,8) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1 COMMENT '1 = active, 2 = success, 3=expired, 4 =canceld',
  `accept_status` tinyint(4) DEFAULT 0,
  `cancel_status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(22) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_nft_biding_log
#

DROP TABLE IF EXISTS `dbt_nft_biding_log`;

CREATE TABLE `dbt_nft_biding_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nft_bid_id` int(11) DEFAULT NULL,
  `nft_listing_id` int(11) DEFAULT NULL,
  `nft_id` int(11) DEFAULT NULL,
  `bid_from_id` int(11) DEFAULT NULL,
  `bid_start_at` datetime DEFAULT NULL,
  `bid_end_at` datetime DEFAULT NULL,
  `bid_amount` double(22,8) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `cancel_status` tinyint(4) DEFAULT 0,
  `accept_status` tinyint(4) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(22) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_nft_category
#

DROP TABLE IF EXISTS `dbt_nft_category`;

CREATE TABLE `dbt_nft_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(20) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_nft_category` (`id`, `cat_name`, `slug`, `description`, `created_at`, `created_by`, `status`, `logo`) VALUES (1, 'ART', 'art', '', NULL, NULL, 1, '/public/uploads/category/logo/1655206226_73232f5f1fdbe556a570.jpg');


#
# TABLE STRUCTURE FOR: dbt_nft_collection
#

DROP TABLE IF EXISTS `dbt_nft_collection`;

CREATE TABLE `dbt_nft_collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(22) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `logo_image` varchar(255) DEFAULT NULL,
  `banner_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_nft_listing
#

DROP TABLE IF EXISTS `dbt_nft_listing`;

CREATE TABLE `dbt_nft_listing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nft_store_id` int(11) DEFAULT NULL,
  `nft_token_id` varchar(55) DEFAULT NULL,
  `list_from` varchar(22) DEFAULT NULL,
  `auction_type` varchar(10) DEFAULT NULL COMMENT 'bid / fixed',
  `approve_type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '2=automatic,1=manual',
  `min_price` double(22,8) DEFAULT NULL,
  `max_price` double(22,8) DEFAULT NULL,
  `reserve_price` double(22,8) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0 COMMENT '0=on sale, 1=sale success, 2=expired, 3=canceled',
  `total_bid` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_nft_listing_log
#

DROP TABLE IF EXISTS `dbt_nft_listing_log`;

CREATE TABLE `dbt_nft_listing_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) DEFAULT NULL,
  `nft_store_id` int(11) DEFAULT NULL,
  `nft_token_id` varchar(55) DEFAULT NULL,
  `list_from` varchar(22) DEFAULT NULL,
  `auction_type` varchar(10) DEFAULT NULL COMMENT 'bid / fixed',
  `approve_type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '2=automatic,1=manual',
  `min_price` double(22,8) DEFAULT NULL,
  `max_price` double(22,8) DEFAULT NULL,
  `reserve_price` double(22,8) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0 COMMENT '0=on sale, 1=sale success, 2=expired, 3=canceled',
  `total_bid` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `trx_info` longtext DEFAULT NULL,
  `buyer_id` varchar(20) DEFAULT NULL,
  `buyer_wallet` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_nft_selling_type
#

DROP TABLE IF EXISTS `dbt_nft_selling_type`;

CREATE TABLE `dbt_nft_selling_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_nft_selling_type` (`type_id`, `type`, `status`, `updated_at`) VALUES (1, 'Bid', 1, '2022-02-10 17:37:53');
INSERT INTO `dbt_nft_selling_type` (`type_id`, `type`, `status`, `updated_at`) VALUES (2, 'Fix', 1, '2022-02-10 17:37:53');


#
# TABLE STRUCTURE FOR: dbt_nft_transfer_option
#

DROP TABLE IF EXISTS `dbt_nft_transfer_option`;

CREATE TABLE `dbt_nft_transfer_option` (
  `option_id` int(11) NOT NULL AUTO_INCREMENT,
  `option` varchar(22) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`option_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_nft_transfer_option` (`option_id`, `option`, `status`, `updated_at`) VALUES (1, 'Internal Transfer', 1, '2022-02-14 13:28:03');
INSERT INTO `dbt_nft_transfer_option` (`option_id`, `option`, `status`, `updated_at`) VALUES (2, 'Extarnal Transfer', 1, '2022-02-14 13:28:03');


#
# TABLE STRUCTURE FOR: dbt_nft_transfer_queue
#

DROP TABLE IF EXISTS `dbt_nft_transfer_queue`;

CREATE TABLE `dbt_nft_transfer_queue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(100) NOT NULL,
  `nft_id` varchar(100) NOT NULL,
  `from_wallet` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT 'User wallet',
  `to_wallet` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT 'Admin wallet',
  `trx` date DEFAULT NULL,
  `price` double(22,8) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '2 = Pending, 1 = Success, 0 = Cancel, 3 = Tnx Hash pending, 4 = Tnx Pause, 5 = GAS sending',
  `request_time` datetime DEFAULT NULL,
  `success_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# TABLE STRUCTURE FOR: dbt_nfts_store
#

DROP TABLE IF EXISTS `dbt_nfts_store`;

CREATE TABLE `dbt_nfts_store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(11) DEFAULT NULL,
  `owner_wallet` varchar(50) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `contract_address` varchar(255) DEFAULT NULL,
  `token_id` varchar(200) DEFAULT NULL,
  `token_standard` varchar(10) DEFAULT NULL,
  `blockchain_id` int(11) DEFAULT NULL,
  `file_token` varchar(255) DEFAULT NULL,
  `file_uri` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `metatag` text DEFAULT NULL COMMENT 'tag1,tag2',
  `properties` text DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `collection_id` int(11) DEFAULT NULL,
  `is_minted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1=yes, 0 = no',
  `trx_hash` varchar(155) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 2 COMMENT '0 = pending, 1 = active, 2 = Suspend, 3 = on sell',
  `is_verified` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0=un_verified, 1=verified',
  `price` double(22,8) DEFAULT 0.00000000,
  `is_featured` tinyint(4) DEFAULT NULL,
  `suspend_msg` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(22) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_nfts_store_log
#

DROP TABLE IF EXISTS `dbt_nfts_store_log`;

CREATE TABLE `dbt_nfts_store_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) DEFAULT NULL,
  `user_id` varchar(11) DEFAULT NULL,
  `owner_wallet` varchar(50) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `contract_address` varchar(255) DEFAULT NULL,
  `token_id` varchar(200) DEFAULT NULL,
  `token_standard` varchar(10) DEFAULT NULL,
  `blockchain_id` int(11) DEFAULT NULL,
  `file_token` varchar(255) DEFAULT NULL,
  `file_uri` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `metatag` text DEFAULT NULL COMMENT 'tag1,tag2',
  `properties` longtext DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `collection_id` int(11) DEFAULT NULL,
  `is_minted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1=yes, 0 = no',
  `trx_hash` varchar(155) DEFAULT NULL,
  `trx` longtext DEFAULT NULL,
  `status` tinyint(4) DEFAULT 2 COMMENT '0 = pending, 1 = active, 2 = Suspend, 3 = on sell',
  `ownership` varchar(12) DEFAULT NULL,
  `is_verified` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0=un_verified, 1=verified',
  `is_featured` tinyint(4) DEFAULT 0,
  `price` double(22,8) DEFAULT 0.00000000,
  `suspend_msg` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(22) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_setting
#

DROP TABLE IF EXISTS `dbt_setting`;

CREATE TABLE `dbt_setting` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `logo_web` varchar(255) NOT NULL,
  `header_bg_img` varchar(255) DEFAULT NULL,
  `footer_bg_img` varchar(255) DEFAULT NULL,
  `favicon` varchar(255) DEFAULT NULL,
  `language` varchar(100) DEFAULT NULL,
  `site_align` varchar(50) DEFAULT NULL,
  `footer_text` varchar(255) DEFAULT NULL,
  `time_zone` varchar(100) DEFAULT NULL,
  `latitude` varchar(100) DEFAULT NULL,
  `office_time` varchar(255) DEFAULT NULL,
  `update_notification` varchar(255) NOT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_setting` (`setting_id`, `title`, `description`, `email`, `phone`, `logo`, `logo_web`, `header_bg_img`, `footer_bg_img`, `favicon`, `language`, `site_align`, `footer_text`, `time_zone`, `latitude`, `office_time`, `update_notification`) VALUES (1, 'NFTBOX', 'Bangladesh Office 98 Green Road, Farmgate, Dhaka- 1215', 'info@bdtask.com', '+88-01317-584839', '/public/uploads/settings/1652779987_ec0e30b82f1bcd0a4209.png', '/public/uploads/settings/1652779939_21b53479397d6c74fcb6.png', '/public/uploads/settings/1655382014_6efbe1f35652a8b025b0.png', '/public/uploads/settings/1655382940_681b42aa9daebb9d91f9.jpg', '/public/uploads/dashboard/1652779939_8694a944f0e536e4527e.png', 'english', 'LTR', '2022 © Copyright Bdtask Ltd.', 'Asia/Dhaka', '40.6700, -73.9400', 'Monday - Friday: 08:00 - 22:00\r\nSaturday, Sunday: Closed', '1');


#
# TABLE STRUCTURE FOR: dbt_sms_email_send_setup
#

DROP TABLE IF EXISTS `dbt_sms_email_send_setup`;

CREATE TABLE `dbt_sms_email_send_setup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `method` text NOT NULL,
  `deposit` int(11) DEFAULT NULL,
  `transfer` int(11) DEFAULT NULL,
  `withdraw` int(11) DEFAULT NULL,
  `payout` int(11) DEFAULT NULL,
  `commission` int(11) DEFAULT NULL,
  `team_bonnus` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_sms_email_template
#

DROP TABLE IF EXISTS `dbt_sms_email_template`;

CREATE TABLE `dbt_sms_email_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sms_or_email` varchar(10) NOT NULL,
  `template_name` varchar(50) NOT NULL,
  `subject_en` varchar(300) NOT NULL,
  `subject_fr` varchar(300) NOT NULL,
  `template_en` varchar(300) NOT NULL,
  `template_fr` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

INSERT INTO `dbt_sms_email_template` (`id`, `sms_or_email`, `template_name`, `subject_en`, `subject_fr`, `template_en`, `template_fr`) VALUES (20, 'email', 'registration', 'Verify Your Account - NFTBOX', '', 'Hello %fullname% \r\nYour account was created successfully, Please click on the link below to activate your account. ', '<br><b>Votre compte a été créé avec succès, veuillez cliquer sur le lien ci-dessous pour activer votre compte. </b>');


#
# TABLE STRUCTURE FOR: dbt_social_app
#

DROP TABLE IF EXISTS `dbt_social_app`;

CREATE TABLE `dbt_social_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agent` varchar(100) NOT NULL,
  `app_id` varchar(300) NOT NULL,
  `app_secret` varchar(300) NOT NULL,
  `api_key` varchar(300) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_social_app` (`id`, `agent`, `app_id`, `app_secret`, `api_key`, `status`) VALUES (1, 'Facebook', '1930717227246512', 'e5f58059d39075e94a341eccb8e5e744', '', 1);
INSERT INTO `dbt_social_app` (`id`, `agent`, `app_id`, `app_secret`, `api_key`, `status`) VALUES (2, 'Google', '348978929215-ohi2nl5hkh14oo42tl4mgpb6pfpsjfkv.apps.googleusercontent.com', 'IvBozoy9MCHzg3II_DhIBfFl', 'AIzaSyDfhNJ5ea0kB-BN-Bjn2pI0DHtebElrF6g', 1);


#
# TABLE STRUCTURE FOR: dbt_social_link
#

DROP TABLE IF EXISTS `dbt_social_link`;

CREATE TABLE `dbt_social_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `link` varchar(100) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `status` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `dbt_social_link` (`id`, `name`, `link`, `icon`, `status`, `date`) VALUES (1, 'Facebook', 'https://www.facebook.com', 'facebook', 1, '2018-04-02 07:52:31');
INSERT INTO `dbt_social_link` (`id`, `name`, `link`, `icon`, `status`, `date`) VALUES (2, 'twitter', 'https://twitter.com', 'twitter', 1, '2018-04-02 07:29:25');
INSERT INTO `dbt_social_link` (`id`, `name`, `link`, `icon`, `status`, `date`) VALUES (3, 'google plus', 'https://google-plus.com', 'google-plus', 1, '2018-02-01 01:58:56');
INSERT INTO `dbt_social_link` (`id`, `name`, `link`, `icon`, `status`, `date`) VALUES (4, 'youtube', 'https://www.youtube.com', 'youtube-play', 1, '2018-04-02 07:28:49');
INSERT INTO `dbt_social_link` (`id`, `name`, `link`, `icon`, `status`, `date`) VALUES (5, 'instagram', 'https://instagram.com', 'instagram', 1, '2018-02-01 01:58:56');


#
# TABLE STRUCTURE FOR: dbt_themes
#

DROP TABLE IF EXISTS `dbt_themes`;

CREATE TABLE `dbt_themes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

INSERT INTO `dbt_themes` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES (1, 'website_template', 1, '2021-01-14 17:14:07', '2021-06-15 17:37:10');


#
# TABLE STRUCTURE FOR: dbt_user
#

DROP TABLE IF EXISTS `dbt_user`;

CREATE TABLE `dbt_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `sponsor_id` varchar(20) DEFAULT NULL,
  `lang` varchar(50) DEFAULT 'english',
  `f_name` varchar(50) DEFAULT NULL,
  `l_name` varchar(50) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `banner_image` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `password_reset_tocken` longtext DEFAULT NULL,
  `reg_ip` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0=did not active acc, 1= activated, 2 = deactivated , 3 = suspend',
  `is_verified` tinyint(4) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `portfolio_url` varchar(255) DEFAULT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `chain_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='All user information will be stored into this table.';

#
# TABLE STRUCTURE FOR: dbt_user_account
#

DROP TABLE IF EXISTS `dbt_user_account`;

CREATE TABLE `dbt_user_account` (
  `ac_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `symbol` varchar(11) DEFAULT NULL,
  `balance` double(22,8) DEFAULT NULL,
  `hold_balance` decimal(22,8) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`ac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_user_transaction
#

DROP TABLE IF EXISTS `dbt_user_transaction`;

CREATE TABLE `dbt_user_transaction` (
  `tr_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `symbol` varchar(11) DEFAULT NULL,
  `transaction_type_id` int(11) DEFAULT NULL COMMENT 'transaction_type table id',
  `transaction_type` varchar(22) DEFAULT NULL COMMENT 'Diposit/Withdraw/Transfer etc',
  `transaction_method` varchar(22) DEFAULT NULL COMMENT 'Stripe/Paypal/Admin etc',
  `fees` double(22,8) DEFAULT NULL,
  `amount` double(22,8) DEFAULT NULL,
  `to_wallet` varchar(100) DEFAULT NULL,
  `status` varchar(22) DEFAULT NULL,
  `trx_info` longtext DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `trx` longtext DEFAULT NULL,
  PRIMARY KEY (`tr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dbt_web_article
#

DROP TABLE IF EXISTS `dbt_web_article`;

CREATE TABLE `dbt_web_article` (
  `article_id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) DEFAULT NULL,
  `headline_en` varchar(300) NOT NULL,
  `article_image` varchar(100) DEFAULT NULL,
  `custom_url` varchar(300) NOT NULL,
  `article1_en` longtext NOT NULL,
  `article2_en` longtext NOT NULL,
  `video` varchar(300) DEFAULT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `page_content` int(11) DEFAULT 0 COMMENT 'if this is a Page content set 1 else 0',
  `position_serial` int(11) NOT NULL,
  `publish_date` datetime NOT NULL,
  `publish_by` varchar(25) NOT NULL,
  `edit_history` int(11) NOT NULL,
  PRIMARY KEY (`article_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (1, NULL, 'Big market for', NULL, '', 'Mint, Buy, and\r\n                                Sell\r\n                                Your NFT\'s\r\n', 'NFTBOX is the biggest Blockchain based NFT marketplace', '', 1, 1, 1, '2022-07-06 10:36:33', 'nftbox@demo.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (2, NULL, 'About Us', '', '', 'Personal identification information\r\nWe may collect personal identification information from Users in a variety of ways, including, but not limited to, when Users visit our site, register on the site, and in connection with other activities, services, features or resources we make available on our Site. Users may be asked for, as appropriate, name, email address, mailing address, phone number. Users may, however, visit our Site anonymously. We will collect personal identification information from Users only if they voluntarily submit such information to us. Users can always refuse to supply personally identification information, except that it may prevent them from engaging in certain Site related activities.\r\n\r\nNon-personal identification information\r\nWe may collect non-personal identification information about Users whenever they interact with our Site. Non-personal identification information may include the browser name, the type of computer and technical information about Users means of connection to our Site, such as the operating system and the Internet service providers utilized and other similar information.\r\n\r\nWeb browser cookies\r\nOur Site may use &#34;cookies&#34; to enhance User experience. User&#39;s web browser places cookies on their hard drive for record-keeping purposes and sometimes to track information about them. User may choose to set their web browser to refuse cookies, or to alert you when cookies are being sent. If they do so, note that some parts of the Site may not function properly.', '<h3 style=\"margin: 15px 0px; padding: 0px; font-weight: 700; font-size: 14px; font-family: &quot;Open Sans&quot;, Arial, sans-serif;\">The standard Lorem Ipsum passage, used since the 1500s</h3><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif;\"><strong style=\"margin: 0px; padding: 0px;\">Lorem Ipsum</strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p><h3 style=\"margin: 15px 0px; font-weight: 700; font-size: 14px; padding: 0px; font-family: &quot;Open Sans&quot;, Arial, sans-serif;\">Lorem Ipsum passage is the best placeholder.</h3><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif;\">\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\"</p><h3 style=\"margin: 15px 0px; font-weight: 700; font-size: 14px; padding: 0px; font-family: &quot;Open Sans&quot;, Arial, sans-serif;\">This could be the best Lorem Ipsum passage yet.</h3><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif;\"><span style=\"font-weight: bolder; margin: 0px; padding: 0px;\">Lorem Ipsum</span>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', 'https://www.youtube.com/watch?v=bWW5Kz2bEPg', 2, 1, 1, '2022-06-14 10:42:30', 'admin@demo.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (3, 'terms', 'Lorem Ipsum', 'public/uploads/team/59f4a8b127a56d2f3eac2ba3d537175d.png', '', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.', '<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', NULL, 5, 0, 1, '2022-05-29 11:37:05', 'bdtask@gmail.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (5, NULL, 'Repellat Odit Aliquid?', NULL, '', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reprehenderit, ipsum, fuga, in, obcaecati magni ullam nobis voluptas fugiat tenetur voluptatum quas tempora maxime rerum neque deserunt suscipit provident cumque et mollitia ex aspernatur porro minus sapiente voluptatibus eos at perferendis repellat odit aliquid harum molestias ratione pariatur adipisci. Aliquid, iure.', '', NULL, 3, 0, 0, '2018-04-08 10:43:08', 'admin@demo.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (6, NULL, 'Repellat Odit Aliquid?', NULL, '', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reprehenderit, ipsum, fuga, in, obcaecati magni ullam nobis voluptas fugiat tenetur voluptatum quas tempora maxime rerum neque deserunt suscipit provident cumque et mollitia ex aspernatur porro minus sapiente voluptatibus eos at perferendis repellat odit aliquid harum molestias ratione pariatur adipisci. ', '', NULL, 3, 0, 0, '2021-06-16 04:15:34', 'rdmvaijah@gmail.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (7, 'LatLng', 'Lat Lng', NULL, '', '40.6700', '-73.9400', NULL, 4, 0, 0, '2022-05-17 10:46:00', 'bdtask@gmail.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (8, 'privacy', 'Privacy policy, terms and conditions File kjhihi', '//public/uploads/e6f91e805b1cdd3139809fa748ebb25c.pdf', '', '[]alert(\"OK\")<scrdfipt>\r\n<p class=\"bd-lead\">This Privacy Policy governs the manner in which NFT collects, uses, maintains and\r\n                discloses information collected from users (each, a \"User\") of the http://www.NFT.com website\r\n                (\"Site\").</p>\r\n\r\n              <h2>Personal identification information</h2>\r\n              <p>We may collect personal identification information from Users in a variety of ways, including, but not\r\n                limited to, when Users visit our site, register on the site, and in connection with other activities,\r\n                services, features or resources we make available on our Site. Users may be asked for, as appropriate,\r\n                name, email address, mailing address, phone number. Users may, however, visit our Site anonymously. We\r\n                will collect personal identification information from Users only if they voluntarily submit such\r\n                information to us. Users can always refuse to supply personally identification information, except that\r\n                it may prevent them from engaging in certain Site related activities.</p>\r\n\r\n\r\n              <h3>Non-personal identification information</h3>\r\n              <p>We may collect non-personal identification information about Users whenever they interact with our\r\n                Site. Non-personal identification information may include the browser name, the type of computer and\r\n                technical information about Users means of connection to our Site, such as the operating system and the\r\n                Internet service providers utilized and other similar information.</p>\r\n\r\n\r\n              <h3>Web browser cookies</h3>\r\n              <p>Our Site may use \"cookies\" to enhance User experience. User\'s web browser places cookies on their hard\r\n                drive for record-keeping purposes and sometimes to track information about them. User may choose to set\r\n                their web browser to refuse cookies, or to alert you when cookies are being sent. If they do so, note\r\n                that some parts of the Site may not function properly.</p>\r\n\r\n              <h3>How we use collected information</h3>\r\n              <p>NFT may collect and use Users personal information for the following purposes:</p>\r\n              <ul class=\"list-checked mb-9 mb-md-10\">\r\n                <li>To run and operate our Site We may need your information display content on the Site correctly.</li>\r\n                <li>To improve customer service\r\n                  Information you provide helps us respond to your customer service requests and support needs more\r\n                  efficiently.</li>\r\n                <li>To personalize user experience\r\n                  We may use information in the aggregate to understand how our Users as a group use the services and\r\n                  resources provided on our Site.</li>\r\n                <li>To improve our Site\r\n                  We may use feedback you provide to improve our products and services.</li>\r\n                <li>To run a promotion, contest, survey or other Site feature\r\n                  To send Users information they agreed to receive about topics we think will be of interest to them.\r\n                </li>\r\n                <li>To send periodic emails\r\n                  We may use the email address to send User information and updates pertaining to their order. It may\r\n                  also be used to respond to their inquiries, questions, and/or other requests.</li>\r\n              </ul>\r\n              <h3>How we protect your information</h3>\r\n              <p>We adopt appropriate data collection, storage and processing practices and security measures to protect\r\n                against unauthorized access, alteration, disclosure or destruction of your personal information,\r\n                username, password, transaction information and data stored on our Site.</p>\r\n\r\n              <!--<h3>Sharing your personal information</h3>\r\n                          <p>We may share or sell information with third parties for marketing or other purposes.</p>-->\r\n\r\n              <h3>Electronic newsletters</h3>\r\n              <p>If User decides to opt-in to our mailing list, they will receive emails that may include company news,\r\n                updates, related product or service information, etc.</p>\r\n\r\n              <h3>Advertising</h3>\r\n              <p>Ads appearing on our site may be delivered to Users by advertising partners, who may set cookies. These\r\n                cookies allow the ad server to recognize your computer each time they send you an online advertisement\r\n                to compile non personal identification information about you or others who use your computer. This\r\n                information allows ad networks to, among other things, deliver targeted advertisements that they believe\r\n                will be of most interest to you. This privacy policy does not cover the use of cookies by any\r\n                advertisers.</p>\r\n\r\n              <h3>Google Adsense</h3>\r\n              <p>Some of the ads may be served by Google. Google\'s use of the DART cookie enables it to serve ads to\r\n                Users based on their visit to our Site and other sites on the Internet. DART uses \"non personally\r\n                identifiable information\" and does NOT track personal information about you, such as your name, email\r\n                address, physical address, etc. You may opt out of the use of the DART cookie by visiting the Google ad\r\n                and content network privacy policy at <a\r\n                  href=\"https://www.google.com/privacy_ads.html\">http://www.google.com/privacy_ads.html</a></p>\r\n\r\n', '              <h3>Changes to this privacy policy</h3>\r\n              <p>NFT has the discretion to update this privacy policy at any time. When we do, we will post a\r\n                notification on the main page of our Site. We encourage Users to frequently check this page for any\r\n                changes to stay informed about how we are helping to protect the personal information we collect. You\r\n                acknowledge and agree that it is your responsibility to review this privacy policy periodically and\r\n                become aware of modifications.</p>\r\n\r\n              <h3>Your acceptance of these terms</h3>\r\n              <p>By using this Site, you signify your acceptance of this policy. If you do not agree to this policy,\r\n                please do not use our Site. Your continued use of the Site following the posting of changes to this\r\n                policy will be deemed your acceptance of those changes. </p>\r\n\r\n              <h3>Contacting us</h3>\r\n              <p>If you have any questions about this Privacy Policy, the practices of this site, or your dealings with\r\n                this site, please contact us.</p>\r\n\r\n              <p>This document was last updated on August 21, 2016</p>', '', 6, 1, 1, '2022-06-08 06:55:58', 'admin@demo.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (9, NULL, 'Repellat Odit Aliquid?', NULL, '', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reprehenderit, ipsum, fuga, in, obcaecati magni ullam nobis voluptas fugiat tenetur voluptatum quas tempora maxime rerum neque deserunt suscipit provident cumque et mollitia ex aspernatur porro minus sapiente voluptatibus eos at perferendis repellat odit aliquid harum molestias ratione pariatur adipisci. Aliquid, iure. update', '', NULL, 3, 0, 0, '2022-06-08 06:56:33', 'admin@demo.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (10, NULL, 'What is goal?', NULL, '', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reprehenderit, ipsum, fuga, in, obcaecati magni ullam nobis voluptas fugiat tenetur voluptatum quas tempora maxime rerum neque deserunt suscipit provident cumque et mollitia ex aspernatur porro minus sapiente voluptatibus eos at perferendis repellat odit aliquid harum molestias ratione pariatur adipisci. ', '', NULL, 3, 0, 0, '2022-05-17 11:01:22', 'bdtask@gmail.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (11, 'msgus', 'Message Us', NULL, '', 'MESSAGE US', 'Start a chat!', NULL, 4, 0, 0, '2022-05-17 10:45:48', 'bdtask@gmail.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (12, 'callanytime', 'Call Anytime', NULL, '', 'CALL ANYTIME', '+8801558177887', NULL, 4, 0, 0, '0000-00-00 00:00:00', '', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (13, 'emailus', 'Email Us', NULL, '', 'EMAIL USgh', 'support@NFT.com', NULL, 4, 0, 0, '2022-05-17 10:45:39', 'bdtask@gmail.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (14, 'letus', 'Let Us', NULL, '', 'Let us hear from you directly!', 'Our guests always travel the world in style. Mention @Kempinski<br> on Instagram for a chance to be             featured!fgdg', NULL, 4, 0, 0, '2022-05-17 10:45:32', 'bdtask@gmail.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (15, 'address', 'Address', NULL, '', 'Address', 'Bangladesh Office<br>                   B-25, Mannan Plaza, 4th Floor, Khilkhet<br>                   Dhaka-1229, Bangladesh', NULL, 4, 0, 0, '0000-00-00 00:00:00', '', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (16, 'phone_whatsapp', 'Connect Our WhatsApp', NULL, '', 'Phone & WhatsApp Number', '+8801558177887<br>                 +8801817584639', NULL, 4, 0, 0, '2022-05-17 10:46:50', 'bdtask@gmail.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (17, 'email', 'Email Address', NULL, '', 'Email', 'bdtask@gmail.com <br>                 support@NFT.com', NULL, 4, 0, 0, '2022-06-14 05:36:17', 'a@a.com', 0);
INSERT INTO `dbt_web_article` (`article_id`, `slug`, `headline_en`, `article_image`, `custom_url`, `article1_en`, `article2_en`, `video`, `cat_id`, `page_content`, `position_serial`, `publish_date`, `publish_by`, `edit_history`) VALUES (18, NULL, 'What is Lorem Ipsum?', NULL, '', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reprehenderit, ipsum, fuga, in, obcaecati magni ullam nobis voluptas fugiat tenetur voluptatum quas tempora maxime rerum neque deserunt suscipit provident cumque et mollitia ex aspernatur porro minus sapiente voluptatibus eos at perferendis repellat odit aliquid harum molestias ratione pariatur adipisci. Aliquid, iure.', '', NULL, 3, 0, 0, '2022-06-08 06:56:56', 'admin@demo.com', 0);


#
# TABLE STRUCTURE FOR: dbt_web_category
#

DROP TABLE IF EXISTS `dbt_web_category`;

CREATE TABLE `dbt_web_category` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) NOT NULL,
  `cat_name_en` varchar(100) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `cat_image` varchar(300) DEFAULT NULL,
  `cat_title1_en` varchar(100) DEFAULT NULL,
  `cat_title2_en` varchar(300) DEFAULT NULL,
  `menu` int(11) NOT NULL COMMENT 'Header menu=1',
  `position_serial` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_web_category` (`cat_id`, `slug`, `cat_name_en`, `parent_id`, `cat_image`, `cat_title1_en`, `cat_title2_en`, `menu`, `position_serial`, `status`) VALUES (1, 'home', 'Home', 0, '', '', '', 1, 1, 1);
INSERT INTO `dbt_web_category` (`cat_id`, `slug`, `cat_name_en`, `parent_id`, `cat_image`, `cat_title1_en`, `cat_title2_en`, `menu`, `position_serial`, `status`) VALUES (2, 'about', 'About', 7, 'public/uploads/b40e7e093d856ff3c5037421efade783.jpg', 'About Us', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that', 1, 1, 1);
INSERT INTO `dbt_web_category` (`cat_id`, `slug`, `cat_name_en`, `parent_id`, `cat_image`, `cat_title1_en`, `cat_title2_en`, `menu`, `position_serial`, `status`) VALUES (3, 'faq', 'F.A.Q', 7, 'public/uploads/46a46840f71102641160f82a1ef47044.jpg', 'Frequently Ask & Question', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that', 1, 3, 1);
INSERT INTO `dbt_web_category` (`cat_id`, `slug`, `cat_name_en`, `parent_id`, `cat_image`, `cat_title1_en`, `cat_title2_en`, `menu`, `position_serial`, `status`) VALUES (4, 'contact', 'Contact', 7, 'public/uploads/03d99f85c1b60a59fc101c26fb8a2b3e.jpg', 'Contact', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that', 1, 5, 1);
INSERT INTO `dbt_web_category` (`cat_id`, `slug`, `cat_name_en`, `parent_id`, `cat_image`, `cat_title1_en`, `cat_title2_en`, `menu`, `position_serial`, `status`) VALUES (5, 'terms', 'terms', 8, '', '', '', 0, 2, 1);
INSERT INTO `dbt_web_category` (`cat_id`, `slug`, `cat_name_en`, `parent_id`, `cat_image`, `cat_title1_en`, `cat_title2_en`, `menu`, `position_serial`, `status`) VALUES (6, 'privacy', 'privacy', 0, '', '', '', 0, 0, 1);


#
# TABLE STRUCTURE FOR: dbt_web_language
#

DROP TABLE IF EXISTS `dbt_web_language`;

CREATE TABLE `dbt_web_language` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `flag` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `dbt_web_language` (`id`, `name`, `flag`) VALUES (1, 'Français', 'fr');


#
# TABLE STRUCTURE FOR: dbt_web_social_link
#

DROP TABLE IF EXISTS `dbt_web_social_link`;

CREATE TABLE `dbt_web_social_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `link` varchar(100) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `status` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `dbt_web_social_link` (`id`, `name`, `link`, `icon`, `status`, `date`) VALUES (1, 'Facebook', 'https://www.facebook.com', 'facebook', 1, '2018-04-02 07:52:31');
INSERT INTO `dbt_web_social_link` (`id`, `name`, `link`, `icon`, `status`, `date`) VALUES (2, 'twitter', 'https://twitter.com', 'twitter', 1, '2018-04-02 07:29:25');
INSERT INTO `dbt_web_social_link` (`id`, `name`, `link`, `icon`, `status`, `date`) VALUES (3, 'google plus', 'https://google-plus.com', 'google-plus', 1, '2018-02-01 01:58:56');
INSERT INTO `dbt_web_social_link` (`id`, `name`, `link`, `icon`, `status`, `date`) VALUES (4, 'youtube', 'https://www.youtube.com', 'fab fa-youtube', 1, '2022-05-16 17:33:23');
INSERT INTO `dbt_web_social_link` (`id`, `name`, `link`, `icon`, `status`, `date`) VALUES (5, 'instagram', 'https://instagram.com', 'instagram', 1, '2022-05-17 11:00:20');


#
# TABLE STRUCTURE FOR: dbt_web_subscriber
#

DROP TABLE IF EXISTS `dbt_web_subscriber`;

CREATE TABLE `dbt_web_subscriber` (
  `sub_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`sub_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

