
DROP TABLE IF EXISTS users;
CREATE TABLE users(
  id int NOT NULL AUTO_INCREMENT,
  manager_id int NOT NULL,
  name varchar(450) NOT NULL,
  password char(100) NOT NULL,
  email varchar(45) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1;
INSERT INTO `users` VALUES (1,1,"keith","$2b$10$w2hm34ELNziAmQg8WTRJBeRnFlcuGFC7eYLQvmT1KQ7aMcx8ZZf0W","keith.gerhards@imaginecommunications.com"),(2,2,'jim',"$2b$10$3eTpwt4NuX5alRQwhRrEFuD.kGO67ZXTF1ktrEIZ/tDAeSgFsdStG","jim.brinson@imaginecommunications.com"),(3,3,'shawn',"$2b$10$tIhg3pnngiETDEqPMp8PhOg22eKqRKrv31N3MQnbNzA23p/nv9oKq","shawn.oles@imaginecommunications.com");
