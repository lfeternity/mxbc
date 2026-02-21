-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: sky_take_out
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address_book`
--

DROP TABLE IF EXISTS `address_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address_book` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `consignee` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '收货人',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `province_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认 0 否 1是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='地址簿';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_book`
--

LOCK TABLES `address_book` WRITE;
/*!40000 ALTER TABLE `address_book` DISABLE KEYS */;
INSERT INTO `address_book` VALUES (2,4,'刘飞','0','13133828236','11','北京市','1101','市辖区','110102','西城区','60','1',1);
/*!40000 ALTER TABLE `address_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int DEFAULT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '顺序',
  `status` int DEFAULT NULL COMMENT '分类状态 0:禁用，1:启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='菜品及套餐分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (11,1,'鲜冰淇淋',12,1,'2022-06-09 22:09:18','2026-01-12 20:55:52',1,1),(12,1,'鲜萃咖啡',11,1,'2022-06-09 22:09:32','2026-01-12 20:55:32',1,1),(13,2,'文创周边',12,1,'2022-06-09 22:11:38','2026-01-13 18:49:36',1,1),(15,2,'零食茶包',14,1,'2022-06-09 22:14:10','2026-01-13 18:44:28',1,1),(16,1,'当季新品',4,1,'2022-06-09 22:15:37','2026-01-12 20:52:57',1,1),(17,1,'限时活动',5,1,'2022-06-09 22:16:14','2026-01-12 20:54:01',1,1),(18,1,'蜜雪经典',6,1,'2022-06-09 22:17:42','2026-01-12 20:54:18',1,1),(19,1,'醇香奶茶',8,1,'2022-06-09 22:18:12','2026-01-12 20:54:45',1,1),(20,1,'真鲜果茶',9,1,'2022-06-09 22:22:29','2026-01-12 20:55:10',1,1),(21,1,'原叶纯茶',13,1,'2022-06-10 10:51:47','2026-01-13 18:49:25',1,1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dish`
--

DROP TABLE IF EXISTS `dish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dish` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '菜品名称',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `price` decimal(10,2) DEFAULT NULL COMMENT '菜品价格',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述信息',
  `status` int DEFAULT '1' COMMENT '0 停售 1 起售',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dish_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='菜品';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dish`
--

LOCK TABLES `dish` WRITE;
/*!40000 ALTER TABLE `dish` DISABLE KEYS */;
INSERT INTO `dish` VALUES (47,'布丁奶茶',19,7.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/f0a824d0-7396-4d16-bd89-8bc51ddc082c.png','还是小时候的味道',1,'2022-06-10 09:18:49','2026-01-13 18:37:01',1,1),(48,'三拼霸霸奶茶',19,8.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/7267d290-cbb5-4e36-a5b2-448acd8ed923.png','',1,'2022-06-10 09:22:54','2026-01-13 18:36:08',1,1),(49,'芋圆奶茶',19,8.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/b9124ec9-e934-434d-bb3f-2755a004dc7c.png','精选五常大米',1,'2022-06-10 09:30:17','2026-01-13 18:34:55',1,1),(50,'椰果奶茶',18,6.60,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/7f995b11-3f12-4100-9a16-7ac623aed4a1.png','优质面粉',1,'2022-06-10 09:34:28','2026-01-13 18:33:19',1,1),(51,'芒果雪王大圣代',11,6.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/d2f51a28-517d-4522-9b09-8ce1c7eb4636.png','原料：汤，草鱼，酸菜',1,'2022-06-10 09:40:51','2026-01-13 18:31:50',1,1),(52,'草莓雪王大圣代',11,6.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/98049bc1-6d0c-46b7-a021-7ef5e61aa499.png','原料：酸菜，江团，鮰鱼',1,'2022-06-10 09:46:02','2026-01-13 18:30:13',1,1),(53,'棒打鲜橙',17,6.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/ffbc439c-fea3-47e2-9819-f3db625711d6.png','原料：草鱼，汤',1,'2022-06-10 09:48:37','2026-01-13 18:28:06',1,1),(54,'四季春轻乳茶',17,6.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/8a02c26c-7941-44a5-8f61-ed478181917c.png','原料：小油菜',1,'2022-06-10 09:51:46','2026-01-13 18:26:50',1,1),(55,'蜜桃甘露',17,9.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/de1e1ab2-8dcb-45be-8e19-0f57b8c4b0c7.png','原料：蒜，娃娃菜',1,'2022-06-10 09:53:37','2026-01-13 18:25:38',1,1),(56,'黑糖拿铁',16,8.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/c5c3b45c-924b-4c39-ae53-a0649b69e399.png','原料：西兰花',1,'2022-06-10 09:55:44','2026-01-13 18:23:55',1,1),(57,'黑糖珍珠撞奶',16,6.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/e1768cd3-ee65-4a3b-8399-5db45be19b29.png','原料：圆白菜',1,'2022-06-10 09:58:35','2026-01-13 18:22:26',1,1),(58,'脆皮大圣代',11,7.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/52da74a5-eaf6-484d-b53d-739d67fbebac.png','原料：鲈鱼',1,'2022-06-10 10:12:28','2026-01-12 21:18:43',1,1),(59,'草莓摇摇奶昔',11,6.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/4b0794c6-569d-4b09-971f-d4f583501f15.png','原料：猪肘棒',1,'2022-06-10 10:24:03','2026-01-12 21:17:18',1,1),(60,'雪王大圣代奥利奥饼干风味',11,6.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/186f5e7b-77d7-4990-aa9f-70c713c3e251.png','原料：猪肉，梅菜',1,'2022-06-10 10:26:03','2026-01-12 21:13:51',1,1),(61,'芝士奶盖四季春',18,6.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/1d1591ac-701d-4733-8913-f1597dfb4fb0.png','原料：鲢鱼，剁椒',1,'2022-06-10 10:28:54','2026-01-12 21:12:37',1,1),(62,'冰鲜柠檬水',18,4.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/5c65bc78-4cbb-482f-9fff-7029375b2497.png','原料：鲜活牛蛙，酸菜',1,'2022-06-10 10:33:05','2026-01-12 21:11:25',1,1),(63,'珍珠奶茶',18,6.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/857279f6-509b-4276-933c-e7d341225757.png','配料：鲜活牛蛙，莲藕，青笋',1,'2022-06-10 10:35:40','2026-01-12 21:10:16',1,1),(64,'芝士奶盖绿茶',17,5.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/f839aebe-62c8-4797-845e-2058e2da233a.png','配料：鲜活牛蛙，丝瓜，黄豆芽',1,'2022-06-10 10:37:52','2026-01-12 21:09:15',1,1),(65,'草莓啵啵',16,10.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/2719d136-0c4e-451d-bf57-0ee78f29a638.png','原料：草鱼，黄豆芽，莲藕',1,'2022-06-10 10:41:08','2026-01-12 21:07:18',1,1),(66,'芋圆葡萄',16,10.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/1dd985d7-6493-4647-9492-9b0998b1dd3b.png','配料：江团鱼，黄豆芽，莲藕',1,'2022-06-10 10:42:42','2026-01-12 21:06:08',1,1),(67,'杨枝甘露',16,11.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/5a2140a2-57b2-4c13-8940-c08900afb4df.png','原料：鮰鱼，黄豆芽，莲藕',1,'2022-06-10 10:43:56','2026-01-12 21:04:17',1,1),(68,'拿铁咖啡',12,8.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/b97d75d0-787a-4039-b94f-41f5daf9bc33.png','配料：鸡蛋，紫菜',1,'2022-06-10 10:54:25','2026-01-12 21:03:14',1,1),(69,'雪王雪顶咖啡',12,7.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/9bd28d14-cda5-4a24-b378-cec078788599.png','666',1,'2022-06-10 10:55:02','2026-01-12 21:01:18',1,1),(73,'柠檬绿茶',20,4.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/feb50308-66e9-4842-9396-78266a308775.png','',1,'2026-01-13 18:38:51','2026-01-13 18:39:33',1,1),(75,'桃喜芒芒',20,6.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/5980f9c6-0f0e-45e5-b6fa-77c6dd864afb.png','',1,'2026-01-13 18:42:08','2026-01-13 18:43:32',1,1),(76,'满杯百香果',20,7.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/cc6b480b-13c5-4052-b2e1-f26f79a8b839.png','',1,'2026-01-13 18:43:24','2026-01-13 18:43:30',1,1),(77,'茉莉绿茶',21,4.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/62adea04-c6bf-46a3-bb2f-e338898da15f.png','',1,'2026-01-13 18:55:07','2026-01-13 18:55:12',1,1),(78,'高山四季春茶',21,4.00,'https://lf-takeout.oss-cn-beijing.aliyuncs.com/c33c85a5-b409-42b6-9871-2474f40b10f6.png','',1,'2026-01-13 18:56:39','2026-01-13 18:56:49',1,1);
/*!40000 ALTER TABLE `dish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dish_flavor`
--

DROP TABLE IF EXISTS `dish_flavor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dish_flavor` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dish_id` bigint NOT NULL COMMENT '菜品',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味名称',
  `value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味数据list',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='菜品口味关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dish_flavor`
--

LOCK TABLES `dish_flavor` WRITE;
/*!40000 ALTER TABLE `dish_flavor` DISABLE KEYS */;
INSERT INTO `dish_flavor` VALUES (40,10,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(41,7,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(42,7,'温度','[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]'),(45,6,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(46,6,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(47,5,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(48,5,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(49,2,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(50,4,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(51,3,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(52,3,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(104,69,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(105,68,'温度','[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]'),(106,67,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(107,66,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(108,65,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(109,64,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(110,63,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(111,62,'温度','[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]'),(112,61,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(113,60,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(114,59,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(115,58,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(117,57,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(119,56,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(120,55,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(121,54,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\"]'),(122,53,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(123,53,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(124,52,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(125,52,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(126,51,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(127,51,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(128,50,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(129,49,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(130,48,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(131,47,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(132,73,'温度','[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]'),(133,75,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(134,77,'温度','[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]'),(135,78,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
/*!40000 ALTER TABLE `dish_flavor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '身份证号',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态 0:禁用，1:启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='员工信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'管理员','admin','e10adc3949ba59abbe56e057f20f883e','13812312312','1','110101199001010047',1,'2022-02-15 15:51:20','2022-02-17 09:16:20',10,1),(2,'刘飞','liufei','e10adc3949ba59abbe56e057f20f883e','13133828236','1','150430200504240171',1,'2026-01-13 17:48:04','2026-01-13 17:48:04',1,1);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '名字',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `dish_id` bigint DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='订单明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (5,'鸡蛋汤','https://sky-itcast.oss-cn-beijing.aliyuncs.com/c09a0ee8-9d19-428d-81b9-746221824113.png',4,68,NULL,'无糖',1,4.00),(6,'杨枝甘露','https://lf-takeout.oss-cn-beijing.aliyuncs.com/5a2140a2-57b2-4c13-8940-c08900afb4df.png',5,67,NULL,'不辣',1,11.00),(7,'杨枝甘露','https://lf-takeout.oss-cn-beijing.aliyuncs.com/5a2140a2-57b2-4c13-8940-c08900afb4df.png',6,67,NULL,'不辣',1,11.00),(8,'杨枝甘露','https://lf-takeout.oss-cn-beijing.aliyuncs.com/5a2140a2-57b2-4c13-8940-c08900afb4df.png',7,67,NULL,'不辣',1,11.00),(9,'芝士奶盖绿茶','https://lf-takeout.oss-cn-beijing.aliyuncs.com/f839aebe-62c8-4797-845e-2058e2da233a.png',8,64,NULL,'无糖',1,5.00),(10,'杨枝甘露','https://lf-takeout.oss-cn-beijing.aliyuncs.com/5a2140a2-57b2-4c13-8940-c08900afb4df.png',9,67,NULL,'不辣',1,11.00),(11,'草莓啵啵','https://lf-takeout.oss-cn-beijing.aliyuncs.com/2719d136-0c4e-451d-bf57-0ee78f29a638.png',10,65,NULL,'不辣',1,10.00);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '订单号',
  `status` int NOT NULL DEFAULT '1' COMMENT '订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款',
  `user_id` bigint NOT NULL COMMENT '下单用户',
  `address_book_id` bigint NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `checkout_time` datetime DEFAULT NULL COMMENT '结账时间',
  `pay_method` int NOT NULL DEFAULT '1' COMMENT '支付方式 1微信,2支付宝',
  `pay_status` tinyint NOT NULL DEFAULT '0' COMMENT '支付状态 0未支付 1已支付 2退款',
  `amount` decimal(10,2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '备注',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '手机号',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '地址',
  `user_name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '用户名称',
  `consignee` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '收货人',
  `cancel_reason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '订单取消原因',
  `rejection_reason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '订单拒绝原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '订单取消时间',
  `estimated_delivery_time` datetime DEFAULT NULL COMMENT '预计送达时间',
  `delivery_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '配送状态  1立即送出  0选择具体时间',
  `delivery_time` datetime DEFAULT NULL COMMENT '送达时间',
  `pack_amount` int DEFAULT NULL COMMENT '打包费',
  `tableware_number` int DEFAULT NULL COMMENT '餐具数量',
  `tableware_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '餐具数量状态  1按餐量提供  0选择具体数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (4,'1768221257087',5,4,2,'2026-01-12 20:34:17','2026-01-12 20:34:19',1,1,11.00,'','13133828236','60',NULL,'刘飞',NULL,NULL,NULL,'2026-01-12 21:34:00',0,'2026-01-13 18:57:36',1,0,0),(5,'1768226907198',5,4,2,'2026-01-12 22:08:27','2026-01-12 22:08:29',1,1,18.00,'','13133828236','60',NULL,'刘飞',NULL,NULL,NULL,'2026-01-12 23:08:00',0,'2026-01-13 17:47:25',1,0,0),(6,'1768298453022',5,4,2,'2026-01-13 18:00:53','2026-01-13 18:00:56',1,1,18.00,'','13133828236','60',NULL,'刘飞',NULL,NULL,NULL,'2026-01-13 19:00:00',0,'2026-01-13 18:57:36',1,0,0),(7,'1768298565929',5,4,2,'2026-01-13 18:02:46','2026-01-13 18:02:47',1,1,18.00,'','13133828236','60',NULL,'刘飞',NULL,NULL,NULL,'2026-01-13 19:02:00',0,'2026-01-13 18:57:35',1,0,0),(8,'1768298658218',5,4,2,'2026-01-13 18:04:18','2026-01-13 18:04:19',1,1,12.00,'','13133828236','60',NULL,'刘飞',NULL,NULL,NULL,'2026-01-13 19:04:00',0,'2026-01-13 18:57:35',1,0,0),(9,'1768299000655',6,4,2,'2026-01-13 18:10:01','2026-01-13 18:10:02',1,1,18.00,'','13133828236','60',NULL,'刘飞',NULL,'订单量较多，暂时无法接单','2026-01-13 18:57:23','2026-01-13 19:09:00',0,NULL,1,0,0),(10,'1768299027024',5,4,2,'2026-01-13 18:10:27','2026-01-13 18:10:28',1,1,17.00,'','13133828236','60',NULL,'刘飞',NULL,NULL,NULL,'2026-01-13 19:10:00',0,'2026-01-13 18:57:34',1,0,0);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setmeal`
--

DROP TABLE IF EXISTS `setmeal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setmeal` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '套餐名称',
  `price` decimal(10,2) NOT NULL COMMENT '套餐价格',
  `status` int DEFAULT '1' COMMENT '售卖状态 0:停售 1:起售',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_setmeal_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='套餐';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setmeal`
--

LOCK TABLES `setmeal` WRITE;
/*!40000 ALTER TABLE `setmeal` DISABLE KEYS */;
INSERT INTO `setmeal` VALUES (33,13,'雪王不倒翁',1.00,1,'','https://lf-takeout.oss-cn-beijing.aliyuncs.com/1d5ac981-8062-43f4-ac1d-a8a80c72c64b.png','2026-01-13 18:46:06','2026-01-13 18:53:29',1,1),(34,15,'香瓜子',1.00,1,'','https://lf-takeout.oss-cn-beijing.aliyuncs.com/7d9bc57e-09d9-41e1-a3e8-07c5474b7dd7.png','2026-01-13 18:47:35','2026-01-13 18:53:05',1,1),(35,15,'爽脆魔芋',1.00,1,'','https://lf-takeout.oss-cn-beijing.aliyuncs.com/b46c2d40-01af-4d1d-9695-b6e2f8131121.png','2026-01-13 18:50:37','2026-01-13 18:53:04',1,1),(36,15,'雪王麻辣棒',1.00,1,'','https://lf-takeout.oss-cn-beijing.aliyuncs.com/a1e1cd08-511b-4c42-bd1f-1f129711a4e3.png','2026-01-13 18:51:51','2026-01-13 18:53:02',1,1),(37,13,'按压会跑雪王飞机',9.90,1,'','https://lf-takeout.oss-cn-beijing.aliyuncs.com/1ede06ab-537b-46bd-aa5c-5ab946c4547f.png','2026-01-13 18:52:53','2026-01-13 18:53:00',1,1);
/*!40000 ALTER TABLE `setmeal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setmeal_dish`
--

DROP TABLE IF EXISTS `setmeal_dish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setmeal_dish` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `setmeal_id` bigint DEFAULT NULL COMMENT '套餐id',
  `dish_id` bigint DEFAULT NULL COMMENT '菜品id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '菜品名称 （冗余字段）',
  `price` decimal(10,2) DEFAULT NULL COMMENT '菜品单价（冗余字段）',
  `copies` int DEFAULT NULL COMMENT '菜品份数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='套餐菜品关系';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setmeal_dish`
--

LOCK TABLES `setmeal_dish` WRITE;
/*!40000 ALTER TABLE `setmeal_dish` DISABLE KEYS */;
INSERT INTO `setmeal_dish` VALUES (49,34,65,'草莓啵啵',10.00,1),(50,35,56,'黑糖拿铁',8.00,1),(51,36,48,'三拼霸霸奶茶',8.00,1),(52,37,75,'桃喜芒芒',6.00,1),(53,33,67,'杨枝甘露',11.00,1);
/*!40000 ALTER TABLE `setmeal_dish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping_cart`
--

DROP TABLE IF EXISTS `shopping_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopping_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '商品名称',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `user_id` bigint NOT NULL COMMENT '主键',
  `dish_id` bigint DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='购物车';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_cart`
--

LOCK TABLES `shopping_cart` WRITE;
/*!40000 ALTER TABLE `shopping_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `shopping_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '微信用户唯一标识',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '头像',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='用户信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (4,'ol55y10_JbsBHdaxo8Mp9Ud3ylk0',NULL,NULL,NULL,NULL,NULL,'2026-01-12 20:28:34');
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

-- Dump completed on 2026-01-13 19:22:33
