/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : integral

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 06/08/2021 18:18:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_achieve
-- ----------------------------
DROP TABLE IF EXISTS `t_achieve`;
CREATE TABLE `t_achieve`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `medal_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_achieve
-- ----------------------------
INSERT INTO `t_achieve` VALUES (1, 1, 1993);

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `value` int NULL DEFAULT NULL COMMENT '标价',
  `on_shelf` tinyint NULL DEFAULT NULL COMMENT '是否在架',
  `cover_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图片',
  `other_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细图片',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '说明',
  `limit` int(10) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_goods
-- ----------------------------
INSERT INTO `t_goods` VALUES (4, '滑板', 50, 1, 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Skateboardvintage70s.JPG', NULL, '8岁+', NULL);
INSERT INTO `t_goods` VALUES (7, '杰克电动牙刷', 75, 1, 'https://jf-asset1.10086.cn/pic/ware/202106/60cc6e26a1a9ff755ce23bab.jpg', NULL, '0', NULL);
INSERT INTO `t_goods` VALUES (8, '蓝牙耳机', 100, 1, 'https://jf-asset1.10086.cn/pic/ware/5eb27e/c/5eb27ecd44d47f6f691403eb.jpg', NULL, '10+', NULL);
INSERT INTO `t_goods` VALUES (9, '背包', 10, 1, 'https://jf-asset1.10086.cn/pic/ware/5f1e74/8/5f1e74883c98ae50c345cf28.jpg', '', '0', NULL);
INSERT INTO `t_goods` VALUES (10, '红包', 100, 1, 'https://jf-asset2.10086.cn/pic/ware/202105/60ab606aa1a9ff755ce0439a.jpg', NULL, '0', NULL);
INSERT INTO `t_goods` VALUES (11, '电话手表', 200, 1, 'https://jf-asset2.10086.cn/pic/ware/202012/5fe05098928df22e3f1bbdeb.jpg', NULL, '5+', NULL);
INSERT INTO `t_goods` VALUES (12, '手机', 1000, 1, 'https://jf-asset2.10086.cn/pic/ware/202106/60cb1308a1a9ff755ce21891.jpg', NULL, '10+', NULL);

-- ----------------------------
-- Table structure for t_grade
-- ----------------------------
DROP TABLE IF EXISTS `t_grade`;
CREATE TABLE `t_grade`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '等级名称',
  `level` int NOT NULL COMMENT '等级值',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '等级特权说明',
  `score` int NULL DEFAULT NULL COMMENT '等级要求分值',
  `created_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建日期',
  `updated_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_grade
-- ----------------------------
INSERT INTO `t_grade` VALUES (1, '大众', 1, '1.i1i2', 0, '2021-07-29 16:27:14', '2021-07-29 16:27:14');
INSERT INTO `t_grade` VALUES (2, '黄金', 3, '12', 455, '2021-07-29 16:43:57', '2021-07-29 16:43:57');
INSERT INTO `t_grade` VALUES (3, '白银', 2, NULL, 200, NULL, NULL);

-- ----------------------------
-- Table structure for t_medal
-- ----------------------------
DROP TABLE IF EXISTS `t_medal`;
CREATE TABLE `t_medal`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `grey_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_medal
-- ----------------------------
INSERT INTO `t_medal` VALUES (1, '营养小达人', '../../static/diet.png', '学习营养学课程，并输出笔记', '../../static/grey_diet.png');
INSERT INTO `t_medal` VALUES (2, '环保勋章', '../../static/envira.png', '垃圾分类打卡7天以上', '../../static/grey_envira.png');

-- ----------------------------
-- Table structure for t_power
-- ----------------------------
DROP TABLE IF EXISTS `t_power`;
CREATE TABLE `t_power`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `grade_id` int NOT NULL COMMENT '等级id',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_power
-- ----------------------------
INSERT INTO `t_power` VALUES (1, 3, '零花钱5元/月');
INSERT INTO `t_power` VALUES (3, 3, 'pad使用2h/周');

-- ----------------------------
-- Table structure for t_record
-- ----------------------------
DROP TABLE IF EXISTS `t_record`;
CREATE TABLE `t_record`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `goods_id` int NULL DEFAULT NULL COMMENT '商品id',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_record
-- ----------------------------
INSERT INTO `t_record` VALUES (8, 9, 1993, '2021-07-29 06:25:47');
INSERT INTO `t_record` VALUES (9, 9, 1993, '2021-07-29 06:28:16');

-- ----------------------------
-- Table structure for t_sorce
-- ----------------------------
DROP TABLE IF EXISTS `t_sorce`;
CREATE TABLE `t_sorce`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
  `sorce` int NULL DEFAULT NULL COMMENT '分值',
  `created_at` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '说明',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '积分类型：等级、兑换',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `status` tinyint NULL DEFAULT NULL COMMENT '状态：1有效、2无效',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sorce
-- ----------------------------
INSERT INTO `t_sorce` VALUES (1, '1993', 5, '2021-07-16 18:29:23', '签到', '2', NULL, NULL);
INSERT INTO `t_sorce` VALUES (3, '1993', 5, '2021-07-23 03:42:52', '做家务', '2', '2021-07-23 03:42:52', NULL);
INSERT INTO `t_sorce` VALUES (4, '1997', 5, '2021-07-23 06:23:39', '签到', '2', '2021-07-23 06:23:39', NULL);
INSERT INTO `t_sorce` VALUES (12, '1993', -10, '2021-07-29 06:25:47', '积分兑换', '2', '2021-07-29 06:25:47', NULL);
INSERT INTO `t_sorce` VALUES (13, '1993', -10, '2021-07-29 06:28:16', '积分兑换', '2', '2021-07-29 06:28:16', NULL);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮箱',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `is_admin` tinyint NULL DEFAULT NULL COMMENT '是否管理员',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户标签',
  `birth` date NULL DEFAULT NULL COMMENT '出生年月',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1993', 'betty_chan@qq.com', '成名', '123456', 1, '管理员', NULL);
INSERT INTO `t_user` VALUES ('1997', 'beibei@.qq.com', '贝贝', '123123', 0, NULL, NULL);

-- ----------------------------
-- Table structure for t_wish
-- ----------------------------
DROP TABLE IF EXISTS `t_wish`;
CREATE TABLE `t_wish`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '愿望说明',
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_wish
-- ----------------------------
INSERT INTO `t_wish` VALUES (1, '我要一双滑板鞋', '1997', NULL, NULL);
INSERT INTO `t_wish` VALUES (3, '我要走走\n', '1993', '2021-07-28 03:28:39', '2021-07-28 03:28:39');
INSERT INTO `t_wish` VALUES (7, '考试100分\n', '1993', '2021-07-29 09:14:36', '2021-07-29 09:14:36');
INSERT INTO `t_wish` VALUES (8, '12312', '1993', '2021-08-02 05:49:33', '2021-08-02 05:49:33');

SET FOREIGN_KEY_CHECKS = 1;
