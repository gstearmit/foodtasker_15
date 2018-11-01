BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS `social_auth_usersocialauth` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`provider`	varchar ( 32 ) NOT NULL,
	`uid`	varchar ( 255 ) NOT NULL,
	`user_id`	integer NOT NULL,
	`extra_data`	text NOT NULL,
	FOREIGN KEY(`user_id`) REFERENCES `auth_user`(`id`)
);
INSERT INTO `social_auth_usersocialauth` VALUES (2,'facebook','1681438445516197',4,'{"id": "1681438445516197", "expires": null, "access_token": "EAAId9hqzxZBsBAOLGFgWqDSx71ZBcT2BJ4Dzf0DSeVTKjQdQpInZAaAVeR9NRBWqdZByqscTjHU3sfZC1fQg2o5eLxbf5gCuG28L2OFj1Y6TudYWTDUqiTXDrR7nZC6YoULVO1EqiTcmO6eKSRNNQs1cADsGnmkjTxCvwitgN2xB1d7ZANF74c2", "token_type": null}');
CREATE TABLE IF NOT EXISTS `social_auth_partial` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`token`	varchar ( 32 ) NOT NULL,
	`next_step`	smallint unsigned NOT NULL,
	`backend`	varchar ( 32 ) NOT NULL,
	`data`	text NOT NULL
);
CREATE TABLE IF NOT EXISTS `social_auth_nonce` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`server_url`	varchar ( 255 ) NOT NULL,
	`timestamp`	integer NOT NULL,
	`salt`	varchar ( 65 ) NOT NULL
);
CREATE TABLE IF NOT EXISTS `social_auth_code` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`code`	varchar ( 32 ) NOT NULL,
	`verified`	bool NOT NULL,
	`email`	varchar ( 254 ) NOT NULL
);
CREATE TABLE IF NOT EXISTS `social_auth_association` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`server_url`	varchar ( 255 ) NOT NULL,
	`handle`	varchar ( 255 ) NOT NULL,
	`secret`	varchar ( 255 ) NOT NULL,
	`issued`	integer NOT NULL,
	`lifetime`	integer NOT NULL,
	`assoc_type`	varchar ( 64 ) NOT NULL
);
CREATE TABLE IF NOT EXISTS `oauth2_provider_refreshtoken` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`token`	varchar ( 255 ) NOT NULL UNIQUE,
	`access_token_id`	bigint NOT NULL UNIQUE,
	`application_id`	bigint NOT NULL,
	`user_id`	integer NOT NULL,
	`created`	datetime NOT NULL,
	`updated`	datetime NOT NULL,
	FOREIGN KEY(`user_id`) REFERENCES `auth_user`(`id`),
	FOREIGN KEY(`access_token_id`) REFERENCES `oauth2_provider_accesstoken`(`id`),
	FOREIGN KEY(`application_id`) REFERENCES `oauth2_provider_application`(`id`)
);
CREATE TABLE IF NOT EXISTS `oauth2_provider_grant` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`code`	varchar ( 255 ) NOT NULL UNIQUE,
	`expires`	datetime NOT NULL,
	`redirect_uri`	varchar ( 255 ) NOT NULL,
	`scope`	text NOT NULL,
	`application_id`	bigint NOT NULL,
	`user_id`	integer NOT NULL,
	`created`	datetime NOT NULL,
	`updated`	datetime NOT NULL,
	FOREIGN KEY(`application_id`) REFERENCES `oauth2_provider_application`(`id`),
	FOREIGN KEY(`user_id`) REFERENCES `auth_user`(`id`)
);
CREATE TABLE IF NOT EXISTS `oauth2_provider_application` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`client_id`	varchar ( 100 ) NOT NULL UNIQUE,
	`redirect_uris`	text NOT NULL,
	`client_type`	varchar ( 32 ) NOT NULL,
	`authorization_grant_type`	varchar ( 32 ) NOT NULL,
	`client_secret`	varchar ( 255 ) NOT NULL,
	`name`	varchar ( 255 ) NOT NULL,
	`user_id`	integer,
	`skip_authorization`	bool NOT NULL,
	`created`	datetime NOT NULL,
	`updated`	datetime NOT NULL,
	FOREIGN KEY(`user_id`) REFERENCES `auth_user`(`id`)
);
INSERT INTO `oauth2_provider_application` VALUES (4,'KDY3XUXspXz3MGczb13VBT1jNsCt3VL7SiDzCyJd','http://localhost:8000','confidential','client-credentials','w132bi8BU5s04xn3h3onowJ5pdT542GxW7IgRpQaswGoHJ9JjkSNA9BG6BuP59fDsnrpMUO0dxtmokXedFRcJH2kiPVgg5d5n4djVM4jI0jnuyBTQ5n3vaq544EOqb5a','Ironman',4,0,'2018-10-30 06:06:42.811677','2018-10-30 06:15:00.080134');
INSERT INTO `oauth2_provider_application` VALUES (5,'rSKcT9vgMPu5ONCViFAegQNaXwhMDZ8EtowVbKZb','http://localhost:8000','public','client-credentials','H0skopwXChEpz3kHhpIKcLhICzLAZiODpQQYbswf4kjNs4qtHF1yWiIhB62D5uU45BpkJx2RbeClfWRDwXMShIcPExS6fpZg8Lt5boP26RY3RoAT4nE4xJrwpI0O6HEM','adv.globalmedia2',7,1,'2018-10-30 06:16:11.358912','2018-10-30 06:16:11.358985');
INSERT INTO `oauth2_provider_application` VALUES (6,'QauMjlgdmgMHMGXpgCHwLqC5tPcBxZdoXS9KVCEJ','','confidential','password','XKXdIyDju2kvISKCTiVHBafyU0LCMfGk2YEDm6LegExAP6NHie4gZNEY97FGTFRcZMbl6ST36hYOy0uXAXMj7tFQu1gTSPG2PIsFnNZQirL3zEnE7rjESUO69agJwkqL','JacklyHoang',8,0,'2018-10-30 07:11:09.795626','2018-10-30 07:11:09.795697');
INSERT INTO `oauth2_provider_application` VALUES (7,'NtvkKDXhVxy2MEKuRN6EWe9uDrc2lYPBYwoCJAx4','','public','client-credentials','EqTbwJWVC59DXnicryvQWqbukfszl6egJ2y2pWSdDn7oCEdhf2NPa2rGJdvHZG4auZX4c2hL2WbN8LSuFw0CFP1bb6DYOXwk8R49RJ7RCumeym4fyNXX7wPgJLSYIfsA','weshop.devFoodTasker',9,0,'2018-10-30 07:15:29.102273','2018-10-30 07:18:57.883076');
CREATE TABLE IF NOT EXISTS `oauth2_provider_accesstoken` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`token`	varchar ( 255 ) NOT NULL UNIQUE,
	`expires`	datetime NOT NULL,
	`scope`	text NOT NULL,
	`application_id`	bigint,
	`user_id`	integer,
	`created`	datetime NOT NULL,
	`updated`	datetime NOT NULL,
	FOREIGN KEY(`application_id`) REFERENCES `oauth2_provider_application`(`id`),
	FOREIGN KEY(`user_id`) REFERENCES `auth_user`(`id`)
);
CREATE TABLE IF NOT EXISTS `foodtaskerapp_restaurant` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`name`	varchar ( 500 ) NOT NULL,
	`phone`	varchar ( 500 ) NOT NULL,
	`address`	varchar ( 500 ) NOT NULL,
	`logo`	varchar ( 100 ) NOT NULL,
	`user_id`	integer NOT NULL UNIQUE,
	FOREIGN KEY(`user_id`) REFERENCES `auth_user`(`id`)
);
INSERT INTO `foodtaskerapp_restaurant` VALUES (1,'Pho','12345678','99 Burwood Hwy, Burwood East','restaurant_logo/R1.jpg',1);
INSERT INTO `foodtaskerapp_restaurant` VALUES (2,'Bagelicious','88888888','10100 N Stelling Rd, Cupertino, CA 95014','restaurant_logo/R2_x0ShiGt.jpg',5);
INSERT INTO `foodtaskerapp_restaurant` VALUES (3,'Jackly','097 260 79 88','Thanh Xuan','restaurant_logo/image_9.png',8);
CREATE TABLE IF NOT EXISTS `foodtaskerapp_orderdetails` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`quantity`	integer NOT NULL,
	`sub_total`	integer NOT NULL,
	`meal_id`	integer NOT NULL,
	`order_id`	integer NOT NULL,
	FOREIGN KEY(`meal_id`) REFERENCES `foodtaskerapp_meal`(`id`),
	FOREIGN KEY(`order_id`) REFERENCES `foodtaskerapp_order`(`id`)
);
INSERT INTO `foodtaskerapp_orderdetails` VALUES (10,2,20,1,5);
INSERT INTO `foodtaskerapp_orderdetails` VALUES (11,3,63,2,5);
INSERT INTO `foodtaskerapp_orderdetails` VALUES (12,2,50,3,6);
CREATE TABLE IF NOT EXISTS `foodtaskerapp_order` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`address`	varchar ( 500 ) NOT NULL,
	`total`	integer NOT NULL,
	`status`	integer NOT NULL,
	`created_at`	datetime NOT NULL,
	`picked_at`	datetime,
	`customer_id`	integer NOT NULL,
	`restaurant_id`	integer NOT NULL,
	`driver_id`	integer,
	FOREIGN KEY(`customer_id`) REFERENCES `foodtaskerapp_customer`(`id`),
	FOREIGN KEY(`driver_id`) REFERENCES `foodtaskerapp_driver`(`id`),
	FOREIGN KEY(`restaurant_id`) REFERENCES `foodtaskerapp_restaurant`(`id`)
);
INSERT INTO `foodtaskerapp_order` VALUES (5,'99 Burwood Hwy',83,1,'2016-09-15 14:08:51.098139',NULL,1,2,NULL);
INSERT INTO `foodtaskerapp_order` VALUES (6,'Hà Nội, Hoàn Kiếm, Hà Nội, Việt Nam',50,1,'2018-10-30 06:38:10','2018-10-30 06:00:00',1,3,2);
CREATE TABLE IF NOT EXISTS `foodtaskerapp_meal` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`name`	varchar ( 500 ) NOT NULL,
	`short_description`	varchar ( 500 ) NOT NULL,
	`image`	varchar ( 100 ) NOT NULL,
	`price`	integer NOT NULL,
	`restaurant_id`	integer NOT NULL,
	FOREIGN KEY(`restaurant_id`) REFERENCES `foodtaskerapp_restaurant`(`id`)
);
INSERT INTO `foodtaskerapp_meal` VALUES (1,'Burger King','This is great burger','meal_images/R1_M1_hJmX2aB.JPG',10,2);
INSERT INTO `foodtaskerapp_meal` VALUES (2,'Black bun','with chips','meal_images/R1_M2.jpeg',21,2);
INSERT INTO `foodtaskerapp_meal` VALUES (3,'Bánh kẹp','Bánh kep trưng 2 tầng','meal_images/banhkep_wqxfwfH.jpg',25,3);
INSERT INTO `foodtaskerapp_meal` VALUES (4,'gà quay','Gà Quay','meal_images/gaquay.jpeg',35,3);
INSERT INTO `foodtaskerapp_meal` VALUES (5,'Bánh Mì Chiên','Bánh Mì Chiên giòn','meal_images/banhmichien.jpg',10,3);
CREATE TABLE IF NOT EXISTS `foodtaskerapp_driver` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`avatar`	varchar ( 500 ) NOT NULL,
	`phone`	varchar ( 500 ) NOT NULL,
	`address`	varchar ( 500 ) NOT NULL,
	`user_id`	integer NOT NULL UNIQUE,
	`location`	varchar ( 500 ) NOT NULL,
	FOREIGN KEY(`user_id`) REFERENCES `auth_user`(`id`)
);
INSERT INTO `foodtaskerapp_driver` VALUES (1,'https://graph.facebook.com/1681438445516197/picture?type=large','','',4,'217389, 3294802');
INSERT INTO `foodtaskerapp_driver` VALUES (2,'https://graph.facebook.com/1681438445516197/picture?type=large','972607988','Hà Nội, Hoàn Kiếm, Hà Nội, Việt Nam',7,'21.027763, 105.834160');
INSERT INTO `foodtaskerapp_driver` VALUES (3,'https://graph.facebook.com/1681438445516197/picture?type=large','972607988','Ha Noi',8,'21.027763, 105.834160');
CREATE TABLE IF NOT EXISTS `foodtaskerapp_customer` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`avatar`	varchar ( 500 ) NOT NULL,
	`phone`	varchar ( 500 ) NOT NULL,
	`address`	varchar ( 500 ) NOT NULL,
	`user_id`	integer NOT NULL UNIQUE,
	FOREIGN KEY(`user_id`) REFERENCES `auth_user`(`id`)
);
INSERT INTO `foodtaskerapp_customer` VALUES (1,'https://graph.facebook.com/1681438445516197/picture?type=large','','',4);
INSERT INTO `foodtaskerapp_customer` VALUES (2,'https://graph.facebook.com/1681438445516197/picture?type=large','972607988','Ha Noi',9);
CREATE TABLE IF NOT EXISTS `django_session` (
	`session_key`	varchar ( 40 ) NOT NULL,
	`session_data`	text NOT NULL,
	`expire_date`	datetime NOT NULL,
	PRIMARY KEY(`session_key`)
);
INSERT INTO `django_session` VALUES ('m0ll3vcxjpyo5pkz8p0gzdi54a7y2cvg','ZjRmZjJjYWJmZjNmM2ZhMGIxMTZhM2IyOTNkODI0ODEyNTY1ODEwZjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiIwZDMwYjFmMmM0NGMzNDIzZWE1NGJmOTQxOTVjZjhkYzU0NGIyMTEzIn0=','2016-09-26 04:54:43.331763');
INSERT INTO `django_session` VALUES ('ykxw7w79olvz4rr6y6q3d78jb6o3j443','YTE3YWVhMjBkNzEwNTVlMjI2MTMzMzYzNzNhOWZkOWQ0OWExMGNjYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjUiLCJfYXV0aF91c2VyX2hhc2giOiJhOGZkNDczMzIwNTRhYzdhMGUzZjgyMTA0OWUxMDJlNzVmZWNjMmNjIn0=','2016-09-28 11:25:10.578255');
INSERT INTO `django_session` VALUES ('t3215kcubp1hccwqu4ivjk4php8twdqh','MjM5MzdhMDcwMGVhYzM3ZTA3ZjQ3M2Y2NTUwYzllZjU2ZDEwNzkyMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjBkMzBiMWYyYzQ0YzM0MjNlYTU0YmY5NDE5NWNmOGRjNTQ0YjIxMTMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-09-28 11:32:46.460247');
INSERT INTO `django_session` VALUES ('mahuok2l256wx8gzr6ncq6onz9lejrm9','Yzg3NzdlMjc5NWRjZGYyYTcyZGRkNmQwMWYwNTRhODIwNmM2ZTVkNzp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NTgxMzVjZDkzZjRkMjFmMGI3ZTAyNGM5OWIyNTdlODVkYjQyMDQ4In0=','2018-11-12 16:07:20.843734');
INSERT INTO `django_session` VALUES ('72p3ohgu12660aov4310w4r73b2991iz','Yzg3NzdlMjc5NWRjZGYyYTcyZGRkNmQwMWYwNTRhODIwNmM2ZTVkNzp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NTgxMzVjZDkzZjRkMjFmMGI3ZTAyNGM5OWIyNTdlODVkYjQyMDQ4In0=','2018-11-13 06:01:58.450906');
INSERT INTO `django_session` VALUES ('6lt1t0d6nuydhokphnpotdjbns4pvqjt','MTZiZjQ5OGJmODM3Zjk5MjUzZTZhYzExYzBlNzBmMWEwM2YzMzgxMzp7Il9hdXRoX3VzZXJfaWQiOiI4IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwNTdiNmYyNWZmYjY2NzBjZDdjZjVkYTg0OTkzMDJkN2I1ZTJkMjMzIn0=','2018-11-13 06:27:02.671455');
CREATE TABLE IF NOT EXISTS `django_migrations` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`app`	varchar ( 255 ) NOT NULL,
	`name`	varchar ( 255 ) NOT NULL,
	`applied`	datetime NOT NULL
);
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-09-12 01:52:53.717242');
INSERT INTO `django_migrations` VALUES (2,'auth','0001_initial','2016-09-12 01:52:53.746799');
INSERT INTO `django_migrations` VALUES (3,'admin','0001_initial','2016-09-12 01:52:53.768452');
INSERT INTO `django_migrations` VALUES (4,'admin','0002_logentry_remove_auto_add','2016-09-12 01:52:53.792302');
INSERT INTO `django_migrations` VALUES (5,'contenttypes','0002_remove_content_type_name','2016-09-12 01:52:53.841894');
INSERT INTO `django_migrations` VALUES (6,'auth','0002_alter_permission_name_max_length','2016-09-12 01:52:53.861537');
INSERT INTO `django_migrations` VALUES (7,'auth','0003_alter_user_email_max_length','2016-09-12 01:52:53.880619');
INSERT INTO `django_migrations` VALUES (8,'auth','0004_alter_user_username_opts','2016-09-12 01:52:53.902420');
INSERT INTO `django_migrations` VALUES (9,'auth','0005_alter_user_last_login_null','2016-09-12 01:52:53.924039');
INSERT INTO `django_migrations` VALUES (10,'auth','0006_require_contenttypes_0002','2016-09-12 01:52:53.927225');
INSERT INTO `django_migrations` VALUES (11,'auth','0007_alter_validators_add_error_messages','2016-09-12 01:52:53.947264');
INSERT INTO `django_migrations` VALUES (12,'auth','0008_alter_user_username_max_length','2016-09-12 01:52:53.988400');
INSERT INTO `django_migrations` VALUES (13,'sessions','0001_initial','2016-09-12 01:52:53.995229');
INSERT INTO `django_migrations` VALUES (14,'foodtaskerapp','0001_initial','2016-09-12 05:07:37.008116');
INSERT INTO `django_migrations` VALUES (15,'oauth2_provider','0001_initial','2016-09-12 13:03:47.279481');
INSERT INTO `django_migrations` VALUES (16,'oauth2_provider','0002_08_updates','2016-09-12 13:03:47.364867');
INSERT INTO `django_migrations` VALUES (17,'default','0001_initial','2016-09-12 13:03:47.455007');
INSERT INTO `django_migrations` VALUES (18,'default','0002_add_related_name','2016-09-12 13:03:47.484282');
INSERT INTO `django_migrations` VALUES (19,'default','0003_alter_email_max_length','2016-09-12 13:03:47.497248');
INSERT INTO `django_migrations` VALUES (20,'default','0004_auto_20160423_0400','2016-09-12 13:03:47.530959');
INSERT INTO `django_migrations` VALUES (21,'social_auth','0005_auto_20160727_2333','2016-09-12 13:03:47.544972');
INSERT INTO `django_migrations` VALUES (22,'social_auth','0002_add_related_name','2016-09-12 13:03:47.547854');
INSERT INTO `django_migrations` VALUES (23,'social_auth','0003_alter_email_max_length','2016-09-12 13:03:47.550828');
INSERT INTO `django_migrations` VALUES (24,'social_auth','0001_initial','2016-09-12 13:03:47.554133');
INSERT INTO `django_migrations` VALUES (25,'social_auth','0004_auto_20160423_0400','2016-09-12 13:03:47.556087');
INSERT INTO `django_migrations` VALUES (26,'foodtaskerapp','0002_customer_driver','2016-09-13 02:45:34.229330');
INSERT INTO `django_migrations` VALUES (27,'foodtaskerapp','0003_meal','2016-09-13 11:54:23.295824');
INSERT INTO `django_migrations` VALUES (28,'foodtaskerapp','0004_order','2016-09-14 00:14:50.445708');
INSERT INTO `django_migrations` VALUES (29,'foodtaskerapp','0005_orderdetails','2016-09-14 00:19:37.628466');
INSERT INTO `django_migrations` VALUES (30,'foodtaskerapp','0006_auto_20160914_1046','2016-09-14 10:46:30.999678');
INSERT INTO `django_migrations` VALUES (31,'foodtaskerapp','0007_driver_location','2016-09-15 04:35:17.383536');
INSERT INTO `django_migrations` VALUES (32,'oauth2_provider','0003_auto_20160316_1503','2018-10-29 07:28:59.577270');
INSERT INTO `django_migrations` VALUES (33,'oauth2_provider','0004_auto_20160525_1623','2018-10-29 07:28:59.824936');
INSERT INTO `django_migrations` VALUES (34,'oauth2_provider','0005_auto_20170514_1141','2018-10-29 07:29:00.657517');
INSERT INTO `django_migrations` VALUES (35,'social_django','0006_partial','2018-10-29 08:26:39.801534');
INSERT INTO `django_migrations` VALUES (36,'social_django','0005_auto_20160727_2333','2018-10-29 08:26:39.808275');
INSERT INTO `django_migrations` VALUES (37,'social_django','0001_initial','2018-10-29 08:26:39.812233');
INSERT INTO `django_migrations` VALUES (38,'social_django','0004_auto_20160423_0400','2018-10-29 08:26:39.817175');
INSERT INTO `django_migrations` VALUES (39,'social_django','0002_add_related_name','2018-10-29 08:26:39.821742');
INSERT INTO `django_migrations` VALUES (40,'social_django','0003_alter_email_max_length','2018-10-29 08:26:39.828373');
CREATE TABLE IF NOT EXISTS `django_content_type` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`app_label`	varchar ( 100 ) NOT NULL,
	`model`	varchar ( 100 ) NOT NULL
);
INSERT INTO `django_content_type` VALUES (1,'admin','logentry');
INSERT INTO `django_content_type` VALUES (2,'auth','user');
INSERT INTO `django_content_type` VALUES (3,'auth','permission');
INSERT INTO `django_content_type` VALUES (4,'auth','group');
INSERT INTO `django_content_type` VALUES (5,'contenttypes','contenttype');
INSERT INTO `django_content_type` VALUES (6,'sessions','session');
INSERT INTO `django_content_type` VALUES (7,'foodtaskerapp','restaurant');
INSERT INTO `django_content_type` VALUES (8,'oauth2_provider','grant');
INSERT INTO `django_content_type` VALUES (9,'oauth2_provider','application');
INSERT INTO `django_content_type` VALUES (10,'oauth2_provider','refreshtoken');
INSERT INTO `django_content_type` VALUES (11,'oauth2_provider','accesstoken');
INSERT INTO `django_content_type` VALUES (12,'social_auth','nonce');
INSERT INTO `django_content_type` VALUES (13,'social_auth','code');
INSERT INTO `django_content_type` VALUES (14,'social_auth','usersocialauth');
INSERT INTO `django_content_type` VALUES (15,'social_auth','association');
INSERT INTO `django_content_type` VALUES (16,'foodtaskerapp','customer');
INSERT INTO `django_content_type` VALUES (17,'foodtaskerapp','driver');
INSERT INTO `django_content_type` VALUES (18,'foodtaskerapp','meal');
INSERT INTO `django_content_type` VALUES (19,'foodtaskerapp','order');
INSERT INTO `django_content_type` VALUES (20,'foodtaskerapp','orderdetails');
INSERT INTO `django_content_type` VALUES (21,'social_django','association');
INSERT INTO `django_content_type` VALUES (22,'social_django','code');
INSERT INTO `django_content_type` VALUES (23,'social_django','nonce');
INSERT INTO `django_content_type` VALUES (24,'social_django','usersocialauth');
INSERT INTO `django_content_type` VALUES (25,'social_django','partial');
CREATE TABLE IF NOT EXISTS `django_admin_log` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`object_id`	text,
	`object_repr`	varchar ( 200 ) NOT NULL,
	`action_flag`	smallint unsigned NOT NULL,
	`change_message`	text NOT NULL,
	`content_type_id`	integer,
	`user_id`	integer NOT NULL,
	`action_time`	datetime NOT NULL,
	FOREIGN KEY(`user_id`) REFERENCES `auth_user`(`id`),
	FOREIGN KEY(`content_type_id`) REFERENCES `django_content_type`(`id`)
);
INSERT INTO `django_admin_log` VALUES (1,'1','tVs0Jfp851wTS9YeZKSi40U78jmzgpw2Hbh121iJ',1,'[{"added": {}}]',9,1,'2016-09-12 13:23:36.074455');
INSERT INTO `django_admin_log` VALUES (2,'3','IronmanDemo',3,'',2,1,'2016-09-13 02:25:25.725728');
INSERT INTO `django_admin_log` VALUES (3,'1','admin',2,'[{"changed": {"fields": ["first_name", "last_name"]}}]',2,1,'2016-09-13 10:40:55.103439');
INSERT INTO `django_admin_log` VALUES (4,'1','Pho',2,'[{"changed": {"fields": ["user"]}}]',7,1,'2016-09-13 10:42:01.037578');
INSERT INTO `django_admin_log` VALUES (5,'1','Pho',2,'[{"changed": {"fields": ["user"]}}]',7,1,'2016-09-13 10:42:13.647654');
INSERT INTO `django_admin_log` VALUES (6,'1','admin',2,'[{"changed": {"fields": ["first_name", "last_name"]}}]',2,1,'2016-09-13 10:42:22.197656');
INSERT INTO `django_admin_log` VALUES (7,'1','admin',2,'[{"changed": {"fields": ["first_name", "last_name"]}}]',2,1,'2016-09-13 10:43:43.354543');
INSERT INTO `django_admin_log` VALUES (8,'1','Pho',2,'[{"changed": {"fields": ["user"]}}]',7,1,'2016-09-13 10:43:56.366191');
INSERT INTO `django_admin_log` VALUES (9,'1','1',1,'[{"added": {}}]',19,1,'2016-09-14 00:21:56.753818');
INSERT INTO `django_admin_log` VALUES (10,'1','1',1,'[{"added": {}}]',20,1,'2016-09-14 00:22:29.870379');
INSERT INTO `django_admin_log` VALUES (11,'1','1',2,'[{"changed": {"fields": ["status"]}}]',19,1,'2016-09-14 00:43:05.206799');
INSERT INTO `django_admin_log` VALUES (12,'5','CfWNCLGBwFjVZKep8pUFQbXLXvG36s',2,'[{"changed": {"fields": ["expires"]}}]',11,1,'2016-09-14 05:03:50.968782');
INSERT INTO `django_admin_log` VALUES (13,'4','Rzkm1a1mwoBkNdB2QvR0RylVsLbQL4',2,'[{"changed": {"fields": ["expires"]}}]',11,1,'2016-09-14 08:03:02.901225');
INSERT INTO `django_admin_log` VALUES (14,'5','CfWNCLGBwFjVZKep8pUFQbXLXvG36s',2,'[{"changed": {"fields": ["expires"]}}]',11,1,'2016-09-14 09:54:30.409620');
INSERT INTO `django_admin_log` VALUES (15,'1','Burger King',2,'[{"changed": {"fields": ["price"]}}]',18,1,'2016-09-14 09:55:44.857841');
INSERT INTO `django_admin_log` VALUES (16,'1','1',3,'',19,1,'2016-09-14 10:33:55.245664');
INSERT INTO `django_admin_log` VALUES (17,'1','1',3,'',19,1,'2016-09-14 11:24:31.210995');
INSERT INTO `django_admin_log` VALUES (18,'2','2',3,'',19,1,'2016-09-14 11:32:55.470490');
INSERT INTO `django_admin_log` VALUES (19,'3','3',3,'',19,1,'2016-09-14 11:44:46.269873');
INSERT INTO `django_admin_log` VALUES (20,'5','CfWNCLGBwFjVZKep8pUFQbXLXvG36s',2,'[{"changed": {"fields": ["expires"]}}]',11,1,'2016-09-14 12:27:48.132347');
INSERT INTO `django_admin_log` VALUES (21,'4','4',2,'[{"changed": {"fields": ["status"]}}]',19,1,'2016-09-15 05:05:03.261483');
INSERT INTO `django_admin_log` VALUES (22,'4','4',2,'[{"changed": {"fields": ["status"]}}]',19,1,'2016-09-15 12:41:40.685809');
INSERT INTO `django_admin_log` VALUES (23,'4','4',3,'',19,1,'2016-09-15 14:08:28.079549');
INSERT INTO `django_admin_log` VALUES (24,'6','gstearmit',3,'',2,7,'2018-10-29 08:46:41.921172');
INSERT INTO `django_admin_log` VALUES (25,'5','CfWNCLGBwFjVZKep8pUFQbXLXvG36s',3,'',11,7,'2018-10-29 10:28:19.284423');
INSERT INTO `django_admin_log` VALUES (26,'4','Rzkm1a1mwoBkNdB2QvR0RylVsLbQL4',3,'',11,7,'2018-10-29 10:28:19.307597');
INSERT INTO `django_admin_log` VALUES (27,'2','A0uTKbNsugs0qmJCf0oGcIv4ACDpVr',3,'',11,7,'2018-10-29 10:28:19.312251');
INSERT INTO `django_admin_log` VALUES (28,'1','tVs0Jfp851wTS9YeZKSi40U78jmzgpw2Hbh121iJ',3,'',9,7,'2018-10-29 10:30:19.606941');
INSERT INTO `django_admin_log` VALUES (29,'2','Xq2VYWcynvzoDr9WHsynImVDHPOXagMQ66WBDxCC',1,'[{"added": {}}]',9,7,'2018-10-29 16:04:04.533591');
INSERT INTO `django_admin_log` VALUES (30,'3','C8680P8fxrLpKXlTOtiGVgvnkqK1eFO5Tvu9bGEa',1,'[{"added": {}}]',9,7,'2018-10-29 16:04:39.487618');
INSERT INTO `django_admin_log` VALUES (31,'4','Ironman',1,'[{"added": {}}]',9,7,'2018-10-30 06:06:42.824874');
INSERT INTO `django_admin_log` VALUES (32,'4','Ironman',2,'[]',9,7,'2018-10-30 06:09:52.646378');
INSERT INTO `django_admin_log` VALUES (33,'3','C8680P8fxrLpKXlTOtiGVgvnkqK1eFO5Tvu9bGEa',3,'',9,7,'2018-10-30 06:10:03.103851');
INSERT INTO `django_admin_log` VALUES (34,'2','Xq2VYWcynvzoDr9WHsynImVDHPOXagMQ66WBDxCC',3,'',9,7,'2018-10-30 06:10:03.108891');
INSERT INTO `django_admin_log` VALUES (35,'4','Ironman',2,'[{"changed": {"fields": ["redirect_uris", "authorization_grant_type"]}}]',9,7,'2018-10-30 06:10:51.089573');
INSERT INTO `django_admin_log` VALUES (36,'4','Ironman',2,'[{"changed": {"fields": ["authorization_grant_type"]}}]',9,7,'2018-10-30 06:15:00.091221');
INSERT INTO `django_admin_log` VALUES (37,'5','adv.globalmedia2',1,'[{"added": {}}]',9,7,'2018-10-30 06:16:11.364980');
INSERT INTO `django_admin_log` VALUES (38,'2','',1,'[{"added": {}}]',17,7,'2018-10-30 06:33:15.435848');
INSERT INTO `django_admin_log` VALUES (39,'7','adv.globalmedia2',2,'[{"changed": {"fields": ["username", "first_name", "last_name", "last_login"]}}]',2,7,'2018-10-30 06:35:08.592227');
INSERT INTO `django_admin_log` VALUES (40,'7','adv.globalmedia2',2,'[{"changed": {"fields": ["first_name", "last_name", "last_login"]}}]',2,7,'2018-10-30 06:36:44.150545');
INSERT INTO `django_admin_log` VALUES (41,'8','hoangphuc',2,'[]',2,7,'2018-10-30 06:36:58.860733');
INSERT INTO `django_admin_log` VALUES (42,'6','6',1,'[{"added": {}}]',19,7,'2018-10-30 06:38:32.365881');
INSERT INTO `django_admin_log` VALUES (43,'12','12',1,'[{"added": {}}]',20,7,'2018-10-30 06:39:14.044143');
INSERT INTO `django_admin_log` VALUES (44,'3','Jackly Hoang',1,'[{"added": {}}]',17,7,'2018-10-30 06:39:57.278854');
INSERT INTO `django_admin_log` VALUES (45,'12','12',2,'[{"changed": {"fields": ["sub_total"]}}]',20,7,'2018-10-30 06:41:31.540022');
INSERT INTO `django_admin_log` VALUES (46,'6','6',2,'[{"changed": {"fields": ["total"]}}]',19,7,'2018-10-30 06:42:00.366177');
INSERT INTO `django_admin_log` VALUES (47,'6','JacklyHoang',1,'[{"added": {}}]',9,7,'2018-10-30 07:11:09.804369');
INSERT INTO `django_admin_log` VALUES (48,'9','weshop.dev',1,'[{"added": {}}]',2,7,'2018-10-30 07:13:28.155081');
INSERT INTO `django_admin_log` VALUES (49,'9','weshop.dev',2,'[{"changed": {"fields": ["first_name", "last_name", "email", "is_staff", "is_superuser"]}}]',2,7,'2018-10-30 07:13:58.785351');
INSERT INTO `django_admin_log` VALUES (50,'2','weshop deverlop',1,'[{"added": {}}]',16,7,'2018-10-30 07:14:44.939279');
INSERT INTO `django_admin_log` VALUES (51,'7','weshop.devFoodTasker',1,'[{"added": {}}]',9,7,'2018-10-30 07:15:29.108148');
INSERT INTO `django_admin_log` VALUES (52,'7','weshop.devFoodTasker',2,'[{"changed": {"fields": ["client_type", "authorization_grant_type"]}}]',9,7,'2018-10-30 07:16:39.299522');
INSERT INTO `django_admin_log` VALUES (53,'7','weshop.devFoodTasker',2,'[{"changed": {"fields": ["client_type"]}}]',9,7,'2018-10-30 07:17:10.538623');
INSERT INTO `django_admin_log` VALUES (54,'7','weshop.devFoodTasker',2,'[{"changed": {"fields": ["client_type"]}}]',9,7,'2018-10-30 07:18:57.894852');
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`user_id`	integer NOT NULL,
	`permission_id`	integer NOT NULL,
	FOREIGN KEY(`user_id`) REFERENCES `auth_user`(`id`),
	FOREIGN KEY(`permission_id`) REFERENCES `auth_permission`(`id`)
);
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`user_id`	integer NOT NULL,
	`group_id`	integer NOT NULL,
	FOREIGN KEY(`group_id`) REFERENCES `auth_group`(`id`),
	FOREIGN KEY(`user_id`) REFERENCES `auth_user`(`id`)
);
CREATE TABLE IF NOT EXISTS `auth_user` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`password`	varchar ( 128 ) NOT NULL,
	`last_login`	datetime,
	`is_superuser`	bool NOT NULL,
	`first_name`	varchar ( 30 ) NOT NULL,
	`last_name`	varchar ( 30 ) NOT NULL,
	`email`	varchar ( 254 ) NOT NULL,
	`is_staff`	bool NOT NULL,
	`is_active`	bool NOT NULL,
	`date_joined`	datetime NOT NULL,
	`username`	varchar ( 150 ) NOT NULL UNIQUE
);
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$30000$cMUfjZYWYQfE$3P8nRK7xfwFIQVfV7CvYe+ikCBRikjLYdLiopS4cJp4=','2016-09-14 11:32:46.457125',1,'Leo','Trieu','admin@code4startup.com',1,1,'2016-09-12 01:53:50','admin');
INSERT INTO `auth_user` VALUES (2,'pbkdf2_sha256$30000$eSY4vZ4Oci9B$LgdIwuA+CEtVQewNWv4JlIlj0wn1uTSHmXTR0doRlJA=','2016-09-12 10:28:16.561267',0,'Leo','Trieu','leo@code4startup.com',0,1,'2016-09-12 10:28:16.262187','leotrieu');
INSERT INTO `auth_user` VALUES (4,'!2WyqDChnqzEcg83AtF181xBzogKxqs8JCUVoD9g9',NULL,0,'Ironman','Demo','demo.code4startup@gmail.com',0,1,'2016-09-13 02:26:51.748254','IronmanDemo');
INSERT INTO `auth_user` VALUES (5,'pbkdf2_sha256$30000$W2XXZFtZIbVn$7uNdptQuqffXVsAU8qIL7QCHllynBWNsuY3SOjvj5F8=','2016-09-14 11:25:10.575462',0,'Alan','Smith','alan@gmail.com',0,1,'2016-09-13 11:16:10.001121','alan');
INSERT INTO `auth_user` VALUES (7,'pbkdf2_sha256$30000$xJ7gjr0MAKP9$Xt1un4yuj9z80Xyi1c3S3ye7FHRvLYWe+VOSnx78udY=','2018-10-31 06:00:00',1,'adv','globalmedia','adv.globalmedia2@gmail.com',1,1,'2018-10-29 08:16:43','adv.globalmedia2');
INSERT INTO `auth_user` VALUES (8,'pbkdf2_sha256$30000$3lVn1pvjSXYC$l5PFuZ43bnquIx5/au0CGMh+VXZt80XV2wcDoEX2jC8=','2018-10-30 06:27:02',0,'Jackly','Hoang','phuchc@peacesoft.net',0,1,'2018-10-30 06:19:55','hoangphuc');
INSERT INTO `auth_user` VALUES (9,'pbkdf2_sha256$30000$fqaebZ059T1F$AaCEQKwmVpmMt8E6uBcWBwDZ81ecDM+G7tk2wq8NxQY=',NULL,1,'weshop','deverlop','weshop.dev@peacesoft.net',1,1,'2018-10-30 07:13:28','weshop.dev');
CREATE TABLE IF NOT EXISTS `auth_permission` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`content_type_id`	integer NOT NULL,
	`codename`	varchar ( 100 ) NOT NULL,
	`name`	varchar ( 255 ) NOT NULL,
	FOREIGN KEY(`content_type_id`) REFERENCES `django_content_type`(`id`)
);
INSERT INTO `auth_permission` VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO `auth_permission` VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO `auth_permission` VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO `auth_permission` VALUES (4,2,'add_user','Can add user');
INSERT INTO `auth_permission` VALUES (5,2,'change_user','Can change user');
INSERT INTO `auth_permission` VALUES (6,2,'delete_user','Can delete user');
INSERT INTO `auth_permission` VALUES (7,3,'add_permission','Can add permission');
INSERT INTO `auth_permission` VALUES (8,3,'change_permission','Can change permission');
INSERT INTO `auth_permission` VALUES (9,3,'delete_permission','Can delete permission');
INSERT INTO `auth_permission` VALUES (10,4,'add_group','Can add group');
INSERT INTO `auth_permission` VALUES (11,4,'change_group','Can change group');
INSERT INTO `auth_permission` VALUES (12,4,'delete_group','Can delete group');
INSERT INTO `auth_permission` VALUES (13,5,'add_contenttype','Can add content type');
INSERT INTO `auth_permission` VALUES (14,5,'change_contenttype','Can change content type');
INSERT INTO `auth_permission` VALUES (15,5,'delete_contenttype','Can delete content type');
INSERT INTO `auth_permission` VALUES (16,6,'add_session','Can add session');
INSERT INTO `auth_permission` VALUES (17,6,'change_session','Can change session');
INSERT INTO `auth_permission` VALUES (18,6,'delete_session','Can delete session');
INSERT INTO `auth_permission` VALUES (19,7,'add_restaurant','Can add restaurant');
INSERT INTO `auth_permission` VALUES (20,7,'change_restaurant','Can change restaurant');
INSERT INTO `auth_permission` VALUES (21,7,'delete_restaurant','Can delete restaurant');
INSERT INTO `auth_permission` VALUES (22,8,'add_grant','Can add grant');
INSERT INTO `auth_permission` VALUES (23,8,'change_grant','Can change grant');
INSERT INTO `auth_permission` VALUES (24,8,'delete_grant','Can delete grant');
INSERT INTO `auth_permission` VALUES (25,9,'add_application','Can add application');
INSERT INTO `auth_permission` VALUES (26,9,'change_application','Can change application');
INSERT INTO `auth_permission` VALUES (27,9,'delete_application','Can delete application');
INSERT INTO `auth_permission` VALUES (28,10,'add_refreshtoken','Can add refresh token');
INSERT INTO `auth_permission` VALUES (29,10,'change_refreshtoken','Can change refresh token');
INSERT INTO `auth_permission` VALUES (30,10,'delete_refreshtoken','Can delete refresh token');
INSERT INTO `auth_permission` VALUES (31,11,'add_accesstoken','Can add access token');
INSERT INTO `auth_permission` VALUES (32,11,'change_accesstoken','Can change access token');
INSERT INTO `auth_permission` VALUES (33,11,'delete_accesstoken','Can delete access token');
INSERT INTO `auth_permission` VALUES (34,12,'add_nonce','Can add nonce');
INSERT INTO `auth_permission` VALUES (35,12,'change_nonce','Can change nonce');
INSERT INTO `auth_permission` VALUES (36,12,'delete_nonce','Can delete nonce');
INSERT INTO `auth_permission` VALUES (37,13,'add_code','Can add code');
INSERT INTO `auth_permission` VALUES (38,13,'change_code','Can change code');
INSERT INTO `auth_permission` VALUES (39,13,'delete_code','Can delete code');
INSERT INTO `auth_permission` VALUES (40,14,'add_usersocialauth','Can add user social auth');
INSERT INTO `auth_permission` VALUES (41,14,'change_usersocialauth','Can change user social auth');
INSERT INTO `auth_permission` VALUES (42,14,'delete_usersocialauth','Can delete user social auth');
INSERT INTO `auth_permission` VALUES (43,15,'add_association','Can add association');
INSERT INTO `auth_permission` VALUES (44,15,'change_association','Can change association');
INSERT INTO `auth_permission` VALUES (45,15,'delete_association','Can delete association');
INSERT INTO `auth_permission` VALUES (46,16,'add_customer','Can add customer');
INSERT INTO `auth_permission` VALUES (47,16,'change_customer','Can change customer');
INSERT INTO `auth_permission` VALUES (48,16,'delete_customer','Can delete customer');
INSERT INTO `auth_permission` VALUES (49,17,'add_driver','Can add driver');
INSERT INTO `auth_permission` VALUES (50,17,'change_driver','Can change driver');
INSERT INTO `auth_permission` VALUES (51,17,'delete_driver','Can delete driver');
INSERT INTO `auth_permission` VALUES (52,18,'add_meal','Can add meal');
INSERT INTO `auth_permission` VALUES (53,18,'change_meal','Can change meal');
INSERT INTO `auth_permission` VALUES (54,18,'delete_meal','Can delete meal');
INSERT INTO `auth_permission` VALUES (55,19,'add_order','Can add order');
INSERT INTO `auth_permission` VALUES (56,19,'change_order','Can change order');
INSERT INTO `auth_permission` VALUES (57,19,'delete_order','Can delete order');
INSERT INTO `auth_permission` VALUES (58,20,'add_orderdetails','Can add order details');
INSERT INTO `auth_permission` VALUES (59,20,'change_orderdetails','Can change order details');
INSERT INTO `auth_permission` VALUES (60,20,'delete_orderdetails','Can delete order details');
INSERT INTO `auth_permission` VALUES (61,21,'add_association','Can add association');
INSERT INTO `auth_permission` VALUES (62,21,'change_association','Can change association');
INSERT INTO `auth_permission` VALUES (63,21,'delete_association','Can delete association');
INSERT INTO `auth_permission` VALUES (64,22,'add_code','Can add code');
INSERT INTO `auth_permission` VALUES (65,22,'change_code','Can change code');
INSERT INTO `auth_permission` VALUES (66,22,'delete_code','Can delete code');
INSERT INTO `auth_permission` VALUES (67,23,'add_nonce','Can add nonce');
INSERT INTO `auth_permission` VALUES (68,23,'change_nonce','Can change nonce');
INSERT INTO `auth_permission` VALUES (69,23,'delete_nonce','Can delete nonce');
INSERT INTO `auth_permission` VALUES (70,24,'add_usersocialauth','Can add user social auth');
INSERT INTO `auth_permission` VALUES (71,24,'change_usersocialauth','Can change user social auth');
INSERT INTO `auth_permission` VALUES (72,24,'delete_usersocialauth','Can delete user social auth');
INSERT INTO `auth_permission` VALUES (73,25,'add_partial','Can add partial');
INSERT INTO `auth_permission` VALUES (74,25,'change_partial','Can change partial');
INSERT INTO `auth_permission` VALUES (75,25,'delete_partial','Can delete partial');
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`group_id`	integer NOT NULL,
	`permission_id`	integer NOT NULL,
	FOREIGN KEY(`group_id`) REFERENCES `auth_group`(`id`),
	FOREIGN KEY(`permission_id`) REFERENCES `auth_permission`(`id`)
);
CREATE TABLE IF NOT EXISTS `auth_group` (
	`id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`name`	varchar ( 80 ) NOT NULL UNIQUE
);
CREATE UNIQUE INDEX IF NOT EXISTS `social_auth_usersocialauth_provider_e6b5e668_uniq` ON `social_auth_usersocialauth` (
	`provider`,
	`uid`
);
CREATE INDEX IF NOT EXISTS `social_auth_usersocialauth_e8701ad4` ON `social_auth_usersocialauth` (
	`user_id`
);
CREATE INDEX IF NOT EXISTS `social_auth_partial_94a08da1` ON `social_auth_partial` (
	`token`
);
CREATE UNIQUE INDEX IF NOT EXISTS `social_auth_nonce_server_url_f6284463_uniq` ON `social_auth_nonce` (
	`server_url`,
	`timestamp`,
	`salt`
);
CREATE UNIQUE INDEX IF NOT EXISTS `social_auth_code_email_801b2d02_uniq` ON `social_auth_code` (
	`email`,
	`code`
);
CREATE INDEX IF NOT EXISTS `social_auth_code_c1336794` ON `social_auth_code` (
	`code`
);
CREATE UNIQUE INDEX IF NOT EXISTS `social_auth_association_server_url_078befa2_uniq` ON `social_auth_association` (
	`server_url`,
	`handle`
);
CREATE INDEX IF NOT EXISTS `oauth2_provider_refreshtoken_e8701ad4` ON `oauth2_provider_refreshtoken` (
	`user_id`
);
CREATE INDEX IF NOT EXISTS `oauth2_provider_refreshtoken_6bc0a4eb` ON `oauth2_provider_refreshtoken` (
	`application_id`
);
CREATE INDEX IF NOT EXISTS `oauth2_provider_grant_e8701ad4` ON `oauth2_provider_grant` (
	`user_id`
);
CREATE INDEX IF NOT EXISTS `oauth2_provider_grant_6bc0a4eb` ON `oauth2_provider_grant` (
	`application_id`
);
CREATE INDEX IF NOT EXISTS `oauth2_provider_application_e8701ad4` ON `oauth2_provider_application` (
	`user_id`
);
CREATE INDEX IF NOT EXISTS `oauth2_provider_application_9d667c2b` ON `oauth2_provider_application` (
	`client_secret`
);
CREATE INDEX IF NOT EXISTS `oauth2_provider_accesstoken_e8701ad4` ON `oauth2_provider_accesstoken` (
	`user_id`
);
CREATE INDEX IF NOT EXISTS `oauth2_provider_accesstoken_6bc0a4eb` ON `oauth2_provider_accesstoken` (
	`application_id`
);
CREATE INDEX IF NOT EXISTS `foodtaskerapp_orderdetails_69dfcb07` ON `foodtaskerapp_orderdetails` (
	`order_id`
);
CREATE INDEX IF NOT EXISTS `foodtaskerapp_orderdetails_6894eaee` ON `foodtaskerapp_orderdetails` (
	`meal_id`
);
CREATE INDEX IF NOT EXISTS `foodtaskerapp_order_ee9d9d3e` ON `foodtaskerapp_order` (
	`restaurant_id`
);
CREATE INDEX IF NOT EXISTS `foodtaskerapp_order_cb24373b` ON `foodtaskerapp_order` (
	`customer_id`
);
CREATE INDEX IF NOT EXISTS `foodtaskerapp_order_17565772` ON `foodtaskerapp_order` (
	`driver_id`
);
CREATE INDEX IF NOT EXISTS `foodtaskerapp_meal_ee9d9d3e` ON `foodtaskerapp_meal` (
	`restaurant_id`
);
CREATE INDEX IF NOT EXISTS `django_session_de54fa62` ON `django_session` (
	`expire_date`
);
CREATE UNIQUE INDEX IF NOT EXISTS `django_content_type_app_label_76bd3d3b_uniq` ON `django_content_type` (
	`app_label`,
	`model`
);
CREATE INDEX IF NOT EXISTS `django_admin_log_e8701ad4` ON `django_admin_log` (
	`user_id`
);
CREATE INDEX IF NOT EXISTS `django_admin_log_417f1b1c` ON `django_admin_log` (
	`content_type_id`
);
CREATE UNIQUE INDEX IF NOT EXISTS `auth_user_user_permissions_user_id_14a6b632_uniq` ON `auth_user_user_permissions` (
	`user_id`,
	`permission_id`
);
CREATE INDEX IF NOT EXISTS `auth_user_user_permissions_e8701ad4` ON `auth_user_user_permissions` (
	`user_id`
);
CREATE INDEX IF NOT EXISTS `auth_user_user_permissions_8373b171` ON `auth_user_user_permissions` (
	`permission_id`
);
CREATE UNIQUE INDEX IF NOT EXISTS `auth_user_groups_user_id_94350c0c_uniq` ON `auth_user_groups` (
	`user_id`,
	`group_id`
);
CREATE INDEX IF NOT EXISTS `auth_user_groups_e8701ad4` ON `auth_user_groups` (
	`user_id`
);
CREATE INDEX IF NOT EXISTS `auth_user_groups_0e939a4f` ON `auth_user_groups` (
	`group_id`
);
CREATE UNIQUE INDEX IF NOT EXISTS `auth_permission_content_type_id_01ab375a_uniq` ON `auth_permission` (
	`content_type_id`,
	`codename`
);
CREATE INDEX IF NOT EXISTS `auth_permission_417f1b1c` ON `auth_permission` (
	`content_type_id`
);
CREATE UNIQUE INDEX IF NOT EXISTS `auth_group_permissions_group_id_0cd325b0_uniq` ON `auth_group_permissions` (
	`group_id`,
	`permission_id`
);
CREATE INDEX IF NOT EXISTS `auth_group_permissions_8373b171` ON `auth_group_permissions` (
	`permission_id`
);
CREATE INDEX IF NOT EXISTS `auth_group_permissions_0e939a4f` ON `auth_group_permissions` (
	`group_id`
);
COMMIT;
