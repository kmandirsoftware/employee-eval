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
  `email` varchar(45) ,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
/*!40101 SET character_set_client = @saved_cs_client */;

