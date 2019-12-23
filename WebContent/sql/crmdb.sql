/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : crmdb

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 23/12/2019 08:39:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for askers
-- ----------------------------
DROP TABLE IF EXISTS `askers`;
CREATE TABLE `askers`  (
  `a_askerId` int(11) NOT NULL AUTO_INCREMENT,
  `a_askerName` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL,
  `a_checkState` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL,
  `a_checkInTime` datetime(0) NULL DEFAULT NULL,
  `a_changeState` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL,
  `a_weight` int(11) NULL DEFAULT NULL COMMENT '权重',
  `a_roleName` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '角色name',
  `a_bakContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '包含量',
  `us_id` int(11) NULL DEFAULT NULL COMMENT '咨询师id',
  PRIMARY KEY (`a_askerId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of askers
-- ----------------------------
INSERT INTO `askers` VALUES (1, 'NULL', '1', '2019-05-16 10:22:25', '1', 0, 'NULL', '包含分量', 3);
INSERT INTO `askers` VALUES (2, 'NULL', '1', '2019-05-16 10:22:25', '1', 0, 'NULL', '包含分量', 3);
INSERT INTO `askers` VALUES (3, 'NULL', '1', '2019-05-16 10:22:25', '1', 0, 'NULL', '包含分量', 9);
INSERT INTO `askers` VALUES (4, 'NULL', '1', '2019-05-16 10:22:25', '1', 0, 'NULL', '包含分量', 33);

-- ----------------------------
-- Table structure for chatfunction
-- ----------------------------
DROP TABLE IF EXISTS `chatfunction`;
CREATE TABLE `chatfunction`  (
  `p_id` int(11) NOT NULL AUTO_INCREMENT,
  `fszName` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL,
  `jszName` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL,
  `fsContext` varchar(500) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL,
  `fsTime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `isyidu` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL,
  PRIMARY KEY (`p_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chatfunction
-- ----------------------------
INSERT INTO `chatfunction` VALUES (1, 'admin', '岳治文', '你好sb', '2019-05-29 16:55:16', '是');
INSERT INTO `chatfunction` VALUES (2, 'admin', '岳治文', '你想不想要工资啦！', '2019-05-29 16:56:09', '是');
INSERT INTO `chatfunction` VALUES (4, '岳治文', 'admin', '想啊，大哥', '2019-05-29 16:56:59', '否');
INSERT INTO `chatfunction` VALUES (5, '岳治文', 'admin', '咋啦？', '2019-05-29 16:55:50', '是');
INSERT INTO `chatfunction` VALUES (6, 'admin', '岳治文1', '下班找我', '2019-05-29 18:23:02', '否');
INSERT INTO `chatfunction` VALUES (8, 'admin', '周炎1', '12312', '2019-05-29 19:00:20', '否');
INSERT INTO `chatfunction` VALUES (9, 'admin', '孙所蕾', '\ndjaskdbkasncjksacnkj', '2019-05-29 19:00:50', '否');
INSERT INTO `chatfunction` VALUES (10, 'admin', '岳治文', '\n12313', '2019-05-29 19:01:42', '是');
INSERT INTO `chatfunction` VALUES (11, '岳治文', 'admin', 'ckjd', '2019-05-29 19:01:59', '是');
INSERT INTO `chatfunction` VALUES (12, 'admin', '岳治文', '\ncnsndcs', '2019-05-29 19:02:18', '是');
INSERT INTO `chatfunction` VALUES (13, '周炎', 'admin', '在吗？', '2019-09-16 10:46:48', '否');

-- ----------------------------
-- Table structure for linepush
-- ----------------------------
DROP TABLE IF EXISTS `linepush`;
CREATE TABLE `linepush`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentid` int(11) NULL DEFAULT NULL,
  `zxname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `context` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `studentname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isreader` int(255) NULL DEFAULT NULL,
  `tstime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of linepush
-- ----------------------------
INSERT INTO `linepush` VALUES (1, 29, 'hupanyuan', '测试', '小明', 0, '2019-05-22 20:52:37');
INSERT INTO `linepush` VALUES (2, 136, 'hupanyuan', '测试', '汪峰', 0, '2019-05-22 20:52:37');

-- ----------------------------
-- Table structure for modules
-- ----------------------------
DROP TABLE IF EXISTS `modules`;
CREATE TABLE `modules`  (
  `m_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `m_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '模块名称',
  `m_parentId` int(11) NULL DEFAULT NULL COMMENT '父模块编号',
  `m_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '模块路径',
  `m_weight` int(11) NULL DEFAULT NULL COMMENT '权重',
  `m_ops` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '预留字符串字段',
  `m_int0` int(11) NULL DEFAULT NULL COMMENT '预留整数字段',
  PRIMARY KEY (`m_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of modules
-- ----------------------------
INSERT INTO `modules` VALUES (1, '系统管理', 0, NULL, 10, NULL, NULL);
INSERT INTO `modules` VALUES (3, '快捷服务', 0, NULL, 14, NULL, NULL);
INSERT INTO `modules` VALUES (4, '学生管理', 0, NULL, 8, NULL, NULL);
INSERT INTO `modules` VALUES (8, '用户管理', 1, 'yh', 99, NULL, NULL);
INSERT INTO `modules` VALUES (9, '角色管理', 1, 'jdgl', 78, NULL, NULL);
INSERT INTO `modules` VALUES (10, '模块管理', 1, 'Modules', 96, NULL, NULL);
INSERT INTO `modules` VALUES (33, '新生报到', 4, 'wlzxs', 99, NULL, NULL);
INSERT INTO `modules` VALUES (39, '学生信息', 4, 'zxs', 93, NULL, NULL);
INSERT INTO `modules` VALUES (75, '学生跟进', 4, 'xsgj', 21, NULL, NULL);
INSERT INTO `modules` VALUES (83, '管理学生', 4, 'yonghu', 21, NULL, NULL);
INSERT INTO `modules` VALUES (84, '员工签到', 4, 'ygqd', 12, NULL, NULL);
INSERT INTO `modules` VALUES (85, '分量操作', 4, 'flcz', 85, NULL, NULL);
INSERT INTO `modules` VALUES (91, '签到功能', 3, 'qd', 0, NULL, NULL);
INSERT INTO `modules` VALUES (95, '图表统计', 3, 'tbtj', 23, NULL, NULL);
INSERT INTO `modules` VALUES (96, '未分配学生', 4, 'wflxs', 96, NULL, NULL);
INSERT INTO `modules` VALUES (99, '聊天页面', 3, 'selectAllUsers', 100, NULL, NULL);
INSERT INTO `modules` VALUES (100, '员工管理', 3, 'yggl', 63, NULL, NULL);
INSERT INTO `modules` VALUES (101, '回收站', 4, 'hsz', 97, NULL, NULL);

-- ----------------------------
-- Table structure for netfollows
-- ----------------------------
DROP TABLE IF EXISTS `netfollows`;
CREATE TABLE `netfollows`  (
  `n_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_id` int(11) NULL DEFAULT NULL COMMENT '学生id（跟踪的谁？）',
  `s_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '学生姓名',
  `n_followTime` datetime(0) NULL DEFAULT NULL COMMENT '跟踪时间',
  `n_nextfollowTime` datetime(0) NULL DEFAULT NULL COMMENT '下一次跟踪的时间',
  `n_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '内容',
  `n_userid` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '员工id（谁跟踪的）',
  `n_followType` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '跟踪的类型',
  `n_createTime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `n_followState` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '跟随状态',
  PRIMARY KEY (`n_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of netfollows
-- ----------------------------
INSERT INTO `netfollows` VALUES (1, 1, '学生姓名连表去查', '2017-12-28 00:00:00', '2018-01-16 00:00:00', '跟踪内容', '3', '跟踪的类型', '2017-12-28 00:00:00', '跟随状态');
INSERT INTO `netfollows` VALUES (2, 2, '学生姓名连表去查', '2017-12-28 00:00:00', '2018-01-16 00:00:00', '跟踪内容', '3', '跟踪的类型', '2017-12-28 00:00:00', '跟随状态');
INSERT INTO `netfollows` VALUES (3, 3, '学生姓名连表去查', '2017-12-28 00:00:00', '2018-01-16 00:00:00', '跟踪内容', '3', '跟踪的类型', '2017-12-28 00:00:00', '跟随状态');
INSERT INTO `netfollows` VALUES (4, 4, '学生姓名连表去查', '2017-12-28 00:00:00', '2018-01-16 00:00:00', '跟踪内容', '3', '跟踪的类型', '2017-12-28 00:00:00', '跟随状态');
INSERT INTO `netfollows` VALUES (5, 5, '学生姓名连表去查', '2017-12-28 00:00:00', '2018-01-16 00:00:00', '跟踪内容', '3', '跟踪的类型', '2017-12-28 00:00:00', '跟随状态');
INSERT INTO `netfollows` VALUES (6, 6, '学生姓名连表去查', '2017-12-28 00:00:00', '2018-01-16 00:00:00', '跟踪内容', '3', '跟踪的类型', '2017-12-28 00:00:00', '跟随状态');
INSERT INTO `netfollows` VALUES (7, 7, '学生姓名连表去查', '2017-12-28 00:00:00', '2018-01-16 00:00:00', '跟踪内容', '3', '跟踪的类型', '2017-12-28 00:00:00', '跟随状态');
INSERT INTO `netfollows` VALUES (8, 8, '学生姓名连表去查', '2017-12-28 00:00:00', '2018-01-16 00:00:00', '跟踪内容', '3', '跟踪的类型', '2017-12-28 00:00:00', '跟随状态');
INSERT INTO `netfollows` VALUES (9, 9, '学生姓名连表去查', '2017-12-28 00:00:00', '2018-01-16 00:00:00', '跟踪内容', '3', '跟踪的类型', '2017-12-28 00:00:00', '跟随状态');
INSERT INTO `netfollows` VALUES (10, 10, '学生姓名连表去查', '2017-12-28 00:00:00', '2018-01-16 00:00:00', '跟踪内容', '3', '跟踪的类型', '2017-12-28 00:00:00', '跟随状态');
INSERT INTO `netfollows` VALUES (21, 3, '学生3号', '2019-05-09 00:00:00', '2019-05-23 00:00:00', '反馈与', '3', '看过', NULL, '框架');
INSERT INTO `netfollows` VALUES (22, 81, '123', '2019-05-03 00:00:00', '2019-05-24 00:00:00', '321', '3', '21', NULL, '21');
INSERT INTO `netfollows` VALUES (23, 81, '123', '2019-05-23 00:00:00', '2019-05-24 00:00:00', '还可以', '3', '跑着去的', NULL, '没事');
INSERT INTO `netfollows` VALUES (26, 6, '学生6号', '2019-05-23 00:00:00', '2019-05-24 00:00:00', '123', '3', '123', NULL, '123');
INSERT INTO `netfollows` VALUES (27, 78, 'ss', '2019-05-02 00:00:00', '2019-05-31 00:00:00', '123', '9', '123', NULL, '123');
INSERT INTO `netfollows` VALUES (28, 83, 'ceshhi2', '2019-05-15 00:00:00', '2019-05-30 00:00:00', '213', '9', '123', NULL, '123');
INSERT INTO `netfollows` VALUES (29, 32, '学生32号', '2019-05-01 00:00:00', '2019-05-29 00:00:00', '321', NULL, '321', NULL, '21');
INSERT INTO `netfollows` VALUES (30, 87, 'cscs', '2019-05-29 00:00:00', '2019-05-30 00:00:00', '123', NULL, '456', NULL, '123');
INSERT INTO `netfollows` VALUES (31, 88, '测试1', '2019-05-31 00:00:00', '2019-05-31 00:00:00', 'cdsvds', '43', 'csdcsd', NULL, 'cdsc');
INSERT INTO `netfollows` VALUES (32, 4, '学生4号', '2019-05-29 00:00:00', '2019-05-31 00:00:00', '132', '3', '123', NULL, '123');
INSERT INTO `netfollows` VALUES (33, 1, '学生1号', '2019-05-31 00:00:00', '2019-06-01 00:00:00', '123123123', '3', '123', NULL, '321');

-- ----------------------------
-- Table structure for push
-- ----------------------------
DROP TABLE IF EXISTS `push`;
CREATE TABLE `push`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentid` int(11) NULL DEFAULT NULL,
  `zxname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `context` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `studentname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isreader` int(255) NULL DEFAULT NULL COMMENT '1是已读，2是未读',
  `tstime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of push
-- ----------------------------
INSERT INTO `push` VALUES (7, 81, '周炎2', 'ncjkscjksdj', '岳治文', 1, '2019-05-25 14:57:49');
INSERT INTO `push` VALUES (8, 78, '周炎1', 'vsd', '岳治文', 1, '2019-05-30 14:43:32');
INSERT INTO `push` VALUES (11, 30, '周炎2', '哈哈哈', '岳治文', 1, '2019-05-26 10:01:30');
INSERT INTO `push` VALUES (12, 26, '周炎1', 'v但是v但是v', '岳治文', 1, '2019-05-30 14:43:32');
INSERT INTO `push` VALUES (13, 1, '周炎', '哈哈哈哈', '岳治文1', 1, '2019-05-30 12:26:12');
INSERT INTO `push` VALUES (22, 1, '周炎', 'cc', '岳治文1', 1, '2019-05-30 12:30:43');
INSERT INTO `push` VALUES (23, 30, '周炎2', 'dfghjkl', '岳治文', 1, '2019-05-31 01:21:22');
INSERT INTO `push` VALUES (24, 30, '周炎2', 'vsdvsdvsdvsdvsdv', '岳治文', 1, '2019-05-31 01:21:22');
INSERT INTO `push` VALUES (25, 30, '周炎2', 'vdvdv', '岳治文', 1, '2019-05-31 01:21:22');
INSERT INTO `push` VALUES (26, 30, '周炎2', 'vvvvvv', '岳治文', 1, '2019-05-31 01:21:22');
INSERT INTO `push` VALUES (27, 30, '周炎2', 'vvvv', '岳治文', 1, '2019-05-31 01:21:22');
INSERT INTO `push` VALUES (28, 6, '周炎', 'vvfefwefwe', '岳治文1', 1, '2019-05-30 12:30:43');
INSERT INTO `push` VALUES (29, 89, '周炎1', '你好', 'test1', 1, '2019-05-30 11:14:39');
INSERT INTO `push` VALUES (30, 6, '周炎', 'cbsacbhas', '岳治文1', 1, '2019-05-30 12:32:24');
INSERT INTO `push` VALUES (31, 5, '周炎', '你好', '岳治文1', 1, '2019-05-30 12:35:34');
INSERT INTO `push` VALUES (32, 2, '周炎', '测试', '岳治文1', 1, '2019-05-30 12:38:52');
INSERT INTO `push` VALUES (33, 2, '周炎', '测试', '岳治文1', 1, '2019-05-30 12:58:52');
INSERT INTO `push` VALUES (34, 3, '周炎', 'c此处', '岳治文1', 1, '2019-05-30 12:58:52');
INSERT INTO `push` VALUES (35, 1, '周炎', '此处', '岳治文1', 1, '2019-05-30 12:58:52');
INSERT INTO `push` VALUES (36, 1, '周炎', '此处', '岳治文1', 1, '2019-05-30 12:58:52');
INSERT INTO `push` VALUES (37, 1, '周炎', 'c从', '岳治文1', 1, '2019-05-30 12:58:52');
INSERT INTO `push` VALUES (38, 2, '周炎', '从', '岳治文1', 1, '2019-05-30 12:58:52');
INSERT INTO `push` VALUES (39, 2, '周炎', '得到', '岳治文1', 1, '2019-05-30 12:58:52');
INSERT INTO `push` VALUES (40, 2, '周炎', '从', '岳治文1', 1, '2019-05-30 12:58:52');
INSERT INTO `push` VALUES (41, 2, '周炎', '踩踩踩', '岳治文1', 1, '2019-05-30 12:58:52');
INSERT INTO `push` VALUES (42, 3, '周炎', '此处', '岳治文1', 1, '2019-05-30 12:58:52');
INSERT INTO `push` VALUES (43, 3, '周炎', '此处', '岳治文1', 1, '2019-05-30 12:58:52');
INSERT INTO `push` VALUES (44, 1, '周炎', '此处', '岳治文1', 1, '2019-05-30 13:08:30');
INSERT INTO `push` VALUES (45, 2, '周炎', '踩踩踩', '岳治文1', 1, '2019-05-30 13:08:30');
INSERT INTO `push` VALUES (46, 2, '周炎', '满妈妈', '岳治文1', 1, '2019-05-30 13:08:30');
INSERT INTO `push` VALUES (47, 2, '周炎', '踩踩踩', '岳治文1', 1, '2019-05-30 13:08:30');
INSERT INTO `push` VALUES (48, 2, '周炎', '此处', '岳治文1', 1, '2019-05-30 13:08:30');
INSERT INTO `push` VALUES (49, 1, '周炎', '此处', '岳治文1', 1, '2019-05-30 13:08:30');
INSERT INTO `push` VALUES (50, 2, '周炎', '得到', '岳治文1', 1, '2019-05-30 13:08:30');
INSERT INTO `push` VALUES (51, 2, '周炎', '此处', '岳治文1', 1, '2019-05-30 13:09:00');
INSERT INTO `push` VALUES (52, 1, '周炎', '踩踩踩', '岳治文1', 1, '2019-05-30 18:51:12');
INSERT INTO `push` VALUES (53, 32, '周炎1', '123', '岳治文', 2, '2019-05-31 10:12:33');

-- ----------------------------
-- Table structure for rolemodules
-- ----------------------------
DROP TABLE IF EXISTS `rolemodules`;
CREATE TABLE `rolemodules`  (
  `rm_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `r_id` int(11) NULL DEFAULT NULL COMMENT '角色编号',
  `m_id` int(11) NULL DEFAULT NULL COMMENT '功能模块编号',
  PRIMARY KEY (`rm_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 315 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rolemodules
-- ----------------------------
INSERT INTO `rolemodules` VALUES (1, 1, 4);
INSERT INTO `rolemodules` VALUES (54, 1, 39);
INSERT INTO `rolemodules` VALUES (55, 1, 3);
INSERT INTO `rolemodules` VALUES (56, 1, 26);
INSERT INTO `rolemodules` VALUES (57, 1, 25);
INSERT INTO `rolemodules` VALUES (58, 1, 28);
INSERT INTO `rolemodules` VALUES (59, 1, 31);
INSERT INTO `rolemodules` VALUES (60, 1, 32);
INSERT INTO `rolemodules` VALUES (61, 1, 5);
INSERT INTO `rolemodules` VALUES (62, 1, 57);
INSERT INTO `rolemodules` VALUES (63, 1, 60);
INSERT INTO `rolemodules` VALUES (64, 1, 64);
INSERT INTO `rolemodules` VALUES (65, 1, 6);
INSERT INTO `rolemodules` VALUES (66, 1, 4);
INSERT INTO `rolemodules` VALUES (67, 1, 75);
INSERT INTO `rolemodules` VALUES (72, 21, 1);
INSERT INTO `rolemodules` VALUES (73, 21, 10);
INSERT INTO `rolemodules` VALUES (74, 21, 8);
INSERT INTO `rolemodules` VALUES (75, 21, 9);
INSERT INTO `rolemodules` VALUES (115, 3, 1);
INSERT INTO `rolemodules` VALUES (116, 3, 8);
INSERT INTO `rolemodules` VALUES (266, 2, 0);
INSERT INTO `rolemodules` VALUES (267, 2, 1);
INSERT INTO `rolemodules` VALUES (268, 2, 10);
INSERT INTO `rolemodules` VALUES (269, 2, 3);
INSERT INTO `rolemodules` VALUES (270, 2, 8);
INSERT INTO `rolemodules` VALUES (271, 2, 9);
INSERT INTO `rolemodules` VALUES (272, 2, 99);
INSERT INTO `rolemodules` VALUES (290, 9, 3);
INSERT INTO `rolemodules` VALUES (291, 9, 33);
INSERT INTO `rolemodules` VALUES (292, 9, 4);
INSERT INTO `rolemodules` VALUES (293, 9, 99);
INSERT INTO `rolemodules` VALUES (294, 10, 3);
INSERT INTO `rolemodules` VALUES (295, 10, 39);
INSERT INTO `rolemodules` VALUES (296, 10, 4);
INSERT INTO `rolemodules` VALUES (297, 10, 99);
INSERT INTO `rolemodules` VALUES (306, 15, 101);
INSERT INTO `rolemodules` VALUES (307, 15, 3);
INSERT INTO `rolemodules` VALUES (308, 15, 4);
INSERT INTO `rolemodules` VALUES (309, 15, 83);
INSERT INTO `rolemodules` VALUES (310, 15, 84);
INSERT INTO `rolemodules` VALUES (311, 15, 85);
INSERT INTO `rolemodules` VALUES (312, 15, 95);
INSERT INTO `rolemodules` VALUES (313, 15, 96);
INSERT INTO `rolemodules` VALUES (314, 15, 99);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户组编号',
  `r_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '角色（用户组）名称',
  `r_int0` int(11) NULL DEFAULT NULL COMMENT '预留int',
  `r_string0` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '预留String',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (2, '管理员', NULL, NULL);
INSERT INTO `roles` VALUES (9, '网络咨询师', NULL, NULL);
INSERT INTO `roles` VALUES (10, '咨询师', NULL, NULL);
INSERT INTO `roles` VALUES (11, '学生', NULL, NULL);
INSERT INTO `roles` VALUES (15, '咨询师经理', NULL, NULL);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `s_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '客户名称',
  `s_sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '性别',
  `s_age` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '年龄',
  `s_iphone` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '客户手机号',
  `s_state` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '状态',
  `s_source` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '课程方向',
  `s_courceurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '来源渠道',
  `s_keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '来源关键词',
  `s_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '客户地址',
  `s_netpusherld` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL,
  `a_askerId` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '咨询师id',
  `s_qq` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT 'qq',
  `s_wx` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '微信号',
  `s_content` varchar(2000) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '内容',
  `s_createTime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `s_learnforward` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL,
  `s_isValid` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '有效（虚效）',
  `s_record` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '记录',
  `s_isreturnVist` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '是否回访',
  `s_fistVisitTime` datetime(0) NULL DEFAULT NULL COMMENT '首访时间',
  `s_ishome` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '是否上门',
  `s_homeTime` datetime(0) NULL DEFAULT NULL COMMENT '上门时间',
  `s_lostValid` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '无效原因',
  `s_ispay` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '是否缴费',
  `s_paytime` datetime(0) NULL DEFAULT NULL COMMENT '缴费时间',
  `s_money` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '收入',
  `s_isReturnMoney` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '是否退费',
  `s_returnMoneyTime` datetime(0) NULL DEFAULT NULL,
  `s_isInClass` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '是否进班',
  `s_inClassTime` datetime(0) NULL DEFAULT NULL COMMENT '进班时间',
  `s_inClassContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '进班备注',
  `s_askerContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '咨询师备注',
  `s_isdel` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '删除状态',
  `s_fromPart` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '来源渠道',
  `s_stuConcern` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '客户学历',
  `s_isbaobei` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '是否报备',
  `s_zixunName` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '咨询师备注',
  `s_createUser` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '录入的网络咨询师id',
  `s_returnMoneyReason` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '退费原因',
  `s_preMoney` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '定金金额',
  `s_preMoneyTime` datetime(0) NULL DEFAULT NULL COMMENT '定金时间',
  `u_id` int(11) NULL DEFAULT NULL COMMENT '员工id(咨询师）',
  PRIMARY KEY (`s_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, '学生1号', '男', '18', '13837805243', '1', 'JAVA开发工程师方向', '网上报名', '新乡学校哪个好？', '河南省开封市', '0', '3', '1312160198', 's1312160198', '这里显示的是内容区域站2000字符', '2019-05-22 00:00:00', 'C、长期跟踪', '否', '这里是记录内容', '未回访', '2018-12-22 00:00:00', '已上门', '2019-12-29 00:00:00', '无效原因', '已缴费', '2019-05-15 00:00:00', '3600.0', '未退费', '2018-12-28 00:00:00', '已进班', '2019-05-16 00:00:00', ',', '咨询师备注', '是', '网上报名', '高职', '否', '咨询师备注', '8', '退费原因', '1000.0', '2018-12-29 00:00:00', 3);
INSERT INTO `student` VALUES (2, '学生2号', '女', '19', '18625927502', '1', 'JAVA开发工程师方向', '网上报名', '新乡学校？', '河南省开封市', '0', '3', '1312160198', 's1312160198', '这里显示的是内容区域站2000字符', '2019-05-20 00:00:00', 'A、近期可报名', '是', '这里是记录内容', '未回访', '2017-11-22 00:00:00', '已上门', '2018-11-29 00:00:00', '无效原因', '已缴费', '2019-04-16 00:00:00', '3600.0', '未退费', '2018-12-28 00:00:00', '已进班', '2019-04-16 00:00:00', ',', '咨询师备注', '是', '网上报名', '高职', '否', '咨询师备注', '8', '退费原因', '1000.0', '2018-11-29 00:00:00', 3);
INSERT INTO `student` VALUES (3, '学生3号', '女', '19', '18625927502', '1', 'JAVA开发工程师方向', '网上报名', '新乡学校？', '河南省开封市', '0', '3', '1312160198', 's1312160198', '这里显示的是内容区域站2000字符', '2019-05-20 00:00:00', 'C、长期跟踪', '是', '这里是记录内容', '未回访', '2017-10-22 00:00:00', '未上门', '2018-10-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.0', '未退费', '2018-12-28 00:00:00', '已进班', '2019-04-15 00:00:00', '', '咨询师备注', '是', '网上报名', '高职', '否', '咨询师备注', '8', '退费原因', '1000.0', '2018-10-29 00:00:00', 3);
INSERT INTO `student` VALUES (4, '学生4号', '女', '20', '13837805243', '1', 'JAVA开发工程师方向', '学校联系', '新乡学校？', '河南省开封市', '0', '3', '1312160198', 's1312160198', '这里显示的是内容区域站2000字符', '2019-05-20 00:00:00', 'A、近期可报名', '是', '这里是记录内容', '已回访', '2017-10-22 00:00:00', '已上门', '2018-10-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.0', '未退费', '2018-12-28 00:00:00', '已进班', '2019-04-15 00:00:00', '', '咨询师备注', '是', '网上报名', '高职', '否', '咨询师备注', '8', '退费原因', '1000.0', '2018-10-29 00:00:00', 3);
INSERT INTO `student` VALUES (5, '学生5号', '女', '20', '13837805243', '1', 'JAVA开发工程师方向', '学校联系', '新乡学校？', '河南省开封市', '0', '3', '1312160198', 's1312160198', '这里显示的是内容区域站2000字符', '2019-05-22 00:00:00', 'C、长期跟踪', '是', '这里是记录内容', '未回访', '2017-10-22 00:00:00', '未上门', '2018-10-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.0', '未退费', '2018-12-28 00:00:00', '已进班', '2019-04-15 00:00:00', '', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '8', '退费原因', '1000.0', '2018-10-29 00:00:00', 3);
INSERT INTO `student` VALUES (6, '学生6号', '男', '21', '13837805243', '1', 'JAVA开发工程师方向', '学校联系', '新乡学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-22 00:00:00', 'B、一个月内可报名', '是', '这里是记录内容', '未回访', '2017-10-22 00:00:00', '已上门', '2018-10-29 00:00:00', '无效原因', '已缴费', '2019-05-31 00:00:00', '3600.0', '未退费', '2018-12-28 00:00:00', '已进班', '2019-06-01 00:00:00', '进班后找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '8', '退费原因', '1000.0', '2018-10-29 00:00:00', 3);
INSERT INTO `student` VALUES (7, '学生7号', '男', '22', '13837805243', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-21 00:00:00', '1', '是', '这里是记录内容', '未回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '8', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (8, '学生8号', '男', '24', '13837805243', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-21 00:00:00', '1', '是', '这里是记录内容', '未回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.0', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '8', '退费原因', '1000.0', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (9, '学生9号', '男', '25', '13837805243', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-21 00:00:00', '1', '是', '这里是记录内容', '未回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (10, '学生10号', '男', '26', '13837805243', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-21 00:00:00', '1', '是', '这里是记录内容', '未回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.0', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000.0', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (11, '学生11号', '男', '26', '12345678901', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-21 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (12, '学生12号', '男', '26', '9876543211', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-21 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (13, '学生13号', '女', '26', '9876543211', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-21 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (14, '学生14号', '女', '26', '9876543211', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-22 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (15, '学生15号', '女', '20', '9876543211', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-23 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (16, '学生16号', '女', '18', '9876543211', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-23 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (17, '学生17号', '女', '19', '9876543211', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-23 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (18, '学生18号', '女', '19', '9876543211', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-24 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 33);
INSERT INTO `student` VALUES (19, '学生19号', '男', '19', '9876543211', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-24 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 33);
INSERT INTO `student` VALUES (20, '学生20号', '男', '19', '9876543211', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-24 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 33);
INSERT INTO `student` VALUES (21, '学生21号', '男', '20', '9876543211', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-24 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 33);
INSERT INTO `student` VALUES (22, '学生22号', '男', '20', '13460754084', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-23 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 33);
INSERT INTO `student` VALUES (23, '学生23号', '女', '20', '13460754084', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-23 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 33);
INSERT INTO `student` VALUES (24, '学生24号', '女', '20', '13460754084', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-23 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 33);
INSERT INTO `student` VALUES (25, '学生25号', '女', '24', '13460754084', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-23 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 33);
INSERT INTO `student` VALUES (26, '学生26号', '女', '20', '13460754084', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-23 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (27, '学生27号', '男', '21', '13460754084', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-23 00:00:00', '1', '是', '这里是记录内容', '已回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (28, '学生28号', '男', '21', '13460754084', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-18 00:00:00', '1', '是', '这里是记录内容', '未回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (29, '学生31号', '女', '20', '13460754084', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-18 00:00:00', '1', '是', '这里是记录内容', '未回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '已缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (30, '学生29号', '女', '20', '13460754084', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-18 00:00:00', '1', '是', '这里是记录内容', '未回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '未缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 33);
INSERT INTO `student` VALUES (32, '学生32号', '女', '20', '13460754084', '1', '网站运营方向', '网上报名', '新乡的学校？', '河南省新乡市', '0', '3', '304566535', 's304566535', '这里显示的是内容区域站2000字符', '2019-05-19 00:00:00', '1', '是', '这里是记录内容', '未回访', '2017-09-22 00:00:00', '已上门', '2018-08-29 00:00:00', '无效原因', '未缴费', '2017-01-16 00:00:00', '3600.00', '未退费', '2018-02-28 00:00:00', '已进班', '2019-04-15 00:00:00', '进班找老师', '咨询师备注', '是', '网上报名', '中职', '否', '咨询师备注', '2', '退费原因', '1000', '2018-10-29 00:00:00', 9);
INSERT INTO `student` VALUES (77, 'adad', '女', '16', '11111111111', '1', NULL, 'sd', '', '', NULL, NULL, '', '', NULL, '2019-05-22 00:00:00', NULL, '是', NULL, '已回访', NULL, '已上门', '2019-05-31 01:36:36', NULL, '未缴费', NULL, NULL, '未退费', NULL, '未进班', NULL, ',', NULL, '是', 'sd', 'sds', '否', NULL, '2', NULL, NULL, NULL, 9);
INSERT INTO `student` VALUES (78, 'ss', '男', '16', '11111111111', '1', NULL, '', '', '', NULL, NULL, '', '', NULL, '2019-05-22 00:00:00', 'A.近期可报名', '否', NULL, '已回访', NULL, '已上门', '2019-05-31 01:36:42', NULL, '未缴费', NULL, NULL, '未退费', NULL, '未进班', NULL, ',,,', NULL, '否', '', '', '否', NULL, '2', NULL, NULL, NULL, 9);
INSERT INTO `student` VALUES (79, '123', '男', '16', '12', '1', NULL, '', '', '', NULL, NULL, '', '', NULL, '2019-05-22 00:00:00', NULL, '是', NULL, '已回访', NULL, '已上门', '2019-05-31 01:36:38', NULL, '未缴费', NULL, NULL, '未退费', NULL, '未进班', NULL, NULL, NULL, '是', '', '', '否', NULL, '8', NULL, NULL, NULL, 9);
INSERT INTO `student` VALUES (82, 'ceshi', '女', '16', '13837805243', '在读', '软件设计', '百度移动端', '热搜', NULL, NULL, NULL, '131216113', '1312311321', NULL, '2019-05-25 09:14:25', 'B、一个月内可报名', '是', NULL, '已回访', '2019-05-30 00:00:00', '已上门', '2019-05-31 01:37:23', NULL, '未缴费', NULL, NULL, '未退费', NULL, '未进班', NULL, '哈哈哈哈', '咨询师备注', '是', '职英A站', '大专', '否', NULL, '39', NULL, NULL, NULL, 3);
INSERT INTO `student` VALUES (83, 'ceshhi2', '女', '20', '13837805243', '未知', NULL, '360', '热搜', NULL, NULL, NULL, '1312160198', 'wx1312160198', NULL, '2019-05-25 09:45:53', NULL, '是', NULL, '已回访', NULL, '已上门', '2019-05-31 01:37:26', NULL, '未缴费', NULL, NULL, '未退费', NULL, '未进班', NULL, 'bebuzhu', NULL, '是', '其他', '未知', '否', NULL, '39', NULL, NULL, NULL, 9);
INSERT INTO `student` VALUES (84, '123', '男', '21', '13837805243', '未知', NULL, '百度移动端', '热搜', NULL, NULL, NULL, '1312160198', 'wx1312160198', NULL, '2019-05-25 09:55:00', NULL, '是', NULL, '已回访', NULL, '已上门', '2019-05-31 01:37:28', NULL, '未缴费', NULL, NULL, '未退费', NULL, '未进班', NULL, 'fgggg', NULL, '是', '其他', '未知', '是', NULL, '39', NULL, NULL, NULL, 33);
INSERT INTO `student` VALUES (85, 'ttt', '女', '16', '13837805243', '待业', NULL, '百度', '热搜', NULL, NULL, NULL, '1234567896', '123456789', NULL, '2019-05-25 14:11:47', NULL, '是', NULL, '已回访', NULL, '已上门', '2019-05-31 01:37:31', NULL, '未缴费', NULL, NULL, '未退费', NULL, '未进班', NULL, '123345666', NULL, '是', '职英B站', '高中', '否', NULL, '39', NULL, NULL, NULL, NULL);
INSERT INTO `student` VALUES (86, 'ttt1', '女', '30', '13837805243', '待业', NULL, '360', '360热搜', NULL, NULL, NULL, '1312160198', 'wx1312160198', NULL, '2019-05-25 14:13:20', NULL, '是', NULL, '已回访', NULL, '已上门', '2019-05-31 01:37:34', NULL, '未缴费', NULL, NULL, '未退费', NULL, '未进班', NULL, '123456', NULL, '是', '其他', '高中', '是', NULL, '39', NULL, NULL, NULL, NULL);
INSERT INTO `student` VALUES (88, '测试1', '男', '16', '13837805243', '未知', NULL, '百度移动端', '热搜', NULL, NULL, NULL, '1312160198', 'wx1312160198', NULL, '2019-05-30 11:10:58', NULL, '否', NULL, '已回访', NULL, '已上门', '2019-05-31 01:37:36', NULL, '未缴费', NULL, NULL, '未退费', NULL, '未进班', NULL, '这是网络咨询师的备注', NULL, '是', '职英A站', '未知', '否', NULL, '41', NULL, NULL, NULL, 43);
INSERT INTO `student` VALUES (89, '测试2', '男', '23', '13460754085', '未知', '软件设计', '百度', '热搜', NULL, NULL, NULL, '1312160198', 'wx131210165', NULL, '2019-05-30 11:12:13', NULL, '是', NULL, '未回访', NULL, '未上门', NULL, NULL, '未缴费', NULL, NULL, '未退费', NULL, '未进班', NULL, '网络备注', NULL, '是', '其他', '未知', '是', NULL, '41', NULL, NULL, NULL, 9);
INSERT INTO `student` VALUES (90, '阿瑟东1', '男', '16', '13612312312', '', NULL, '百度', '', NULL, NULL, NULL, '', '', NULL, '2019-05-31 10:13:04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '未缴费', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '是', '', '大专', '是', NULL, '2', NULL, NULL, NULL, 3);

-- ----------------------------
-- Table structure for userchecks
-- ----------------------------
DROP TABLE IF EXISTS `userchecks`;
CREATE TABLE `userchecks`  (
  `us_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_id` varchar(11) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '员工id',
  `us_userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL,
  `us_checkinTime` datetime(0) NULL DEFAULT NULL COMMENT '上班时间（打卡）',
  `us_checkState` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '是',
  `us_isCancel` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '否（否：下班不会自动执行打卡操作，是：到下班时间修改状态为否和下班时间）',
  `us_checkoutTime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '下班时间（打卡）',
  PRIMARY KEY (`us_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userchecks
-- ----------------------------
INSERT INTO `userchecks` VALUES (1, '2', '岳治文', '2019-05-23 09:43:10', '是', '是', '2019-05-16 18:18:02');
INSERT INTO `userchecks` VALUES (2, '3', '周炎', '2019-05-23 10:21:46', '是', '是', '2019-05-16 18:18:10');
INSERT INTO `userchecks` VALUES (3, '8', '岳治文1', '2019-05-28 10:06:59', '是', '是', '2019-05-16 18:18:17');
INSERT INTO `userchecks` VALUES (4, '9', '周炎1', '2019-05-16 18:23:01', '是', '是', '2019-05-15 19:23:44');
INSERT INTO `userchecks` VALUES (5, '31', '岳治文2', '2019-05-21 18:47:03', '是', '是', '2019-05-15 18:24:03');
INSERT INTO `userchecks` VALUES (6, '33', '周炎2', '2019-05-17 06:01:20', '是', '是', '2019-05-15 18:24:07');
INSERT INTO `userchecks` VALUES (8, '35', '孙所蕾', '2019-05-23 09:42:45', '是', '是', '2019-05-17 08:16:06');
INSERT INTO `userchecks` VALUES (9, '1', 'admin', '2019-05-24 11:24:23', '是', '是', '2019-05-24 11:24:16');
INSERT INTO `userchecks` VALUES (10, '39', 'test', '2019-05-25 09:12:25', '是', '是', '2019-05-25 09:07:20');
INSERT INTO `userchecks` VALUES (12, '41', 'test1', '2019-05-30 11:09:19', '是', '是', '2019-05-30 11:08:53');
INSERT INTO `userchecks` VALUES (13, '42', 'test2', '2019-05-30 23:37:50', '否', '否', '2019-05-30 15:27:36');
INSERT INTO `userchecks` VALUES (14, '43', 'tset3', '2019-05-30 15:46:50', '是', '是', '2019-05-30 15:46:02');

-- ----------------------------
-- Table structure for userroles
-- ----------------------------
DROP TABLE IF EXISTS `userroles`;
CREATE TABLE `userroles`  (
  `ur_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `u_id` int(11) NULL DEFAULT NULL COMMENT '用户编号',
  `r_id` int(11) NULL DEFAULT NULL COMMENT '角色编号',
  PRIMARY KEY (`ur_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userroles
-- ----------------------------
INSERT INTO `userroles` VALUES (17, 2, 9);
INSERT INTO `userroles` VALUES (18, 3, 10);
INSERT INTO `userroles` VALUES (19, 4, 15);
INSERT INTO `userroles` VALUES (20, 8, 9);
INSERT INTO `userroles` VALUES (22, 31, 9);
INSERT INTO `userroles` VALUES (23, 33, 10);
INSERT INTO `userroles` VALUES (27, 34, 15);
INSERT INTO `userroles` VALUES (33, 1, 2);
INSERT INTO `userroles` VALUES (36, 39, 9);
INSERT INTO `userroles` VALUES (39, 9, 10);
INSERT INTO `userroles` VALUES (40, 35, 15);
INSERT INTO `userroles` VALUES (41, 40, 10);
INSERT INTO `userroles` VALUES (43, 41, 10);
INSERT INTO `userroles` VALUES (44, 42, 10);
INSERT INTO `userroles` VALUES (45, 43, 10);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `u_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `u_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '登陆名',
  `u_pwd` varchar(200) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '密码',
  `u_isLockout` int(11) NULL DEFAULT NULL COMMENT '是否锁定',
  `u_lastLoginTime` datetime(0) NULL DEFAULT NULL COMMENT '最后一次登陆时间',
  `u_pwdWrongTime` int(11) NULL DEFAULT NULL COMMENT '密码输入错误次数',
  `u_createTime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '用户创建时间',
  `u_lockTime` datetime(0) NULL DEFAULT NULL COMMENT '被锁定时间',
  `u_protectEMail` varchar(25) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '密保邮箱',
  `u_protectMtel` varchar(11) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '密保手机号',
  `u_state` int(255) NULL DEFAULT NULL COMMENT '1代表开启自动分量，2代表没有开启自动分量',
  PRIMARY KEY (`u_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '683eb609607a439b0561dcbb4c8329e8', 1, '2019-05-24 16:57:32', 0, '2019-02-10 14:03:22', '2019-04-10 14:03:22', '13837805243@163.com', '13837805243', 0);
INSERT INTO `users` VALUES (2, '岳治文', 'd776be771e34293953d66ebc052d0524', 1, '2019-05-24 15:00:21', 0, '2019-02-10 14:03:22', '2019-04-10 14:04:24', '18625927502@163.com', '18625927505', 1);
INSERT INTO `users` VALUES (3, '周炎', 'd776be771e34293953d66ebc052d0524', 1, '2019-05-24 09:00:49', 0, '2019-02-10 14:03:22', '2019-04-10 14:14:55', '1312160198@qq.com', '13837805246', 0);
INSERT INTO `users` VALUES (8, '岳治文1', 'd776be771e34293953d66ebc052d0524', 1, '2019-05-24 11:26:32', 0, '2019-05-14 12:41:20', NULL, '13837@16.c', '1383780', 1);
INSERT INTO `users` VALUES (9, '周炎1', '683eb609607a439b0561dcbb4c8329e8', 1, '2019-05-16 10:16:17', 0, '2019-05-14 12:41:31', NULL, '13837@16.c', '1383780', 0);
INSERT INTO `users` VALUES (31, '岳治文2', 'd776be771e34293953d66ebc052d0524', 1, '2019-05-16 10:16:22', 0, '2019-05-15 17:56:28', NULL, '14!16@q.c', '123456', 1);
INSERT INTO `users` VALUES (33, '周炎2', 'd776be771e34293953d66ebc052d0524', 1, '2019-05-17 06:01:17', 0, '2019-05-15 18:44:29', NULL, '123@qq.c', '123', 0);
INSERT INTO `users` VALUES (35, '孙所蕾', 'd776be771e34293953d66ebc052d0524', 1, '2019-05-24 16:08:00', 0, '2019-05-23 01:41:10', NULL, '13837805243@163.com', '13837805244', NULL);
INSERT INTO `users` VALUES (39, 'test', '683eb609607a439b0561dcbb4c8329e8', 1, '2019-05-30 09:24:47', 0, '2019-05-25 09:07:20', NULL, '13@1.c', '13837805259', 2);
INSERT INTO `users` VALUES (41, 'test1', 'd776be771e34293953d66ebc052d0524', 1, NULL, 0, '2019-05-30 11:08:53', NULL, '13837805243@qq.com', '13837805248', 1);
INSERT INTO `users` VALUES (42, 'test2', 'd776be771e34293953d66ebc052d0524', 1, NULL, 0, '2019-05-30 15:27:36', NULL, '138378052@163.com', '13837805247', 2);
INSERT INTO `users` VALUES (43, 'tset3', 'd776be771e34293953d66ebc052d0524', 1, NULL, 0, '2019-05-30 15:46:02', NULL, '123456@163.com', '13536364588', 2);

-- ----------------------------
-- Procedure structure for NewProc
-- ----------------------------
DROP PROCEDURE IF EXISTS `NewProc`;
delimiter ;;
CREATE PROCEDURE `NewProc`()
BEGIN
	#Routine body goes here...
	  SET @time = NOW();
    SET @item = 'num';
    SET @type = 'day';
		update userchecks set us_checkState='否' where us_isCancel='是';
END
;;
delimiter ;

-- ----------------------------
-- Event structure for events
-- ----------------------------
DROP EVENT IF EXISTS `events`;
delimiter ;;
CREATE EVENT `events`
ON SCHEDULE
EVERY '1' DAY STARTS '2019-05-22 00:00:00'
DO call NewProc()
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
