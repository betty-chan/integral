/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : learn

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 15/07/2021 18:34:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for discuss
-- ----------------------------
DROP TABLE IF EXISTS `discuss`;
CREATE TABLE `discuss`  (
  `discuss_id` int NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `topic_id` int NOT NULL COMMENT '帖子id',
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
  `reply_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '回复者姓名',
  `reply_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '回复内容',
  `created_at` datetime(4) NOT NULL ON UPDATE CURRENT_TIMESTAMP(4) COMMENT '回复创建时间',
  `updated_at` datetime(4) NOT NULL,
  PRIMARY KEY (`discuss_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of discuss
-- ----------------------------
INSERT INTO `discuss` VALUES (10, 1, 'a9445c646fd54a3d950f52df473c0380', 'shawzhou', '我的天', '2018-11-12 07:47:19.0000', '2018-11-12 07:47:19.0000');
INSERT INTO `discuss` VALUES (11, 1, 'a9445c646fd54a3d950f52df473c0380', 'shawzhou', '呜呜呜', '2018-11-12 07:47:21.0000', '2018-11-12 07:47:21.0000');
INSERT INTO `discuss` VALUES (12, 1, 'a9445c646fd54a3d950f52df473c0380', 'shawzhou', '哈哈哈', '2018-11-12 07:47:24.0000', '2018-11-12 07:47:24.0000');
INSERT INTO `discuss` VALUES (13, 1, 'a9445c646fd54a3d950f52df473c0380', 'shawzhou', '啦啦', '2018-11-12 07:47:25.0000', '2018-11-12 07:47:25.0000');
INSERT INTO `discuss` VALUES (15, 1, 'a9445c646fd54a3d950f52df473c0380', 'shawzhou', 'wuuw', '2018-11-12 07:48:28.0000', '2018-11-12 07:48:28.0000');
INSERT INTO `discuss` VALUES (16, 1, 'a9445c646fd54a3d950f52df473c0380', 'shaw', '我的天(=@__@=)哪里？', '2018-11-14 09:17:17.0000', '2018-11-14 09:17:17.0000');
INSERT INTO `discuss` VALUES (17, 1, 'a9445c646fd54a3d950f52df473c0380', 'shaw', 'hi,my name is shawzhou', '2018-11-14 09:23:31.0000', '2018-11-14 09:23:31.0000');
INSERT INTO `discuss` VALUES (18, 1, 'a9445c646fd54a3d950f52df473c0380', 'shaw', 'lol', '2018-11-14 09:23:36.0000', '2018-11-14 09:23:36.0000');
INSERT INTO `discuss` VALUES (19, 3, 'e51c2d2e4366433fb35f017c69468149', 'woshishui', '好酷啊，天哪！！！', '2018-12-01 08:51:52.0000', '2018-12-01 08:51:52.0000');
INSERT INTO `discuss` VALUES (20, 2, 'e51c2d2e4366433fb35f017c69468149', 'woshishui', '帅气！！', '2018-12-01 08:51:59.0000', '2018-12-01 08:51:59.0000');
INSERT INTO `discuss` VALUES (21, 4, 'e51c2d2e4366433fb35f017c69468149', 'woshishui', '风景图！', '2018-12-01 08:52:09.0000', '2018-12-01 08:52:09.0000');
INSERT INTO `discuss` VALUES (22, 4, 'cbd6eb6093e74c7290aad936e8a9a2cd', 'shawzhou', '1212', '2021-01-08 09:27:27.0000', '2021-01-08 09:27:27.0000');
INSERT INTO `discuss` VALUES (23, 4, 'cbd6eb6093e74c7290aad936e8a9a2cd', 'shawzhou', '1212121', '2021-01-08 09:27:34.0000', '2021-01-08 09:27:34.0000');
INSERT INTO `discuss` VALUES (24, 2, 'cbd6eb6093e74c7290aad936e8a9a2cd', 'shawzhou', '12212', '2021-01-08 09:27:47.0000', '2021-01-08 09:27:47.0000');
INSERT INTO `discuss` VALUES (25, 4, 'cbd6eb6093e74c7290aad936e8a9a2cd', 'shawzhou', '1212', '2021-01-08 09:28:38.0000', '2021-01-08 09:28:38.0000');
INSERT INTO `discuss` VALUES (26, 3, 'cbd6eb6093e74c7290aad936e8a9a2cd', 'shawzhou', '12', '2021-01-11 02:53:12.0000', '2021-01-11 02:53:12.0000');
INSERT INTO `discuss` VALUES (27, 3, 'cbd6eb6093e74c7290aad936e8a9a2cd', 'shawzhou', '谢谢', '2021-01-11 02:53:22.0000', '2021-01-11 02:53:22.0000');
INSERT INTO `discuss` VALUES (28, 3, 'cbd6eb6093e74c7290aad936e8a9a2cd', 'shawzhou', '@woshishui 谢谢', '2021-01-11 06:56:40.0000', '2021-01-11 06:56:40.0000');
INSERT INTO `discuss` VALUES (29, 6, 'cbd6eb6093e74c7290aad936e8a9a2cd', 'shawzhou', '好看', '2021-02-05 08:10:23.0000', '2021-02-05 08:10:23.0000');
INSERT INTO `discuss` VALUES (30, 6, 'cbd6eb6093e74c7290aad936e8a9a2cd', 'shawzhou', '加油', '2021-02-05 08:10:39.0000', '2021-02-05 08:10:39.0000');
INSERT INTO `discuss` VALUES (31, 4, 'cbd6eb6093e74c7290aad936e8a9a2cd', 'shawzhou', '好看', '2021-02-05 08:10:50.0000', '2021-02-05 08:10:50.0000');

-- ----------------------------
-- Table structure for follow
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
  `followed_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '关注者id',
  `status` int NOT NULL COMMENT '关注状态 0:取消关注 1:已关注',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of follow
-- ----------------------------
INSERT INTO `follow` VALUES (5, 'c1dcc8a53ce6493ca05a357aac2d0aa4', 'a9445c646fd54a3d950f52df473c0380', 1, '2018-11-15 09:39:02', '2018-11-15 09:39:10');
INSERT INTO `follow` VALUES (6, 'a9445c646fd54a3d950f52df473c0380', 'c1dcc8a53ce6493ca05a357aac2d0aa4', 1, '2018-11-15 10:36:33', '2018-11-15 10:36:33');
INSERT INTO `follow` VALUES (7, 'cbd6eb6093e74c7290aad936e8a9a2cd', '9428c0cfedcf4850a0477969cdb2e6e2', 1, '2018-12-01 08:47:54', '2021-01-11 06:10:25');
INSERT INTO `follow` VALUES (8, 'e51c2d2e4366433fb35f017c69468149', 'cbd6eb6093e74c7290aad936e8a9a2cd', 1, '2018-12-01 08:53:34', '2021-01-28 03:35:19');
INSERT INTO `follow` VALUES (9, 'daabb0b0a90244a5b3204ac6779708dc', 'cbd6eb6093e74c7290aad936e8a9a2cd', 1, '2021-01-11 01:51:18', '2021-02-03 07:19:23');
INSERT INTO `follow` VALUES (10, '9428c0cfedcf4850a0477969cdb2e6e2', 'cbd6eb6093e74c7290aad936e8a9a2cd', 1, '2021-02-03 07:19:30', '2021-02-03 07:19:30');

-- ----------------------------
-- Table structure for sequelizemeta
-- ----------------------------
DROP TABLE IF EXISTS `sequelizemeta`;
CREATE TABLE `sequelizemeta`  (
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sequelizemeta
-- ----------------------------
INSERT INTO `sequelizemeta` VALUES ('20181012071252-init-users.js');
INSERT INTO `sequelizemeta` VALUES ('20181012072948-init-users.js');
INSERT INTO `sequelizemeta` VALUES ('20181018140213-init-topic.js');
INSERT INTO `sequelizemeta` VALUES ('20181019074022-init-discuss.js');
INSERT INTO `sequelizemeta` VALUES ('20181021093431-init-topic-like.js');
INSERT INTO `sequelizemeta` VALUES ('20181025024702-init-follow.js');

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic`  (
  `topic_id` int NOT NULL AUTO_INCREMENT COMMENT '帖子唯一id',
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
  `topic_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '帖子标题',
  `topic_img` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '帖子图片列表',
  `created_at` datetime NOT NULL COMMENT '帖子创建时间',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '帖子最后更新时间',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发表地址',
  PRIMARY KEY (`topic_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of topic
-- ----------------------------
INSERT INTO `topic` VALUES (1, 'a9445c646fd54a3d950f52df473c0380', '用户四帖子', '[\"http://p0.ifengimg.com/pmop/2017/1102/901DB09B75FD0FB5422F657D8706E493B04A10ED_size115_w1200_h675.jpeg\",\"https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Raijin-ogata-emuseum.JPG/300px-Raijin-ogata-emuseum.JPG\"]', '2018-11-05 01:45:40', '2018-11-05 01:45:40', '');
INSERT INTO `topic` VALUES (3, 'cbd6eb6093e74c7290aad936e8a9a2cd', '科比、篮球！！', '[\"http://img.article.pchome.net/00/22/99/77/pic_lib/wm/kb_01.jpg\",\"http://www.pc6.com/uploadimages/2009-11/2009112261377237.jpg\"]', '2018-12-01 08:47:24', '2018-12-01 08:47:24', '');
INSERT INTO `topic` VALUES (4, 'e51c2d2e4366433fb35f017c69468149', '风景图片', '[\"http://img3.3lian.com/2013/c2/80/d/1.jpg\",\"http://img3.3lian.com/2013/v11/41/d/81.jpg\"]', '2018-12-01 08:51:40', '2018-12-01 08:51:40', '');
INSERT INTO `topic` VALUES (6, 'cbd6eb6093e74c7290aad936e8a9a2cd', '好好建设产品', '[\"http://image.woshipm.com/wp-files/2019/08/p5xud8UQxogz3IacnFnp.jpg\"]', '2021-01-11 03:52:47', '2021-01-11 03:52:47', '');

-- ----------------------------
-- Table structure for topic_collect
-- ----------------------------
DROP TABLE IF EXISTS `topic_collect`;
CREATE TABLE `topic_collect`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
  `topic_id` int NOT NULL COMMENT '帖子id',
  `status` int NOT NULL COMMENT '状态1:有效,0:无效',
  `created_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of topic_collect
-- ----------------------------
INSERT INTO `topic_collect` VALUES (1, 'cbd6eb6093e74c7290aad936e8a9a2cd', 6, 0, '2021-02-03 06:45:49', '2021-02-03 06:45:49');
INSERT INTO `topic_collect` VALUES (2, 'cbd6eb6093e74c7290aad936e8a9a2cd', 4, 1, '2021-02-03 06:46:00', '2021-02-03 06:46:00');
INSERT INTO `topic_collect` VALUES (3, 'cbd6eb6093e74c7290aad936e8a9a2cd', 3, 0, '2021-02-03 06:44:05', '2021-02-03 06:44:05');

-- ----------------------------
-- Table structure for topic_like
-- ----------------------------
DROP TABLE IF EXISTS `topic_like`;
CREATE TABLE `topic_like`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
  `topic_id` int NOT NULL COMMENT '帖子id',
  `status` int NOT NULL COMMENT '点赞状态1:有效赞,0:无效赞',
  `created_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of topic_like
-- ----------------------------
INSERT INTO `topic_like` VALUES (1, 'cbd6eb6093e74c7290aad936e8a9a2cd', 6, 1, '2021-02-02 06:15:07', '2021-02-02 06:15:07');
INSERT INTO `topic_like` VALUES (2, 'cbd6eb6093e74c7290aad936e8a9a2cd', 4, 1, '2021-02-03 06:43:49', '2021-02-03 06:43:49');
INSERT INTO `topic_like` VALUES (3, 'cbd6eb6093e74c7290aad936e8a9a2cd', 3, 0, '2021-02-03 06:44:04', '2021-02-03 06:44:04');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `avatar_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `mobile` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `abstract` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (3, 'cbd6eb6093e74c7290aad936e8a9a2cd', 'shawzhou', '466150516@qq.com', '111111', 'https://s11.mogucdn.com/mlcdn/c45406/181105_60bdj928jdhjg9ehhg58hje1212ek_640x640.jpg', NULL, '86', '男', '2018-12-01 08:45:12', '2018-12-01 08:46:09', '我是一个球员');
INSERT INTO `users` VALUES (4, 'e51c2d2e4366433fb35f017c69468149', 'woshishui', 'codingzx@gmail.com', '111111', 'https://s11.mogucdn.com/mlcdn/c45406/181105_60bdj928jdhjg9ehhg58hje1212ek_640x640.jpg', NULL, '86', '男', '2018-12-01 08:47:47', '2018-12-01 08:52:30', '风景专家');
INSERT INTO `users` VALUES (5, 'daabb0b0a90244a5b3204ac6779708dc', 'wuwan', 'wuwantian@gmail.com', '111111', 'https://s11.mogucdn.com/mlcdn/c45406/181105_60bdj928jdhjg9ehhg58hje1212ek_640x640.jpg', NULL, '86', '女', '2018-12-01 08:52:49', '2018-12-01 08:54:58', NULL);
INSERT INTO `users` VALUES (6, '9428c0cfedcf4850a0477969cdb2e6e2', 'test', 'test@qq.com', '111111', 'https://s11.mogucdn.com/mlcdn/c45406/181105_60bdj928jdhjg9ehhg58hje1212ek_640x640.jpg', NULL, NULL, '男', '2021-01-11 06:09:46', '2021-01-11 06:09:46', NULL);

SET FOREIGN_KEY_CHECKS = 1;
