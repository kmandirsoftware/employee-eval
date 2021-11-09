-- CREATE DATABASE  IF NOT EXISTS `ems` 
-- USE `ems`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ems
-- ------------------------------------------------------
-- Server version	8.0.19

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

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
  id int NOT NULL AUTO_INCREMENT,
  name varchar(45) NOT NULL,
  status tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

DROP TABLE IF EXISTS projects;
CREATE TABLE projects (
  id int NOT NULL AUTO_INCREMENT,
  name varchar(45) NOT NULL,
  status tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
INSERT INTO `projects` VALUES(1,"XGLinear",1),(2,"Silk",1),(3,"GamePlan",1);

DROP TABLE IF EXISTS titles;
CREATE TABLE titles(
  id int NOT NULL AUTO_INCREMENT,
  name varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
INSERT INTO `titles` VALUES (1,'Senior BackEnd Software'),(2,'Senior FrontEnd Software'),(3,'BackEnd Software'),(4,'FrontEnd Software'),(5,'Senior FullStack Software'),(6,'FullStack Software');

DROP TABLE IF EXISTS cycle;
CREATE TABLE cycle(
  id int NOT NULL AUTO_INCREMENT,
  name varchar(450) NOT NULL,
  start_date date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
INSERT INTO `cycle` VALUES (1,"Q3-2021","09-13-2021");

DROP TABLE IF EXISTS performance_catagory;
CREATE TABLE performance_category(
  id int NOT NULL AUTO_INCREMENT,
  name varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

DROP TABLE IF EXISTS catagory;
CREATE TABLE catagory(
  id int NOT NULL AUTO_INCREMENT,
  name varchar(450) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
INSERT INTO `catagory` VALUES (1,"Job Knowledge"),(2,"Planning and Problem Solving");
INSERT INTO `catagory` VALUES (3,"Productivity"),(4,"Communication Skills");
INSERT INTO `catagory` VALUES (5,"Team Work"),(6,"Tech Lead Skills");

DROP TABLE IF EXISTS users;
CREATE TABLE users(
  id int NOT NULL AUTO_INCREMENT,
  manager_id int NOT NULL,
  name varchar(450) NOT NULL,
  pw char(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
INSERT INTO `users` VALUES (1,1,"keith","$2b$10$3lZawSjk1GTdi11RuefRIONHJmUIF7Jp6RERCQxInkfeMf5osR20C"),(2,2,'jim',"$2b$10$3eTpwt4NuX5alRQwhRrEFuD.kGO67ZXTF1ktrEIZ/tDAeSgFsdStG"),(3,3,'shawn',"$2b$10$z6lrUmqkM9qoGgtd0r2wgODAcs4NP8CR.QeqNn7X0FsqgJqaGtyFC");

DROP TABLE IF EXISTS eval_form1;
CREATE TABLE eval_form1(
  id int NOT NULL AUTO_INCREMENT,
  catagory_id int NOT NULL,
  name varchar(450) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
INSERT INTO `eval_form1` VALUES (1,1,"Understands Job Requirements and responsibilities"),(2,1,"Possesses required skills and knowledge for the job"),(3,1,"Keeps abreast of current developments pertainingto the job");
INSERT INTO `eval_form1` VALUES (4,2,"Works in an organized manner"),(5,2,"Requires minimal supervision"),(6,2,"Can identify problems"),(7,2,"Reacts to problems in appropriate time");
INSERT INTO `eval_form1` VALUES (8,3,"Achieves established goals"),(9,3,"Can multi-task between several projects"),(10,3,"Meets productivity standards");
INSERT INTO `eval_form1` VALUES (11,4,"Articulates ideas effectively"),(12,4,"Participates in meetings"),(13,4,"Listens carefully");
INSERT INTO `eval_form1` VALUES (14,5,"Is an effective team player"),(15,5,"Offers assistance to team members"),(16,5,"Works well with different personality types"),(17,5,"Participates in team discussions");
INSERT INTO `eval_form1` VALUES (18,6,"Clearly identifies goals to team members"),(19,6,"Holds themself accountable to goals and objectives"),(20,6,"Reports success towards reaching goals"),(21,6,"Positively motivates others to achieve goals and gain skills");
--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'xGLinear',1),(2,'Silk',1),(3,'GamePlan',1);
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
   `cycle_id` int NOT NULL,
  `date_of_review` date DEFAULT NULL,
  `performance_level` enum('High','Medium','Low'),
  `potential` enum('High','Medium','Low'),
  `innovation` enum('High','Medium','Low'),
  `leadership` enum('High','Medium','Low'),
  `skill` enum('High','Medium','Low'),
  `above_and_beyound` enum('High','Medium','Low'),
  `knowledge_of_product` enum('High','Medium','Low'),
  `workload` enum('High','Medium','Low'),
  `comments` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `managers`;
CREATE TABLE `managers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personal_details_id` int NOT NULL,
  `designation` varchar(75) NOT NULL,
  `date_of_joining` date NOT NULL,
  `reporting_to` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `review_id` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `date_of_leaving` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

INSERT INTO `managers` VALUES (1,1,"Senior Director",'2019-09-21',1,1,1,1,NULL),(2,2,"Director","1997-09-01",1,1,1,1,NULL),(3,3,"Senior Manager","2007-09-01",1,1,1,1,NULL);
--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personal_details_id` int NOT NULL,
  `designation` varchar(75) NOT NULL,
  `date_of_joining` date NOT NULL,
  `manager_id` int NOT NULL,
  `department_id` int DEFAULT NULL,
  `review_id` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `date_of_leaving` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,7,'Software Engineer','2019-07-18',2,1,NULL,1,NULL),(2,8,'ty','1991-03-11',2,1,NULL,1,NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_details`
--

DROP TABLE IF EXISTS `personal_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(75) NOT NULL,
  `last_name` varchar(75) NOT NULL,
  `dob` date NOT NULL,
  `permanent address_line1` text,
  `permanent_address_line2` text,
  `permanent_address_city` text,
  `permanent_address_state` text,
  `permanent_address_country` text,
  `contact_number` bigint NOT NULL,
  `alternate_contact_number` bigint DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_details`
--

LOCK TABLES `personal_details` WRITE;
/*!40000 ALTER TABLE `personal_details` DISABLE KEYS */;
INSERT INTO `personal_details` VALUES (1,'Keith','Gerhards','1964-06-23',"971 Galapago Sreet",NULL,"Denver","Colorado","USA",3038808008,NULL,'keith.gerhards@gmail.com'),(2,"James","Brinson",NULL,NULL,NULL,NULL,NULL,"USA",303,NULL,"jim.brinson@imaginecommunications.com"),(3,"Shawn","Oles",NULL,NULL,NULL,NULL,NULL,"USA",303,NULL,"shawn.oles@imaginecommunications.com"),(7,"Jerrame","Hertz",NULL,NULL,NULL,NULL,NULL,"USA",303,NULL,"jerrame.hertz@imaginecommunications.com"),(8,"Ron","Pollizi",NULL,NULL,NULL,NULL,NULL,"USA",303,NULL,"ron.pallizi@imaginecommunications.com");
/*!40000 ALTER TABLE `personal_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-21 23:38:14
