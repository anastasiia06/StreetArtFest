-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: fest_app
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '98572bee-1957-11f1-af37-106530e8e8fc:1-518';

--
-- Table structure for table `artist_applications`
--

DROP TABLE IF EXISTS `artist_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist_applications` (
  `application_id` int NOT NULL AUTO_INCREMENT,
  `art_type` varchar(50) NOT NULL,
  `comment` tinytext,
  `Status` enum('Очікує','Відхилено','Прийнято') NOT NULL DEFAULT 'Очікує',
  `festival_id` int NOT NULL,
  `artist_id` int NOT NULL,
  PRIMARY KEY (`application_id`),
  KEY `fk_artist_applications_festivals1_idx` (`festival_id`),
  KEY `fk_artist_applications_users1_idx` (`artist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_applications`
--

LOCK TABLES `artist_applications` WRITE;
/*!40000 ALTER TABLE `artist_applications` DISABLE KEYS */;
INSERT INTO `artist_applications` VALUES (1,'Музика','Готовий виступити з авторськими треками.','Очікує',1,4),(2,'Танець','Планую вуличний танцювальний перформанс.','Прийнято',1,9),(3,'Графіті','Хочу створити мурал на тематику міста.','Відхилено',3,4),(4,'Спів','Буду вдячний за можливість виступити зі своїм гуртом','Прийнято',4,4),(5,'Музика','Хочу виступити з власними треками','Очікує',6,4),(6,'Танці','Хочу виступити зі своїм колективом','Очікує',4,9);
/*!40000 ALTER TABLE `artist_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booked_locations`
--

DROP TABLE IF EXISTS `booked_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booked_locations` (
  `booked_locations_id` int NOT NULL AUTO_INCREMENT,
  `datetime_start` datetime NOT NULL,
  `datetime_end` datetime NOT NULL,
  `organizer_id` int NOT NULL,
  `festival_id` int NOT NULL,
  `location_id` int NOT NULL,
  PRIMARY KEY (`booked_locations_id`),
  KEY `fk_booked_locations_users1_idx` (`organizer_id`),
  KEY `fk_booked_locations_festivals1_idx` (`festival_id`),
  KEY `fk_booked_locations_locations1_idx` (`location_id`),
  CONSTRAINT `fk_booked_locations_users1` FOREIGN KEY (`organizer_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booked_locations`
--

LOCK TABLES `booked_locations` WRITE;
/*!40000 ALTER TABLE `booked_locations` DISABLE KEYS */;
INSERT INTO `booked_locations` VALUES (1,'2026-06-10 10:00:00','2026-06-10 18:00:00',6,1,1),(2,'2026-06-11 10:00:00','2026-06-11 18:00:00',6,1,2),(3,'2026-06-25 09:00:00','2026-06-28 09:00:00',8,4,6),(4,'2026-03-05 09:00:00','2026-03-05 18:00:00',8,2,3),(5,'2026-04-01 09:00:00','2026-04-01 22:00:00',8,2,4),(6,'2026-05-10 09:00:00','2026-05-10 22:00:00',8,3,1),(7,'2026-06-01 09:00:00','2026-06-01 23:00:00',8,3,2),(8,'2026-05-05 09:00:00','2026-05-06 18:00:00',6,5,5),(9,'2026-05-31 17:30:00','2026-06-05 14:30:00',6,2,3),(10,'2026-06-07 19:30:00','2026-06-07 22:30:00',6,10,5);
/*!40000 ALTER TABLE `booked_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `festival_events`
--

DROP TABLE IF EXISTS `festival_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `festival_events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `datetime_start` datetime NOT NULL,
  `datetime_end` datetime NOT NULL,
  `location_id` int NOT NULL,
  `festival_id` int NOT NULL,
  `artist_id` int DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `fk_festival_events_locations1_idx` (`location_id`),
  KEY `fk_festival_events_festivals1_idx` (`festival_id`),
  KEY `fk_festival_events_users1_idx` (`artist_id`),
  CONSTRAINT `fk_festival_events_locations1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `festival_events`
--

LOCK TABLES `festival_events` WRITE;
/*!40000 ALTER TABLE `festival_events` DISABLE KEYS */;
INSERT INTO `festival_events` VALUES (1,'Відкриття та Графіті-батл','2026-06-10 10:00:00','2026-06-10 12:55:00',1,1,NULL),(2,'Танцювальне шоу Марини Маркевич','2026-06-10 14:00:00','2026-06-10 16:00:00',1,1,9),(3,'Музичний сет у парку','2026-06-11 11:00:00','2026-06-11 14:00:00',2,1,4),(4,'Майстер-клас від Марії Шевченко','2026-06-11 15:00:00','2026-06-11 17:00:00',2,1,5),(5,'Урбан Перформанс','2026-03-05 12:00:00','2026-03-05 15:00:00',3,2,9),(6,'Вечір сучасної поезії та співу','2026-04-01 18:00:00','2026-04-01 20:00:00',4,2,5),(7,'Виставка \"Живе місто\"','2026-05-10 10:00:00','2026-05-10 18:00:00',1,3,4),(8,'Акустичний концерт Артема Бойка','2026-06-01 19:00:00','2026-06-01 21:00:00',2,3,4),(9,'Хіти 90-х: Велика сцена','2026-06-25 18:00:00','2026-06-25 21:00:00',6,4,NULL),(10,'Нічна дискотека \"Ретро\"','2026-06-26 21:00:00','2026-06-27 01:00:00',6,4,NULL),(11,'Закриття: Гала-шоу артистів','2026-06-27 19:00:00','2026-06-27 22:00:00',6,4,5),(12,'Вуличний виступ Артема','2026-05-05 14:00:00','2026-05-05 16:00:00',5,5,4),(13,'Арт-перформанс Марини','2026-05-06 12:00:00','2026-05-06 15:00:00',5,5,9),(15,'Закриття','2026-06-10 17:10:00','2026-06-10 17:55:00',1,1,NULL);
/*!40000 ALTER TABLE `festival_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `festivals`
--

DROP TABLE IF EXISTS `festivals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `festivals` (
  `festival_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('Заплановано','Активний','Завершено') NOT NULL,
  `description` tinytext,
  `price` decimal(10,2) NOT NULL,
  `admin_id` int NOT NULL,
  PRIMARY KEY (`festival_id`),
  KEY `fk_festivals_users_idx` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `festivals`
--

LOCK TABLES `festivals` WRITE;
/*!40000 ALTER TABLE `festivals` DISABLE KEYS */;
INSERT INTO `festivals` VALUES (1,'Dnipro Street Art Fest','Дніпро','2026-06-10','2026-06-12','Заплановано','Фестиваль вуличного мистецтва з музикою, графіті та виступами артистів.',150.00,1),(2,'Kyiv Urban Culture','Київ','2026-03-05','2026-04-07','Завершено','Фестиваль сучасного мистецтва, танців, музики та перформансів.',600.00,7),(3,'Dnipro ArtFestival','Дніпро','2026-05-05','2026-06-07','Активний','Фестиваль сучасного мистецтва, танців, музики та перформансів.',300.00,7),(4,'Покоління','Одеса','2026-06-25','2026-06-27','Заплановано','Фестиваль для поціновувачів музики 90-х',800.00,7),(5,'Lviv Art Weekend','Львів','2026-05-05','2026-05-06','Завершено','Мистецькі події, виставки та вуличні концерти.',300.00,1),(6,'NewFest','Харків','2026-06-28','2026-06-29','Заплановано','Молодіжний сучасний фестиваль: сучасна музика, цікава програма і гарні локації для фото! Не пропустіть!',500.00,0),(7,'ClassicFest2026','Одеса','2026-06-28','2026-07-04','Заплановано','Фестиваль класики: художня виставка, класичні танці та книжкові кола. Вже цього місяця! Приєднуйтесь',600.00,0),(8,'FootballFest','Київ','2026-05-10','2026-05-11','Завершено','Сучасний і цікавий фестиваль для поціновувачів цього виду спорту. ',300.00,0),(9,'Фестиваль вуличного мистецтва','Дніпро','2026-05-23','2026-05-30','Активний','Вуличне мистецтво, танці, музика і їжа',450.00,0),(10,'KinoFest','Львів','2026-06-07','2026-06-09','Заплановано','Дивись разом з нами прем\'єру \"Диявол носить Прада 2\" під відкритим небом. На локаціях працює кафе  і фотограф',500.00,0);
/*!40000 ALTER TABLE `festivals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `price_location` decimal(10,2) NOT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Площа Героїв Майдану','м. Дніпро, просп. Дмитра Яворницького, 1',5000.00),(2,'Парк Шевченка','м. Дніпро, вул. Січеславська Набережна, 20',3500.00),(3,'Контрактова площа','м. Київ, Контрактова площа',6000.00),(4,'Арт-зона Поділ','м. Київ, вул. Верхній Вал, 10',4500.00),(5,'Площа Ринок','м. Львів, пл. Ринок',5500.00),(6,'Стадіон Чорноморець','м. Одеса, вул. Маразліївська, 1/20',5500.00),(7,'Loft Stage (Схід Оpera) та Арт-Сховище «Культура»','м.Харків, вул. Сумська, 25',1500.00),(8,'Креативний простір !FESTrepublic','м.Львів, вул. Старознесенська, 24-26.',2000.00);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `rating` tinyint DEFAULT NULL,
  `comment` tinytext,
  `visitor_id` int NOT NULL,
  `festival_id` int NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `fk_reviews_users1_idx` (`visitor_id`),
  KEY `fk_reviews_festivals1_idx` (`festival_id`),
  CONSTRAINT `fk_reviews_users1` FOREIGN KEY (`visitor_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,5,'Дуже атмосферний фестиваль, багато крутих виступів!',2,2),(2,5,'Всім раджу, було дуже атмосферно і затишно!',10,5),(3,4,'Сподобалась музика, але було замало місця.',3,5),(4,5,'Чудовий фестиваль!',2,2),(5,5,'Дуже сподобалось',2,2),(6,5,'Було дуже цікаво і весело! Всім раджу!',10,2),(7,5,'Дуже круто!',10,3);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `role` enum('Відвідувач','Артист','Організатор','Адміністратор') NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Адміністратор Системи','admin@fest.com','admin123','+380501111111','Адміністратор'),(2,'Олена Коваленко','olena@gmail.com','pass123','+380671234567','Відвідувач'),(3,'Максим Іваненко','maksym@gmail.com','pass123','+380931112233','Відвідувач'),(4,'Артем Бойко','artem_artist@gmail.com','pass123','+380991234567','Артист'),(5,'Марія Шевченко','maria_artist@gmail.com','pass123','+380681112233','Артист'),(6,'Дмитро Організатор','org@gmail.com','pass123','+380501234567','Організатор'),(7,'Адмін Системи','admin1@fest.com','admin123','+380501111112','Адміністратор'),(8,'Ірина Організатор','org2@gmail.com','pass123','+380631112233','Організатор'),(9,'Марина Маркевич','marina_artist@gmail.com','pass123','+380661112233','Артист'),(10,'Марк Ковальов','mark@gmail.com','pass123','+380931142233','Відвідувач'),(11,'Анастасія','anastasiia.lily.06@gmail.com','ana123','+38 095 770 25 96','Відвідувач'),(12,'Анастасія Петрова','nastya@gmail.com','34334','+38 0664029870','Відвідувач'),(13,'Ангеліна Кобченко','anhelina@gmail.com','angel334','0605674354','Відвідувач'),(14,'Максим Власюк','maksymartist@gmail.com','max121','+38 095 770 2432','Артист');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_artist_applications`
--

DROP TABLE IF EXISTS `view_artist_applications`;
/*!50001 DROP VIEW IF EXISTS `view_artist_applications`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_artist_applications` AS SELECT 
 1 AS `application_id`,
 1 AS `artist_name`,
 1 AS `art_type`,
 1 AS `status`,
 1 AS `festival_name`,
 1 AS `comment`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_booked_locations`
--

DROP TABLE IF EXISTS `view_booked_locations`;
/*!50001 DROP VIEW IF EXISTS `view_booked_locations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_booked_locations` AS SELECT 
 1 AS `booked_locations_id`,
 1 AS `festival_name`,
 1 AS `location_name`,
 1 AS `organizer_name`,
 1 AS `datetime_start`,
 1 AS `datetime_end`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_events_with_artists`
--

DROP TABLE IF EXISTS `view_events_with_artists`;
/*!50001 DROP VIEW IF EXISTS `view_events_with_artists`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_events_with_artists` AS SELECT 
 1 AS `event_id`,
 1 AS `title`,
 1 AS `datetime_start`,
 1 AS `datetime_end`,
 1 AS `festival_name`,
 1 AS `location_name`,
 1 AS `artist_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_festival_ratings`
--

DROP TABLE IF EXISTS `view_festival_ratings`;
/*!50001 DROP VIEW IF EXISTS `view_festival_ratings`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_festival_ratings` AS SELECT 
 1 AS `festival_id`,
 1 AS `festival_name`,
 1 AS `average_rating`,
 1 AS `reviews_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_reviews_with_users`
--

DROP TABLE IF EXISTS `view_reviews_with_users`;
/*!50001 DROP VIEW IF EXISTS `view_reviews_with_users`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_reviews_with_users` AS SELECT 
 1 AS `review_id`,
 1 AS `rating`,
 1 AS `comment`,
 1 AS `visitor_name`,
 1 AS `festival_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view_artist_applications`
--

/*!50001 DROP VIEW IF EXISTS `view_artist_applications`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_artist_applications` AS select `aa`.`application_id` AS `application_id`,`u`.`full_name` AS `artist_name`,`aa`.`art_type` AS `art_type`,`aa`.`Status` AS `status`,`f`.`name` AS `festival_name`,`aa`.`comment` AS `comment` from ((`artist_applications` `aa` join `users` `u` on((`aa`.`artist_id` = `u`.`user_id`))) join `festivals` `f` on((`aa`.`festival_id` = `f`.`festival_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_booked_locations`
--

/*!50001 DROP VIEW IF EXISTS `view_booked_locations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_booked_locations` AS select `bl`.`booked_locations_id` AS `booked_locations_id`,`f`.`name` AS `festival_name`,`l`.`name` AS `location_name`,`u`.`full_name` AS `organizer_name`,`bl`.`datetime_start` AS `datetime_start`,`bl`.`datetime_end` AS `datetime_end` from (((`booked_locations` `bl` join `festivals` `f` on((`bl`.`festival_id` = `f`.`festival_id`))) join `locations` `l` on((`bl`.`location_id` = `l`.`location_id`))) join `users` `u` on((`bl`.`organizer_id` = `u`.`user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_events_with_artists`
--

/*!50001 DROP VIEW IF EXISTS `view_events_with_artists`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_events_with_artists` AS select `fe`.`event_id` AS `event_id`,`fe`.`title` AS `title`,`fe`.`datetime_start` AS `datetime_start`,`fe`.`datetime_end` AS `datetime_end`,`f`.`name` AS `festival_name`,`l`.`name` AS `location_name`,`u`.`full_name` AS `artist_name` from (((`festival_events` `fe` join `festivals` `f` on((`fe`.`festival_id` = `f`.`festival_id`))) join `locations` `l` on((`fe`.`location_id` = `l`.`location_id`))) left join `users` `u` on((`fe`.`artist_id` = `u`.`user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_festival_ratings`
--

/*!50001 DROP VIEW IF EXISTS `view_festival_ratings`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_festival_ratings` AS select `f`.`festival_id` AS `festival_id`,`f`.`name` AS `festival_name`,round(avg(`r`.`rating`),2) AS `average_rating`,count(`r`.`review_id`) AS `reviews_count` from (`festivals` `f` left join `reviews` `r` on((`f`.`festival_id` = `r`.`festival_id`))) group by `f`.`festival_id`,`f`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_reviews_with_users`
--

/*!50001 DROP VIEW IF EXISTS `view_reviews_with_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_reviews_with_users` AS select `r`.`review_id` AS `review_id`,`r`.`rating` AS `rating`,`r`.`comment` AS `comment`,`u`.`full_name` AS `visitor_name`,`f`.`name` AS `festival_name` from ((`reviews` `r` join `users` `u` on((`r`.`visitor_id` = `u`.`user_id`))) join `festivals` `f` on((`r`.`festival_id` = `f`.`festival_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-30 22:30:55
