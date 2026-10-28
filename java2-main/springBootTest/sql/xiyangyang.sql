/*
 Navicat Premium Dump SQL

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 80039 (8.0.39)
 Source Host           : localhost:3306
 Source Schema         : xiyangyang

 Target Server Type    : MySQL
 Target Server Version : 80039 (8.0.39)
 File Encoding         : 65001

 Date: 28/10/2026 09:53:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理员账号（唯一）',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码（明文存储，学习演示用）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_admin_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES (1, 'admin', 'admin123', '2026-10-28 09:02:58');

-- ----------------------------
-- Table structure for drama
-- ----------------------------
DROP TABLE IF EXISTS `drama`;
CREATE TABLE `drama`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '剧名',
  `genres` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型，逗号分隔，如 科幻,冒险',
  `year` int NOT NULL COMMENT '年份',
  `score` decimal(2, 1) NOT NULL COMMENT '评分 0.0~10.0',
  `hot` int NOT NULL COMMENT '热度值（用于热度榜排序）',
  `episodes` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '集数/状态描述，如 更新至18集 / 已完结',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标签：热播 / 独家 / 经典 / 治愈',
  `emoji` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '封面表情（无真实图片时用）',
  `gradient` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '封面渐变色 CSS，如 linear-gradient(135deg,#6a5bff,#b14dff)',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '简介',
  `cast` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '演员资料(JSON数组: name/role/emoji/bio)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_hot`(`hot` ASC) USING BTREE,
  INDEX `idx_score`(`score` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '电视剧表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drama
-- ----------------------------
INSERT INTO `drama` VALUES (1, '星河彼岸', '科幻,冒险', 2026, 9.2, 9800, '更新至18集', '热播', '🚀', 'linear-gradient(135deg,#6a5bff,#b14dff)', '地球资源枯竭，一支少年舰队穿越星河寻找新家园，在宇宙尽头邂逅了会发光的文明。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (2, '长安十二时辰·重启', '古装,悬疑', 2025, 8.9, 8700, '已完结', '独家', '🏮', 'linear-gradient(135deg,#ff7a59,#ff3d77)', '盛世长安暗流涌动，一名死囚在十二时辰内必须破解惊天阴谋，拯救一座城。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (3, '都市夜行人', '都市,刑侦', 2026, 8.7, 8200, '更新至24集', '热播', '🌃', 'linear-gradient(135deg,#1fd1f9,#2a6cff)', '霓虹下的城市从不入睡，一支深夜刑侦小队专破那些白天破不了的案子。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (4, '山海谣', '仙侠,奇幻', 2025, 9.0, 9100, '已完结', '独家', '⛰️', 'linear-gradient(135deg,#43e97b,#38f9d7)', '上古神兽苏醒，少女持山海图踏遍九州，在人与妖的边界寻找属于自己的道。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (5, '心跳信号', '青春,爱情', 2026, 8.5, 7600, '更新至12集', '热播', '💓', 'linear-gradient(135deg,#ff6ec4,#7873f5)', '校园电台的午夜节目把两个陌生人连在一起，每一次心跳都是未说出口的告白。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (6, '大江东去', '年代,励志', 2024, 9.1, 9500, '已完结', '经典', '🌊', 'linear-gradient(135deg,#f6d365,#fda085)', '改革开放浪潮中，一家三代人从摆地摊到做实业，写就一曲大江东去的奋斗长歌。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (7, '机甲纪元', '科幻,动作', 2026, 8.8, 8900, '更新至20集', '热播', '🤖', 'linear-gradient(135deg,#30cfd0,#330867)', '人类与AI共驾机甲迎战外星舰队，每一次出击都是文明存续的赌注。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (8, '人间烟火', '家庭,温情', 2025, 8.6, 7400, '已完结', '治愈', '🍲', 'linear-gradient(135deg,#ffb347,#ffcc33)', '一条老街、一家小馆、几户人家，最平凡的一日三餐里藏着最戳心的温柔。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (9, '暗夜追凶', '悬疑,推理', 2026, 9.3, 9900, '更新至16集', '热播', '🔦', 'linear-gradient(135deg,#0f2027,#2c5364)', '一桩陈年旧案重启，天才侧写师与冷面刑警联手，在谎言森林里追出真凶。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (10, '风起陇西·新章', '历史,权谋', 2025, 8.9, 8500, '已完结', '独家', '📜', 'linear-gradient(135deg,#c79081,#dfa579)', '三国暗战，谍影重重，一名小卒在刀光剑影的权谋棋局中左右着天下大势。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (11, '甜野之恋', '田园,治愈', 2026, 8.4, 7100, '更新至10集', '热播', '🌿', 'linear-gradient(135deg,#a8e063,#56ab2f)', '逃离都市的女孩在山谷开起民宿，与一位沉默的护林员慢炖出甜野味的爱情。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (12, '赛博长安', '科幻,古风', 2026, 9.0, 9300, '更新至22集', '热播', '🌐', 'linear-gradient(135deg,#ee0979,#ff6a00)', '大唐长安装上霓虹与义体，侠客以代码为剑，在赛博盛世的灯海里快意恩仇。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (13, '三生三世十里桃花', '古装,仙侠,爱情', 2017, 9.2, 9900, '58集', '经典', '🌸', 'linear-gradient(135deg,#ff9ed2,#ff5e9c)', '青丘白浅与九重天太子夜华历经三生三世的爱恨纠缠，最终打破宿命相守。', '[{\"name\":\"杨幂\",\"role\":\"白浅 / 素素 / 司音\",\"emoji\":\"🦊\",\"bio\":\"青丘女君，四海八荒第一绝色，与夜华历经三生三世终成眷属。\"},{\"name\":\"赵又廷\",\"role\":\"夜华 / 墨渊\",\"emoji\":\"🐉\",\"bio\":\"九重天太子，深情隐忍，为白浅甘愿付出一切。\"},{\"name\":\"迪丽热巴\",\"role\":\"白凤九\",\"emoji\":\"🦊\",\"bio\":\"青丘九尾红狐，灵动俏皮，痴情守候东华帝君。\"},{\"name\":\"张智尧\",\"role\":\"折颜\",\"emoji\":\"🍑\",\"bio\":\"开天辟地第一只火凤凰，种十里桃林，善酿酒行医。\"},{\"name\":\"高伟光\",\"role\":\"东华帝君\",\"emoji\":\"👑\",\"bio\":\"上古神祇，曾经的天地共主，气势威严心系六界。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (14, '香蜜沉沉烬如霜', '古装,仙侠,爱情', 2018, 9.0, 9700, '63集', '经典', '🔥', 'linear-gradient(135deg,#ff7a59,#ff3d77)', '花神之女锦觅吞下陨丹断情绝爱，与天帝之子旭凤三世轮回的恩怨痴缠。', '[{\"name\":\"杨紫\",\"role\":\"锦觅\",\"emoji\":\"🍑\",\"bio\":\"花神之女，天真烂漫，吞陨丹断情绝爱，最终为爱苏醒。\"},{\"name\":\"邓伦\",\"role\":\"旭凤\",\"emoji\":\"🔥\",\"bio\":\"天帝之子火神，深情专一，为锦觅甘堕魔道。\"},{\"name\":\"罗云熙\",\"role\":\"润玉\",\"emoji\":\"🌙\",\"bio\":\"天帝长子夜神，温润如玉却因爱生恨走入歧途。\"},{\"name\":\"陈钰琪\",\"role\":\"鎏英\",\"emoji\":\"⚔️\",\"bio\":\"魔界公主，英姿飒爽，与奇鸢虐恋动人。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (15, '传闻中的陈芊芊', '古装,爱情,喜剧', 2020, 8.0, 9000, '24集', '经典', '🌹', 'linear-gradient(135deg,#ff6ec4,#ff9a3c)', '七流编剧陈小千穿进自己写的剧本，变成活不过三集的炮灰三公主，逆天改命。', '[{\"name\":\"赵露思\",\"role\":\"陈芊芊 / 陈小千\",\"emoji\":\"🌹\",\"bio\":\"误入自己剧本的三公主，古灵精怪，逆天改命。\"},{\"name\":\"丁禹兮\",\"role\":\"韩烁\",\"emoji\":\"🐯\",\"bio\":\"玄虎城少城主，腹黑深情，与芊芊先婚后爱。\"},{\"name\":\"盛英豪\",\"role\":\"裴恒\",\"emoji\":\"🌿\",\"bio\":\"花垣城司学，温润如玉、深情隐忍。\"},{\"name\":\"周紫馨\",\"role\":\"陈楚楚\",\"emoji\":\"🍃\",\"bio\":\"花垣城二公主，端庄善良却因嫉妒迷失。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (16, '因为遇见你', '都市,爱情,励志', 2017, 7.5, 8500, '56集', '经典', '🧵', 'linear-gradient(135deg,#6dd5ed,#4b6cb7)', '同里馄饨店女孩张果果身负苏绣天赋，在时尚圈逆袭成长的励志故事。', '[{\"name\":\"孙怡\",\"role\":\"张果果\",\"emoji\":\"🧵\",\"bio\":\"同里馄饨店女孩，身负苏绣天赋的千金，励志逆袭。\"},{\"name\":\"邓伦\",\"role\":\"李云恺\",\"emoji\":\"⚖️\",\"bio\":\"正义律师，与果果从互相嫌弃到不离不弃。\"},{\"name\":\"吴优\",\"role\":\"张雨欣\",\"emoji\":\"💄\",\"bio\":\"果果的姐妹，留学归来的心机对手。\"},{\"name\":\"代超\",\"role\":\"李云哲\",\"emoji\":\"💼\",\"bio\":\"时创集团二把手，理性冷淡、心思缜密。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (17, '后浪', '都市,现实,励志', 2023, 7.8, 9200, '40集', '经典', '🌊', 'linear-gradient(135deg,#43cea2,#185a9d)', '中医药大学教授任新正辞职创办中医传承班，带领各行业学生传承中医药文化。', '[{\"name\":\"吴刚\",\"role\":\"任新正\",\"emoji\":\"🌿\",\"bio\":\"中医药大学教授，辞职创办中医传承班广传中医。\"},{\"name\":\"赵露思\",\"role\":\"孙头头\",\"emoji\":\"🌊\",\"bio\":\"混不吝的传承班开心果，身世成谜的侠气女孩。\"},{\"name\":\"罗一舟\",\"role\":\"任天真\",\"emoji\":\"🔥\",\"bio\":\"任新正之子，成长于中医世家，严谨有血性。\"},{\"name\":\"张萌\",\"role\":\"杨小红\",\"emoji\":\"⚖️\",\"bio\":\"精英律师，意外后走进传承班重寻人生。\"},{\"name\":\"江珊\",\"role\":\"宋灵兰\",\"emoji\":\"💐\",\"bio\":\"名医，任新正事业的最佳同路人。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (18, '沉香如屑·沉香重华', '古装,仙侠,爱情', 2022, 9.0, 9600, '59集', '经典', '🪷', 'linear-gradient(135deg,#a18cd1,#fbc2eb)', '菡萏仙子颜淡与六界帝君应渊联手向恶势力宣战，相知相识解开误会守护苍生。', '[{\"name\":\"杨紫\",\"role\":\"颜淡\",\"emoji\":\"🪷\",\"bio\":\"天性善良的菡萏仙子，与应渊携手守护苍生。\"},{\"name\":\"成毅\",\"role\":\"应渊 / 唐周\",\"emoji\":\"⚔️\",\"bio\":\"守护结界的六界帝君，正直果敢的战神。\"},{\"name\":\"张睿\",\"role\":\"余墨\",\"emoji\":\"🐉\",\"bio\":\"妖王之子，颜淡挚友，一路相伴同行。\"},{\"name\":\"孟子义\",\"role\":\"芷昔\",\"emoji\":\"🌸\",\"bio\":\"颜淡双生姐姐，四叶菡萏化形。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (19, '嫁金钗', '古装,爱情', 2026, 8.5, 9800, '30集', '热播', '💍', 'linear-gradient(135deg,#f6d365,#fda085)', '承安伯府真千金魏娆幼年被换流落市井，为救养母假嫁战伤世子陆濯，智斗冒牌千金。', '[{\"name\":\"田曦薇\",\"role\":\"魏娆 / 君黛\",\"emoji\":\"💍\",\"bio\":\"承安伯府真千金，市井中坚韧成长，智斗冒牌千金。\"},{\"name\":\"闫桉\",\"role\":\"陆濯\",\"emoji\":\"🛡️\",\"bio\":\"战伤世子，被魏娆真情打动渐生情愫。\"},{\"name\":\"刘小北\",\"role\":\"戚仲恺\",\"emoji\":\"⚔️\",\"bio\":\"陆家相关角色，剧情张力十足。\"},{\"name\":\"潘珺雅\",\"role\":\"碧桃\",\"emoji\":\"🌿\",\"bio\":\"魏娆侍女，忠心耿耿暗护主。\"}]', '2026-10-28 09:43:21');

-- ----------------------------
-- Table structure for login_record
-- ----------------------------
DROP TABLE IF EXISTS `login_record`;
CREATE TABLE `login_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录用户名',
  `login_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登录时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_login_time`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户登录记录表（用于统计登录人数/次数）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of login_record
-- ----------------------------
INSERT INTO `login_record` VALUES (1, 'xx', '2026-10-28 09:18:14', '2026-10-28 09:18:14');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名（唯一）',
  `password` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码（明文存储，最长18位；注册校验见 UserServiceImpl）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间，插入时自动填充',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'xiyangyang', '123456', '2026-10-23 16:54:05');
INSERT INTO `user` VALUES (2, 'xx', '123456', '2026-10-26 11:21:31');

SET FOREIGN_KEY_CHECKS = 1;
