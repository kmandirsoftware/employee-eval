
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
  `employee_id` int NOT NULL,
  `cycle_id` int NOT NULL,
  `date_of_review` date NOT NULL,
   eval_form1_id int NOT NULL,
   catagory_id int NOT NULL,
  `rating` int NOT NULL,
  `comments` varchar(245) NOT NULL,
  PRIMARY KEY (`employee_id`,cycle_id,date_of_review,eval_form1_id,catagory_id)
) ENGINE=InnoDB 
