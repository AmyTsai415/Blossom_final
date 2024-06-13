-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.36

USE shop;

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `CartID` int NOT NULL AUTO_INCREMENT,
  `MemberID` varchar(10) NOT NULL,
  `ProductID` varchar(10) NOT NULL,
  `ProductName` varchar(25) NOT NULL,
  `ProductImage` varchar(15) NOT NULL,
  `CartQuentity` int NOT NULL,
  `CartPrice` int NOT NULL,
  PRIMARY KEY (`CartID`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (114,'555','7','白色之愛花舞','IMG_3534',1,490),(162,'chloe','4','粉紫夢幻之愛','IMG_3531',2,490),(163,'chloe','1','粉夢鬱金香','IMG_3528',2,299);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `ContentID` int NOT NULL AUTO_INCREMENT,
  `MemberName` varchar(16) NOT NULL,
  `MemberID` varchar(10) NOT NULL,
  `MemberAddress` varchar(45) NOT NULL,
  `ContactSubject` varchar(100) NOT NULL,
  PRIMARY KEY (`ContentID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (13,'一顆小檸檬','lemon','tw','小檸檬好好看'),(14,'一顆小檸檬','lemon','tw','小檸檬好好看'),(15,'一顆小檸檬','lemon','tw','好看的花兒'),(16,'一顆小檸檬','lemon','tw','好看的花兒'),(17,'一顆小檸檬','lemon','tw','Hello'),(18,'一顆小檸檬','lemon','tw','Hello');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `MemberID` varchar(10) NOT NULL,
  `MemberName` varchar(16) NOT NULL,
  `MemberPhone` varchar(10) NOT NULL,
  `MemberAddress` varchar(45) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `MemberEmail` varchar(50) NOT NULL,
  `MemberBirthday` date DEFAULT NULL,
  PRIMARY KEY (`MemberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('555','000','000','000','000','happy@happy','2024-06-04'),('Brulee','奶油烤布蕾','0911223344','剛出爐烤箱','123456','Brulee@creme','2024-06-01'),('chloe','蘋果','0902202020','我的地址是不知道','1234','happy@happy','2024-06-01'),('lemon','新鮮檸檬片','0902202020','檸檬樹上','123456','lemon@happyday','2023-04-07');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `MessageID` int NOT NULL AUTO_INCREMENT,
  `MemberID` varchar(10) NOT NULL,
  `ProductID` varchar(10) NOT NULL,
  `Content` varchar(100) DEFAULT NULL,
  `Star` int NOT NULL,
  `MessageTime` datetime NOT NULL,
  PRIMARY KEY (`MessageID`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (28,'lemon','003','你好',5,'2024-06-03 23:49:58'),(29,'lemon','001','你好',5,'2024-06-03 23:50:16'),(30,'lemon','003','好好看',5,'2024-06-04 12:38:28'),(31,'lemon','004','好好看',5,'2024-06-04 12:40:29'),(32,'555','002','hi',5,'2024-06-04 13:26:13'),(33,'lemon','005','好看',5,'2024-06-04 23:50:41'),(34,'lemon','003','好看',5,'2024-06-04 23:51:09'),(35,'lemon','002','好看',3,'2024-06-04 23:51:26'),(36,'lemon','001','好看',2,'2024-06-12 20:14:41'),(37,'lemon','001','CP值高',4,'2024-06-12 20:19:21'),(38,'lemon','001','下次會回購',5,'2024-06-12 20:21:19'),(39,'chloe','003','CP值高',5,'2024-06-12 21:35:11');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `MemberID` varchar(10) NOT NULL,
  `MemberName` varchar(30) NOT NULL,
  `CityNumber` int NOT NULL,
  `City` varchar(20) NOT NULL,
  `MemberAddress` varchar(45) NOT NULL,
  `MemberPhoneTop` varchar(10) NOT NULL,
  `MemberPhone` int NOT NULL,
  `OrderTime` datetime DEFAULT NULL,
  PRIMARY KEY (`OrderID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (37,'lemon','一顆小檸檬',604,'新北市','檸檬樹上','+886',912345678,'2024-06-05 01:25:00'),(38,'lemon','一顆小檸檬',123,'宜蘭縣','檸檬樹上','+886',912345678,'2024-06-05 01:43:03'),(39,'lemon','一顆小檸檬',764,'新北市','檸檬樹上','+886',902202020,'2024-06-05 01:59:21'),(40,'Brulee','奶油',866,'台北市','剛出爐烤箱','+886',966777888,'2024-06-06 12:58:20'),(41,'lemon','一顆小檸檬',604,'台東縣','檸檬樹上','+886',912345678,'2024-06-06 22:20:32'),(42,'lemon','一顆小檸檬',123,'新北市','檸檬樹上','+886',966777888,'2024-06-12 14:21:53'),(43,'chloe','蘋果',123,'新北市','蘋果樹','+886',999999999,'2024-06-12 21:28:07'),(44,'chloe','一顆小檸檬',123,'基隆市','我的地址是不知道','+886',999999999,'2024-06-13 00:02:51'),(45,'chloe','蜂蜜鬆餅',123,'金門縣','蘋果樹','+886',902202020,'2024-06-13 00:08:38'),(46,'chloe','蜂蜜鬆餅',758,'花蓮縣','剛出爐烤箱','+886',999999999,'2024-06-13 00:23:44');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetail`
--

DROP TABLE IF EXISTS `orderdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetail` (
  `OrderDetalID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int DEFAULT NULL,
  `ProductID` varchar(45) DEFAULT NULL,
  `ProductName` varchar(50) DEFAULT NULL,
  `ProductImage` varchar(15) DEFAULT NULL,
  `OrderQuentity` int DEFAULT NULL,
  `OrderPrice` int DEFAULT NULL,
  `MemberID` varchar(10) DEFAULT NULL,
  `TotalPrice` varchar(45) DEFAULT NULL,
  `OrderTime` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`OrderDetalID`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetail`
--

LOCK TABLES `orderdetail` WRITE;
/*!40000 ALTER TABLE `orderdetail` DISABLE KEYS */;
INSERT INTO `orderdetail` VALUES (46,37,'1','粉夢鬱金香','IMG_3528',1,299,'lemon','299','2024-06-05 01:24:47'),(47,37,'2','純愛之白','IMG_3529',1,790,'lemon','790','2024-06-05 01:24:47'),(49,38,'8','深藍之夢花築','IMG_3535',1,390,'lemon','390','2024-06-05 01:42:45'),(50,38,'9','摩天輪之戀花幻','IMG_3536',1,299,'lemon','299','2024-06-05 01:42:45'),(51,38,'1','粉夢鬱金香','IMG_3528',1,299,'lemon','299','2024-06-05 01:42:45'),(52,38,'2','純愛之白','IMG_3529',1,790,'lemon','790','2024-06-05 01:42:45'),(53,38,'1','粉夢鬱金香','IMG_3528',1,299,'lemon','299','2024-06-05 01:42:45'),(56,39,'1','粉夢鬱金香','IMG_3528',1,299,'lemon','299','2024-06-05 01:58:42'),(57,40,'1','粉夢鬱金香','IMG_3528',1,299,'Brulee','299','2024-06-06 12:57:38'),(58,40,'9','摩天輪之戀花幻','IMG_3536',1,299,'Brulee','299','2024-06-06 12:57:38'),(59,41,'1','粉夢鬱金香','IMG_3528',1,299,'lemon','299','2024-06-06 22:20:19'),(60,42,'5','炙熱戀情之花','IMG_3532',1,390,'lemon','390','2024-06-12 14:21:26'),(61,43,'5','炙熱戀情之花','IMG_3532',1,390,'chloe','390','2024-06-12 21:27:53'),(62,43,'5','炙熱戀情之花','IMG_3532',1,390,'chloe','390','2024-06-12 21:27:53'),(63,43,'6','純淨之愛花園','IMG_3533',1,299,'chloe','299','2024-06-12 21:27:53'),(64,44,'1','粉夢鬱金香','IMG_3528',2,299,'chloe','598','2024-06-13 00:02:17'),(65,45,'3','粉色柔情玫瑰','IMG_3530',2,590,'chloe','1180','2024-06-13 00:08:29'),(66,46,'1','粉夢鬱金香','IMG_3528',2,299,'chloe','598','2024-06-13 00:23:33');
/*!40000 ALTER TABLE `orderdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `PayID` int NOT NULL,
  `CardNumber` varchar(16) NOT NULL,
  `CardName` varchar(16) NOT NULL,
  `ExpiryDate` datetime NOT NULL,
  `CVV` int NOT NULL,
  PRIMARY KEY (`PayID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (37,'87654323456','霸總小檸檬','2024-06-29 00:00:00',98),(38,'76597657964','霸總小檸檬','2024-06-26 00:00:00',97),(39,'79764746','霸總小檸檬','2024-06-28 00:00:00',980),(40,'5412666','有錢人布蕾','2024-07-06 00:00:00',789),(41,'45465342','霸總小檸檬','2024-07-06 00:00:00',346),(42,'123223456','霸總小檸檬','2024-06-01 00:00:00',989),(43,'145674675856','霸總小檸檬','2024-06-01 00:00:00',846),(44,'345435','霸總小檸檬','2024-06-06 00:00:00',345),(45,'2464564','霸總小檸檬','2024-06-13 00:00:00',315),(46,'764754654','霸總小檸檬','2024-07-06 00:00:00',975);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `ProductID` int NOT NULL,
  `ProductName` varchar(255) DEFAULT NULL,
  `ProductImage` varchar(15) DEFAULT NULL,
  `ProductPrice` decimal(10,2) DEFAULT NULL,
  `StockQuentity` int DEFAULT NULL,
  `ProductMessage` text,
  PRIMARY KEY (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'粉夢鬱金香','IMG_3528',299.00,29,'這些粉色鬱金香如夢如 幻,綻放著溫柔的浪漫 氛圍。'),(2,'純愛之白','IMG_3529',790.00,19,'象徵著純潔和無私的愛 情,為你帶來一束永恆 的愛的寓意。'),(3,'粉色柔情玫瑰','IMG_3530',590.00,15,'色澤柔和,花瓣如絲般 柔軟,帶給你溫暖和甜 蜜的感受。'),(4,'粉紫夢幻之愛','IMG_3531',490.00,2,'散發著令人陶醉的淡淡 花香,象徵著浪漫的愛 情之夢。'),(5,'熾熱戀情之花','IMG_3532',390.00,15,'熾熱的戀情氛圍,花朵 散發出濃烈的愛情氣 息,讓人心馳神往。'),(6,'純淨之愛花園','IMG_3533',299.00,4,'結合了純淨和浪漫,猶 如一個迷人的愛情花 園,為你帶來純淨無暇 的愛情寓意。'),(7,'白色之愛花舞','IMG_3534',490.00,4,'金邊白玫瑰音響散發著 奢華的金色光芒,彷彿 在舞動的花海中演奏著 愛的樂章。'),(8,'深藍之夢花築','IMG_3535',390.00,10,'瑰猶如深藍色的夢境, 帶著神秘和浪漫,為你 營造一個迷人的花築之 夢。'),(9,'摩天輪之戀花幻','IMG_3536',299.00,13,'結合了藍色和粉色的浪 漫色彩,帶你飛躍到愛 情的高峰,享受一場真 摯的戀愛幻想。');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-13  8:32:56
