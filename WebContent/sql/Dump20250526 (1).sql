-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: java_web_doc_bao
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `full_name` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `created_at` date DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'nam@gmail.com','12345678','Phan Văn Nam','012345678',NULL),(2,'hoangngocthachbon@gmail.com','123456789','Hoang Ngoc Thach','0765517507',NULL);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article` (
  `article_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `admin_id` int NOT NULL,
  `title` mediumtext COLLATE utf8mb4_unicode_ci,
  `short_content` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `breaking_news` int NOT NULL,
  `headline` int NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`article_id`),
  KEY `fk_cateId_article` (`category_id`),
  KEY `fk_adminId_article_idx` (`admin_id`),
  CONSTRAINT `fk_adminId_article` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  CONSTRAINT `fk_cateId_article` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (1,2,1,'CÃ¡ÂºÂ§u thÃ¡Â»Â§ ViÃ¡Â»Ât kiÃ¡Â»Âu ghi bÃÂ n, Nam ÃÂÃ¡Â»Ânh tiÃ¡ÂºÂ¿n gÃ¡ÂºÂ§n ngÃÂ´i vÃÂ°ÃÂ¡ng V-League','(NLÃÂO) - TrÃÂ°Ã¡Â»Âc sÃ¡Â»Â± chÃ¡Â»Âng trÃ¡ÂºÂ£ quyÃ¡ÂºÂ¿t liÃ¡Â»Ât cÃ¡Â»Â§a chÃ¡Â»Â§ nhÃÂ  SLNA, CLB Nam ÃÂÃ¡Â»Ânh vÃ¡ÂºÂ¥t vÃ¡ÂºÂ£ thÃ¡ÂºÂ¯ng chung cuÃ¡Â»Âc 3-2 nhÃ¡Â»Â pha lÃ¡ÂºÂ­p cÃÂ´ng cÃ¡Â»Â§a cÃ¡ÂºÂ§u thÃ¡Â»Â§ ViÃ¡Â»Ât kiÃ¡Â»Âu Kevin PhÃ¡ÂºÂ¡m Ba tÃ¡Â»Âi 26-5','<p>Nam &Auml;Â&aacute;&raquo;Ânh&nbsp;t&aacute;&raquo;&laquo;ng th&aacute;&ordm;&macr;ng &Auml;Â&aacute;&ordm;&shy;m&nbsp;SLNA&nbsp;&aacute;&raquo;Â tr&aacute;&ordm;&shy;n l&AElig;&deg;&aacute;&raquo;&pound;t &Auml;Âi. Khi t&aacute;i &Auml;Â&aacute;&ordm;&yen;u,&nbsp;&Auml;Â&aacute;&raquo;Âi b&oacute;ng th&agrave;nh Nam&nbsp;&Auml;Â&AElig;&deg;&aacute;&raquo;&pound;c &Auml;Â&aacute;nh gi&aacute; cao h&AElig;&iexcl;n &Auml;Â&aacute;&raquo;Âi ph&AElig;&deg;&AElig;&iexcl;ng nh&aacute;&raquo;Â s&aacute;&raquo;Â h&aacute;&raquo;&macr;u d&agrave;n sao h&agrave;ng &Auml;Â&aacute;&ordm;&sect;u&nbsp;V-League. Song, th&aacute;&ordm;&sect;y tr&ograve; &ocirc;ng V&Aring;&copy; H&aacute;&raquo;Âng Vi&aacute;&raquo;Ât g&aacute;&ordm;&middot;p nhi&aacute;&raquo;Âu kh&oacute; kh&Auml;Ân khi tri&aacute;&raquo;Ân khai chi&aacute;&ordm;&iquest;n thu&aacute;&ordm;&shy;t trong c&AElig;&iexcl;n m&AElig;&deg;a n&aacute;&ordm;&middot;ng h&aacute;&ordm;&iexcl;t tr&ecirc;n s&acirc;n Vinh t&aacute;&raquo;Âi 26-5.</p>\r\n\r\n<p><img alt=\"\" src=\"https://nld.mediacdn.vn/thumb_w/698/291774122806476800/2025/5/26/50022292313364174413594725267884293923025899n-17482677112381050125507.jpg\" style=\"height:499px; width:700px\" /></p>\r\n\r\n<p>Nam &Auml;Â&aacute;&raquo;Ânh v&aacute;&raquo;Âi quy&aacute;&ordm;&iquest;t t&acirc;m gi&agrave;nh chi&aacute;&ordm;&iquest;n th&aacute;&ordm;&macr;ng &Auml;Â&aacute;&raquo;Â c&oacute; th&aacute;&raquo;Â s&aacute;&raquo;Âm &Auml;Â&Auml;Âng quang gi&aacute;&ordm;&pound;i &Auml;Â&aacute;&ordm;&yen;u. Ch&aacute;&raquo;&sect; &Auml;Â&aacute;&raquo;Âng d&acirc;ng cao &Auml;Â&aacute;&raquo;Âi h&igrave;nh t&aacute;&ordm;&yen;n c&ocirc;ng, &Auml;Â&aacute;&raquo;Âi kh&aacute;ch s&aacute;&raquo;Âm c&oacute; b&agrave;n m&aacute;&raquo;Â t&aacute;&raquo;Â s&aacute;&raquo;Â do c&ocirc;ng Brenner &aacute;&raquo;Â ph&uacute;t 11. Tuy nhi&ecirc;n, trong th&aacute;&ordm;&iquest; bu&aacute;&raquo;Âc ph&aacute;&ordm;&pound;i c&oacute; &Auml;Âi&aacute;&raquo;Âm &Auml;Â&aacute;&raquo;Â tho&aacute;t nh&oacute;m cu&aacute;&raquo;Âi b&aacute;&ordm;&pound;ng x&aacute;&ordm;&iquest;p h&aacute;&ordm;&iexcl;ng, SLNA m&aacute;&ordm;&iexcl;nh m&aacute;&ordm;&frac12; tr&agrave;n qua ph&aacute;&ordm;&sect;n s&acirc;n Nam &Auml;Â&aacute;&raquo;Ânh &Auml;Â&aacute;&raquo;Â ch&AElig;&iexcl;i &Auml;Â&ocirc;i c&ocirc;ng.</p>\r\n\r\n<p>T&aacute;&raquo;&laquo; t&igrave;nh hu&aacute;&raquo;Âng ph&aacute;&ordm;&iexcl;t g&oacute;c c&aacute;nh tr&aacute;i, Kuku b&aacute;&ordm;&shy;t cao ghi b&agrave;n g&aacute;&raquo;&iexcl; h&ograve;a cho &Auml;Â&aacute;&raquo;Âi b&oacute;ng x&aacute;&raquo;&copy; Ngh&aacute;&raquo;Â, khi&aacute;&ordm;&iquest;n tinh th&aacute;&ordm;&sect;n thi &Auml;Â&aacute;&ordm;&yen;u c&aacute;&raquo;&sect;a d&agrave;n sao c&aacute;&raquo;&sect;a Nam &Auml;Â&aacute;&raquo;Ânh s&aacute;&raquo;&yen;t gi&aacute;&ordm;&pound;m. Kh&oacute; ki&aacute;&raquo;Âm so&aacute;t b&oacute;ng, ban b&aacute;&ordm;&shy;t nh&aacute;&raquo;Â trong &Auml;Âi&aacute;&raquo;Âu ki&aacute;&raquo;Ân &quot;s&acirc;n &AElig;&deg;&aacute;&raquo;Ât, b&oacute;ng tr&AElig;&iexcl;n&quot;, &Auml;Âo&agrave;n qu&acirc;n HLV V&Aring;&copy; H&aacute;&raquo;Âng Vi&aacute;&raquo;Ât bu&aacute;&raquo;Âc ph&aacute;&ordm;&pound;i s&aacute;&raquo;&shy; d&aacute;&raquo;&yen;ng c&aacute;c &Auml;Â&AElig;&deg;&aacute;&raquo;Âng chuy&aacute;&raquo;Ân d&agrave;i v&AElig;&deg;&aacute;&raquo;&pound;t tuy&aacute;&ordm;&iquest;n &Auml;Â&aacute;&raquo;Â kho&eacute;t v&agrave;o h&agrave;ng th&aacute;&raquo;&sect; SLNA.</p>\r\n\r\n<p><img alt=\"\" src=\"https://nld.mediacdn.vn/291774122806476800/2025/5/26/50070789013364174380261391345645795933932814n-17482677118981418603848.jpg\" style=\"height:467px; width:700px\" /></p>\r\n','59f3c282-2f94-4c06-b1bb-b79d85f1144e.avif',1,1,'2025-05-26'),(2,1,1,'Nga lÃªn tiáº¿ng vá» ÄÃ²n tráº£ ÄÅ©a, phÃ³ng ká»· lá»¥c hÆ¡n 350 UAV vÃ o Ukraine','Nga cho biáº¿t Äang tiáº¿n hÃ nh khÃ´ng kÃ­ch vÃ o cÃ¡c cÆ¡ sá» liÃªn quan Äáº¿n quÃ¢n Äá»i Ukraine nháº±m ÄÃ¡p tráº£ Kiev phÃ³ng mÃ¡y bay khÃ´ng ngÆ°á»i lÃ¡i (UAV) vÃ o cÃ¡c cÆ¡ sá» dÃ¢n sá»± cá»§a Nga.','<p>Ukraine Ä&atilde; Äáº©y máº¡nh kh&ocirc;ng k&iacute;ch v&agrave;o Nga, ká» tá»« sau cuá»c Äiá»n Ä&agrave;m giá»¯a Tá»ng thá»ng Nga Vladimir Putin v&agrave; Tá»ng thá»ng Má»¹ Donald Trump v&agrave;o tuáº§n trÆ°á»c.&nbsp;</p>\r\n\r\n<p>Theo Bá» Quá»c ph&ograve;ng Nga, Ukraine Ä&atilde; ph&oacute;ng h&agrave;ng trÄm UAV chá» trong khoáº£ng thá»i gian ngáº¯n tá»« ng&agrave;y 20 &ndash; 23/5. H&ocirc;m nay (26/5), Nga tuy&ecirc;n bá» Ä&atilde; báº¯n háº¡ hÆ¡n 150 UAV táº§m xa cá»§a Ukraine trong v&ograve;ng 24 giá». Moscow cÅ©ng cho biáº¿t Ä&atilde; táº¥n c&ocirc;ng th&agrave;nh c&ocirc;ng má»t nh&agrave; m&aacute;y sáº£n xuáº¥t UAV v&agrave; t&ecirc;n lá»­a á» Kiev, c&ugrave;ng má»t sá» má»¥c ti&ecirc;u qu&acirc;n sá»± kh&aacute;c.</p>\r\n\r\n<p><img alt=\"\" src=\"https://static-images.vnncdn.net/vps_images_publish/000001/000003/2025/5/26/nga-ukraine-7-91083.jpg?width=0&amp;s=HzgDpYvYWRNGoT45a9jArA\" style=\"height:467px; width:700px\" /></p>\r\n\r\n<p>H&atilde;ng RT ÄÆ°a tin, ph&aacute;t ng&ocirc;n vi&ecirc;n Äiá»n Kremlin Dmitry Peskov h&ocirc;m nay x&aacute;c nháº­n c&aacute;c cuá»c táº¥n c&ocirc;ng má»i nháº¥t cá»§a Nga v&agrave;o Ukraine n&ecirc;n ÄÆ°á»£c hiá»u l&agrave; Ä&ograve;n Ä&aacute;p tráº£.&nbsp;</p>\r\n\r\n<p>&ldquo;Ch&uacute;ng t&ocirc;i chá»©ng kiáº¿n ngÆ°á»i Ukraine táº¥n c&ocirc;ng v&agrave;o c&aacute;c cÆ¡ sá» háº¡ táº§ng x&atilde; há»i, cÆ¡ sá» háº¡ táº§ng d&acirc;n sá»± cá»§a Nga. Do Ä&oacute;, ch&uacute;ng t&ocirc;i Ä&atilde; táº¥n c&ocirc;ng tráº£ ÄÅ©a. C&aacute;c cuá»c táº¥n c&ocirc;ng n&agrave;y nháº±m v&agrave;o nhá»¯ng cÆ¡ sá» qu&acirc;n sá»±, v&agrave; má»¥c ti&ecirc;u&nbsp;<a href=\"https://vietnamnet.vn/the-gioi/quan-su\" target=\"_blank\">qu&acirc;n sá»±</a>&rdquo;, &ocirc;ng Peskov n&oacute;i.</p>\r\n\r\n<p>Ph&aacute;t ng&ocirc;n vi&ecirc;n Äiá»n Kremlin cÅ©ng Ä&atilde; l&ecirc;n tiáº¿ng b&igrave;nh luáº­n vá» tuy&ecirc;n bá» v&agrave;o cuá»i tuáº§n qua cá»§a &ocirc;ng Trump, ngÆ°á»i Ä&atilde; c&oacute; nhá»¯ng ph&aacute;t biá»u gay gáº¯t nháº¯m v&agrave;o &ocirc;ng Putin, sau khi Moscow thá»±c hiá»n c&aacute;c cuá»c kh&ocirc;ng k&iacute;ch quy m&ocirc; lá»n v&agrave;o Ukraine.&nbsp;</p>\r\n\r\n<p>Theo &ocirc;ng Peskov, Tá»ng thá»ng Putin ÄÆ°a ra c&aacute;c quyáº¿t Äá»nh &ldquo;cáº§n thiáº¿t v&igrave; an ninh cá»§a Äáº¥t nÆ°á»c&rdquo;. &Ocirc;ng Äá»ng thá»i nháº¯c láº¡i viá»c Ukraine Ä&atilde; c&ocirc;ng khai &ldquo;Äe dá»a&rdquo; c&aacute;c nh&agrave; l&atilde;nh Äáº¡o nÆ°á»c ngo&agrave;i v&agrave;o Äáº§u th&aacute;ng n&agrave;y, náº¿u nhÆ° há» Äáº¿n Moscow Äá» tham dá»± lá» ká»· niá»m Ng&agrave;y Chiáº¿n tháº¯ng 9/5.&nbsp;</p>\r\n\r\n<p><strong>Nga ph&oacute;ng ká»· lá»¥c 355 UAV v&agrave;o Ukraine</strong></p>\r\n\r\n<p>H&ocirc;m nay, giá»i chá»©c Ukraine cho hay&nbsp;<a href=\"https://vietnamnet.vn/nga-tag5224380086618038700.html\" target=\"_blank\">Nga&nbsp;</a>Ä&atilde; tiáº¿n h&agrave;nh cuá»c táº¥n c&ocirc;ng quy m&ocirc; lá»n báº±ng UAV v&agrave;o Ukraine trong Ä&ecirc;m thá»© 3 li&ecirc;n tiáº¿p, khiáº¿n &iacute;t nháº¥t 6 ngÆ°á»i thiá»t máº¡ng, v&agrave; 24 ngÆ°á»i kh&aacute;c bá» thÆ°Æ¡ng.</p>\r\n\r\n<p>Theo tá» Kyiv Independent, Kh&ocirc;ng qu&acirc;n Ukraine x&aacute;c nháº­n Nga Ä&atilde; ph&oacute;ng 9 t&ecirc;n lá»­a h&agrave;nh tr&igrave;nh Kh-101 tá»« m&aacute;y bay n&eacute;m bom Tu-95MS, c&ugrave;ng sá» lÆ°á»£ng ká»· lá»¥c l&ecirc;n tá»i 355 UAV Shahed v&agrave; UAV má»i nhá»­ trong Ä&ecirc;m.&nbsp;</p>\r\n\r\n<p>Há» thá»ng ph&ograve;ng kh&ocirc;ng Ukraine Ä&atilde; báº¯n háº¡ táº¥t cáº£ 9 t&ecirc;n lá»­a Kh-101, v&agrave; 233 UAV. Ngo&agrave;i ra, 55 UAV kh&aacute;c cá»§a Nga Ä&atilde; bá» v&ocirc; hiá»u h&oacute;a bá»i c&aacute;c há» thá»ng t&aacute;c chiáº¿n Äiá»n tá»­ cá»§a Ukraine, hoáº·c biáº¿n máº¥t khá»i radar.</p>\r\n\r\n<p>Ä&acirc;y l&agrave; cuá»c táº¥n c&ocirc;ng báº±ng UAV c&oacute; quy m&ocirc; lá»n nháº¥t v&agrave;o Ukraine, ká» tá»« khi xung Äá»t Nga &ndash; Ukraine b&ugrave;ng ná» v&agrave;o th&aacute;ng 2/2022. TrÆ°á»c Ä&oacute;, h&ocirc;m 25/5, Nga cÅ©ng Ä&atilde; ph&oacute;ng 298 UAV táº­p k&iacute;ch Ukraine.&nbsp;</p>\r\n','b770dbbf-bd42-42e3-9e94-4517a038ec34.avif',0,1,'2025-05-26'),(3,1,2,'Báº¯t thÃªm 5 ngÆ°á»i liÃªn quan Äáº¿n vá»£ chá»ng Chá»§ tá»ch cÃ´ng ty HoÃ ng Long','LiÃªn quan Äáº¿n sai pháº¡m táº¡i CÃ´ng ty CP Äáº§u tÆ° xÃ¢y dá»±ng vÃ  cung á»©ng nhÃ¢n lá»±c HoÃ ng Long, CÆ¡ quan Cáº£nh sÃ¡t Äiá»u tra Bá» CÃ´ng an vá»«a ra quyáº¿t Äá»nh khá»i tá», báº¯t táº¡m giam thÃªm 5 ngÆ°á»i cÃ³ liÃªn quan.','<p>Chiá»u 26/5, CÆ¡ quan Cáº£nh s&aacute;t Äiá»u tra Bá» C&ocirc;ng an cho biáº¿t, vá»«a ra Quyáº¿t Äá»nh khá»i tá» bá» can, Lá»nh báº¯t bá» can Äá» táº¡m giam vá»i 5 ngÆ°á»i c&oacute; li&ecirc;n quan Äáº¿n sai pháº¡m trong lÄ©nh vá»±c xuáº¥t kháº©u lao Äá»ng táº¡i C&ocirc;ng ty cá» pháº§n Äáº§u tÆ° x&acirc;y dá»±ng v&agrave; cung á»©ng nh&acirc;n lá»±c Ho&agrave;ng Long (C&ocirc;ng ty Ho&agrave;ng Long).</p>\r\n\r\n<p>5 bá» can gá»m: Nguyá»n Äá»©c Nam - Chá»§ tá»ch HÄQT; Nguyá»n Thá» Quá»³nh Nga - Tá»ng Gi&aacute;m Äá»c; Nguyá»n Thá» Thanh Háº±ng - TrÆ°á»ng ph&ograve;ng Xuáº¥t kháº©u lao Äá»ng 2; PhÆ°Æ¡ng TrÆ°á»ng Long - TrÆ°á»ng ph&ograve;ng Xuáº¥t kháº©u lao Äá»ng 3. Nhá»¯ng ngÆ°á»i tr&ecirc;n Äá»u thuá»c C&ocirc;ng ty cá» pháº§n cung á»©ng nh&acirc;n lá»±c quá»c táº¿ v&agrave; thÆ°Æ¡ng máº¡i (C&ocirc;ng ty Sona). Ri&ecirc;ng Nghi&ecirc;m VÄn Äá»nh l&agrave; Gi&aacute;m Äá»c C&ocirc;ng ty TNHH MTV há»£p t&aacute;c quá»c táº¿ x&acirc;y láº¯p 3 (C&ocirc;ng ty Incoop 3).</p>\r\n\r\n<p><img alt=\"\" src=\"https://static-images.vnncdn.net/vps_images_publish/000001/000003/2025/5/26/nqhung-83757.jpg?width=0&amp;s=UsVXd76nxZtUeLTk6-np5Q\" style=\"height:589px; width:700px\" /></p>\r\n\r\n<p>CÆ¡ quan Cáº£nh s&aacute;t Äiá»u tra th&ocirc;ng tin, 5 ngÆ°á»i tr&ecirc;n bá» Äiá»u tra vá» tá»i Vi pháº¡m quy Äá»nh vá» káº¿ to&aacute;n g&acirc;y háº­u quáº£ nghi&ecirc;m trá»ng, quy Äá»nh táº¡i Äiá»u 221 BLHS nÄm 2015 (sá»­a Äá»i, bá» sung nÄm 2017).</p>\r\n\r\n<p>Theo káº¿t quáº£ Äiá»u tra má» rá»ng, ngo&agrave;i C&ocirc;ng ty Ho&agrave;ng Long, c&ograve;n c&oacute; C&ocirc;ng ty Incoop 3 v&agrave; C&ocirc;ng ty Sona lá»£i dá»¥ng quy Äá»nh ph&aacute;p luáº­t vá» viá»c ÄÆ°á»£c cáº¥p ph&eacute;p, giao nhiá»m vá»¥ tá» chá»©c ngÆ°á»i Äi xuáº¥t kháº©u lao Äá»ng Äá» tá»± &yacute; &aacute;p Äáº·t má»©c tiá»n ph&iacute; dá»ch vá»¥...</p>\r\n\r\n<p>C&aacute;c Äá»i tÆ°á»£ng tr&ecirc;n Ä&atilde; &eacute;p buá»c ngÆ°á»i lao Äá»ng yáº¿u tháº¿ vá»i ho&agrave;n cáº£nh kh&oacute; khÄn, muá»n t&igrave;m kiáº¿m viá»c l&agrave;m, tÄng thu nháº­p pháº£i ná»p th&ecirc;m c&aacute;c khoáº£n ph&iacute; gáº¥p nhiá»u láº§n Äá»nh má»©c pháº£i ná»p, Äá» ngo&agrave;i sá» s&aacute;ch káº¿ to&aacute;n, nháº±m má»¥c Ä&iacute;ch chiáº¿m Äoáº¡t, trá»¥c lá»£i v&agrave; Än chia khoáº£n tiá»n ch&ecirc;nh lá»ch, g&acirc;y thiá»t háº¡i t&agrave;i sáº£n cá»§a ngÆ°á»i d&acirc;n, trá»n tr&aacute;nh nghÄ©a vá»¥ ná»p thuáº¿.</p>\r\n\r\n<p>TrÆ°á»c Ä&oacute;, ng&agrave;y 14/5, Cá»¥c Cáº£nh s&aacute;t Äiá»u tra tá»i pháº¡m vá» tham nhÅ©ng, kinh táº¿, bu&ocirc;n láº­u (Bá» C&ocirc;ng an) Ä&atilde; ra Quyáº¿t Äá»nh khá»i tá» vá»¥ &aacute;n h&igrave;nh sá»± &quot;Vi pháº¡m quy Äá»nh vá» káº¿ to&aacute;n g&acirc;y háº­u quáº£ nghi&ecirc;m trá»ng&quot; xáº£y ra táº¡i C&ocirc;ng ty Ho&agrave;ng Long v&agrave; má»t sá» ÄÆ¡n vá» li&ecirc;n quan.</p>\r\n\r\n<p>CÆ¡ quan c&ocirc;ng an Ä&atilde; khá»i tá» bá» can, &aacute;p dá»¥ng biá»n ph&aacute;p ngÄn cháº·n vá»i 6 Äá»i tÆ°á»£ng: Nghi&ecirc;m Quá»c HÆ°ng - Chá»§ tá»ch HÄQT, TGÄ C&ocirc;ng ty Ho&agrave;ng Long; Nguyá»n Ä&igrave;nh Th&aacute;m - Ph&oacute; TGÄ C&ocirc;ng ty Ho&agrave;ng Long ki&ecirc;m TGÄ C&ocirc;ng ty JHL; Pháº¡m Thá» Háº¡nh (vá»£ cá»§a Nghi&ecirc;m Quá»c HÆ°ng); Äáº·ng Thá» PhÆ°Æ¡ng - Káº¿ to&aacute;n trÆ°á»ng C&ocirc;ng ty Ho&agrave;ng Long; Tráº§n Há»ng Háº¡nh; Nguyá»n Thá» Cáº©m Anh, nh&acirc;n vi&ecirc;n káº¿ to&aacute;n C&ocirc;ng ty Ho&agrave;ng Long Äá» Äiá»u tra vá» tá»i &quot;Vi pháº¡m quy Äá»nh vá» káº¿ to&aacute;n g&acirc;y háº­u quáº£ nghi&ecirc;m trá»ng&quot; quy Äá»nh táº¡i Äiá»u 221 Bá» luáº­t H&igrave;nh sá»±.</p>\r\n','914b7eba-23d5-4391-8906-5508490478b9.jpg',0,1,'2025-05-26');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_backup`
--

DROP TABLE IF EXISTS `article_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article_backup` (
  `article_id` int NOT NULL DEFAULT '0',
  `category_id` int NOT NULL,
  `admin_id` int NOT NULL,
  `title` mediumtext COLLATE utf8mb4_unicode_ci,
  `short_content` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `breaking_news` int NOT NULL,
  `headline` int NOT NULL,
  `created_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_backup`
--

LOCK TABLES `article_backup` WRITE;
/*!40000 ALTER TABLE `article_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `article_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Kinh táº¿','BÃ¡o kinh táº¿ lÃ  má»t loáº¡i hÃ¬nh bÃ¡o chÃ­ chuyÃªn cung cáº¥p thÃ´ng tin, phÃ¢n tÃ­ch vÃ  ÄÃ¡nh giÃ¡ cÃ¡c váº¥n Äá» liÃªn quan Äáº¿n kinh táº¿, tÃ i chÃ­nh, thá» trÆ°á»ng vÃ  doanh nghiá»p. DÆ°á»i ÄÃ¢y lÃ  mÃ´ táº£ chi tiáº¿t vá» bÃ¡o kinh táº¿:'),(2,'thá» thao','BÃ¡o chÃ­ thá» thao lÃ  má»t hÃ¬nh thá»©c viáº¿t bÃ¡o ÄÆ°a tin vá» cÃ¡c váº¥n Äá» liÃªn quan Äáº¿n chá»§ Äá» vÃ  cuá»c thi thá» thao.');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `article_id` int NOT NULL,
  `user_id` int NOT NULL,
  `content` text NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`comment_id`),
  CONSTRAINT `fk_articleId_comment` FOREIGN KEY (`comment_id`) REFERENCES `article` (`article_id`),
  CONSTRAINT `fk_userId_comment` FOREIGN KEY (`comment_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `full_name` varchar(45) NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-26 23:53:08
