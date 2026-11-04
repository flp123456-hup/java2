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

 Date: 04/11/2026 09:56:21
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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台管理员表' ROW_FORMAT = DYNAMIC;

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
  `cover` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面图片路径',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '简介',
  `cast` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '演员资料(JSON数组: name/role/emoji/bio)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_hot`(`hot` ASC) USING BTREE,
  INDEX `idx_score`(`score` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '电视剧表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of drama
-- ----------------------------
INSERT INTO `drama` VALUES (1, '白月梵星', '古装,奇幻,爱情', 2025, 9.2, 9800, '40集', '热播', '🌙', 'linear-gradient(135deg,#6a5bff,#b14dff)', NULL, '上神之女白烁与妖王梵樾从针锋相对到并肩作战，携手守护苍生的东方奇幻爱情。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (2, '逐玉', '古装,传奇,权谋', 2026, 8.9, 8700, '40集', '独家', '♟️', 'linear-gradient(135deg,#ff7a59,#ff3d77)', NULL, '将门孤女逐玉执玉而归，在权谋倾轧中以智谋改写命运、守护家国的古装传奇。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (3, '卿卿日常', '古装,轻喜,爱情', 2022, 8.7, 8200, '40集', '热播', '🏮', 'linear-gradient(135deg,#1fd1f9,#2a6cff)', NULL, '少女李薇与六少主尹峥先婚后爱，新川大家庭鸡飞狗跳又温情满满的轻喜日常。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (4, '星汉灿烂', '古装,爱情,成长', 2022, 9.0, 9100, '56集', '独家', '⭐', 'linear-gradient(135deg,#43e97b,#38f9d7)', NULL, '留守少女程少商在缺爱中倔强成长，与少年将军凌不疑双向救赎、共赴家国。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (5, '长歌行', '古装,传奇,家国', 2021, 8.5, 7600, '49集', '热播', '🐎', 'linear-gradient(135deg,#ff6ec4,#7873f5)', NULL, '公主李长歌女扮男装流亡草原，在家国与恩仇之间坚守大义、终成传奇。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (6, '临江仙', '古装,仙侠,爱情', 2025, 9.1, 9500, '40集', '经典', '🌊', 'linear-gradient(135deg,#f6d365,#fda085)', NULL, '凡人江辞与上仙临江仙两世纠缠，一场跨越身份与生死的仙凡虐恋。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (7, '许我耀眼', '都市,爱情,励志', 2025, 8.8, 8900, '32集', '热播', '✨', 'linear-gradient(135deg,#30cfd0,#330867)', NULL, '都市里两个不完美的年轻人相遇，彼此照亮、互相成就，许下耀眼的未来。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (8, '花千骨', '古装,仙侠,虐恋', 2015, 8.6, 7400, '50集', '经典', '🌸', 'linear-gradient(135deg,#ffb347,#ffcc33)', NULL, '天煞孤星花千骨拜入长留仙山，与尊上白子画一段虐彻心扉的师徒之恋。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (9, '长月烬明', '古装,仙侠,奇幻', 2023, 9.3, 9900, '40集', '热播', '🌘', 'linear-gradient(135deg,#0f2027,#2c5364)', NULL, '上古魔神澹台烬生而无欢，神女黎苏苏逆时救世，救赎与宿命交织的仙侠史诗。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (10, '子夜归', '古装,悬疑,权谋', 2026, 8.9, 8500, '40集', '独家', '🕯️', 'linear-gradient(135deg,#c79081,#dfa579)', NULL, '子夜时分迷局重重，少年们在权谋与悬案中抽丝剥茧，寻回真相与本心。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (11, '老九门', '民国,悬疑,冒险', 2016, 8.4, 7100, '48集', '热播', '🔑', 'linear-gradient(135deg,#a8e063,#56ab2f)', NULL, '民国长沙九门提督守秘镇邪，张大佛爷率众深入地下，揭开百年悬疑。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (12, '且试天下', '古装,武侠,权谋', 2022, 9.0, 9300, '40集', '热播', '⚔️', 'linear-gradient(135deg,#ee0979,#ff6a00)', NULL, '黑丰息与白风夕江湖与庙堂双线博弈，棋逢对手、强强联手共定天下。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (13, '三生三世十里桃花', '古装,仙侠,爱情', 2017, 9.2, 9900, '58集', '经典', '🌸', 'linear-gradient(135deg,#ff9ed2,#ff5e9c)', '/covers/sanshengsanshi.jpg', '青丘白浅与九重天太子夜华历经三生三世的爱恨纠缠，最终打破宿命相守。', '[{\"name\":\"杨幂\",\"role\":\"白浅 / 素素 / 司音\",\"emoji\":\"🦊\",\"bio\":\"青丘女君，四海八荒第一绝色，与夜华历经三生三世终成眷属。\"},{\"name\":\"赵又廷\",\"role\":\"夜华 / 墨渊\",\"emoji\":\"🐉\",\"bio\":\"九重天太子，深情隐忍，为白浅甘愿付出一切。\"},{\"name\":\"迪丽热巴\",\"role\":\"白凤九\",\"emoji\":\"🦊\",\"bio\":\"青丘九尾红狐，灵动俏皮，痴情守候东华帝君。\"},{\"name\":\"张智尧\",\"role\":\"折颜\",\"emoji\":\"🍑\",\"bio\":\"开天辟地第一只火凤凰，种十里桃林，善酿酒行医。\"},{\"name\":\"高伟光\",\"role\":\"东华帝君\",\"emoji\":\"👑\",\"bio\":\"上古神祇，曾经的天地共主，气势威严心系六界。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (14, '香蜜沉沉烬如霜', '古装,仙侠,爱情', 2018, 9.0, 9700, '63集', '经典', '🔥', 'linear-gradient(135deg,#ff7a59,#ff3d77)', '/covers/xiangmi.jpg', '花神之女锦觅吞下陨丹断情绝爱，与天帝之子旭凤三世轮回的恩怨痴缠。', '[{\"name\":\"杨紫\",\"role\":\"锦觅\",\"emoji\":\"🍑\",\"bio\":\"花神之女，天真烂漫，吞陨丹断情绝爱，最终为爱苏醒。\"},{\"name\":\"邓伦\",\"role\":\"旭凤\",\"emoji\":\"🔥\",\"bio\":\"天帝之子火神，深情专一，为锦觅甘堕魔道。\"},{\"name\":\"罗云熙\",\"role\":\"润玉\",\"emoji\":\"🌙\",\"bio\":\"天帝长子夜神，温润如玉却因爱生恨走入歧途。\"},{\"name\":\"陈钰琪\",\"role\":\"鎏英\",\"emoji\":\"⚔️\",\"bio\":\"魔界公主，英姿飒爽，与奇鸢虐恋动人。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (15, '传闻中的陈芊芊', '古装,爱情,喜剧', 2020, 8.0, 9000, '24集', '经典', '🌹', 'linear-gradient(135deg,#ff6ec4,#ff9a3c)', NULL, '七流编剧陈小千穿进自己写的剧本，变成活不过三集的炮灰三公主，逆天改命。', '[{\"name\":\"赵露思\",\"role\":\"陈芊芊 / 陈小千\",\"emoji\":\"🌹\",\"bio\":\"误入自己剧本的三公主，古灵精怪，逆天改命。\"},{\"name\":\"丁禹兮\",\"role\":\"韩烁\",\"emoji\":\"🐯\",\"bio\":\"玄虎城少城主，腹黑深情，与芊芊先婚后爱。\"},{\"name\":\"盛英豪\",\"role\":\"裴恒\",\"emoji\":\"🌿\",\"bio\":\"花垣城司学，温润如玉、深情隐忍。\"},{\"name\":\"周紫馨\",\"role\":\"陈楚楚\",\"emoji\":\"🍃\",\"bio\":\"花垣城二公主，端庄善良却因嫉妒迷失。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (16, '因为遇见你', '都市,爱情,励志', 2017, 7.5, 8500, '56集', '经典', '🧵', 'linear-gradient(135deg,#6dd5ed,#4b6cb7)', '/covers/yujian.jpg', '同里馄饨店女孩张果果身负苏绣天赋，在时尚圈逆袭成长的励志故事。', '[{\"name\":\"孙怡\",\"role\":\"张果果\",\"emoji\":\"🧵\",\"bio\":\"同里馄饨店女孩，身负苏绣天赋的千金，励志逆袭。\"},{\"name\":\"邓伦\",\"role\":\"李云恺\",\"emoji\":\"⚖️\",\"bio\":\"正义律师，与果果从互相嫌弃到不离不弃。\"},{\"name\":\"吴优\",\"role\":\"张雨欣\",\"emoji\":\"💄\",\"bio\":\"果果的姐妹，留学归来的心机对手。\"},{\"name\":\"代超\",\"role\":\"李云哲\",\"emoji\":\"💼\",\"bio\":\"时创集团二把手，理性冷淡、心思缜密。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (17, '后浪', '都市,现实,励志', 2023, 7.8, 9200, '40集', '经典', '🌊', 'linear-gradient(135deg,#43cea2,#185a9d)', NULL, '中医药大学教授任新正辞职创办中医传承班，带领各行业学生传承中医药文化。', '[{\"name\":\"吴刚\",\"role\":\"任新正\",\"emoji\":\"🌿\",\"bio\":\"中医药大学教授，辞职创办中医传承班广传中医。\"},{\"name\":\"赵露思\",\"role\":\"孙头头\",\"emoji\":\"🌊\",\"bio\":\"混不吝的传承班开心果，身世成谜的侠气女孩。\"},{\"name\":\"罗一舟\",\"role\":\"任天真\",\"emoji\":\"🔥\",\"bio\":\"任新正之子，成长于中医世家，严谨有血性。\"},{\"name\":\"张萌\",\"role\":\"杨小红\",\"emoji\":\"⚖️\",\"bio\":\"精英律师，意外后走进传承班重寻人生。\"},{\"name\":\"江珊\",\"role\":\"宋灵兰\",\"emoji\":\"💐\",\"bio\":\"名医，任新正事业的最佳同路人。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (18, '沉香如屑·沉香重华', '古装,仙侠,爱情', 2022, 9.0, 9600, '59集', '经典', '🪷', 'linear-gradient(135deg,#a18cd1,#fbc2eb)', '/covers/chenxiang.jpg', '菡萏仙子颜淡与六界帝君应渊联手向恶势力宣战，相知相识解开误会守护苍生。', '[{\"name\":\"杨紫\",\"role\":\"颜淡\",\"emoji\":\"🪷\",\"bio\":\"天性善良的菡萏仙子，与应渊携手守护苍生。\"},{\"name\":\"成毅\",\"role\":\"应渊 / 唐周\",\"emoji\":\"⚔️\",\"bio\":\"守护结界的六界帝君，正直果敢的战神。\"},{\"name\":\"张睿\",\"role\":\"余墨\",\"emoji\":\"🐉\",\"bio\":\"妖王之子，颜淡挚友，一路相伴同行。\"},{\"name\":\"孟子义\",\"role\":\"芷昔\",\"emoji\":\"🌸\",\"bio\":\"颜淡双生姐姐，四叶菡萏化形。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (19, '嫁金钗', '古装,爱情', 2026, 8.5, 9800, '30集', '热播', '💍', 'linear-gradient(135deg,#f6d365,#fda085)', '/covers/jiajinchai.jpg', '承安伯府真千金魏娆幼年被换流落市井，为救养母假嫁战伤世子陆濯，智斗冒牌千金。', '[{\"name\":\"田曦薇\",\"role\":\"魏娆 / 君黛\",\"emoji\":\"💍\",\"bio\":\"承安伯府真千金，市井中坚韧成长，智斗冒牌千金。\"},{\"name\":\"闫桉\",\"role\":\"陆濯\",\"emoji\":\"🛡️\",\"bio\":\"战伤世子，被魏娆真情打动渐生情愫。\"},{\"name\":\"刘小北\",\"role\":\"戚仲恺\",\"emoji\":\"⚔️\",\"bio\":\"陆家相关角色，剧情张力十足。\"},{\"name\":\"潘珺雅\",\"role\":\"碧桃\",\"emoji\":\"🌿\",\"bio\":\"魏娆侍女，忠心耿耿暗护主。\"}]', '2026-10-28 09:43:21');

-- ----------------------------
-- Table structure for kids
-- ----------------------------
DROP TABLE IF EXISTS `kids`;
CREATE TABLE `kids`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '剧名',
  `genres` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型，逗号分隔，如 动画,少儿',
  `year` int NOT NULL COMMENT '年份',
  `score` decimal(2, 1) NOT NULL COMMENT '评分 0.0~10.0',
  `hot` int NOT NULL COMMENT '热度值（用于热度榜排序）',
  `episodes` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '集数/状态描述，如 104集 / 已完结',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标签：热播 / 独家 / 经典 / 治愈',
  `emoji` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '封面表情（无真实图片时用）',
  `gradient` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '封面渐变色 CSS，如 linear-gradient(135deg,#6a5bff,#b14dff)',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '简介',
  `cast` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '角色资料(JSON数组: name/role/emoji/bio)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_hot`(`hot` ASC) USING BTREE,
  INDEX `idx_score`(`score` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '少儿动画表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of kids
-- ----------------------------
INSERT INTO `kids` VALUES (1, '熊出没', '动画,少儿,喜剧', 2012, 9.0, 9900, '200+集', '经典', '🐻', 'linear-gradient(135deg,#43e97b,#38f9d7)', '森林里熊大、熊二与光头强之间妙趣横生的护林故事，寓教于乐，陪伴无数孩子成长。', '[{\"name\":\"熊大\",\"role\":\"主角（熊）\",\"emoji\":\"🐻\",\"bio\":\"聪明勇敢的狗熊哥哥，带领弟弟熊二保护森林。\"},{\"name\":\"熊二\",\"role\":\"主角（熊）\",\"emoji\":\"🐻\",\"bio\":\"憨厚贪吃的狗熊弟弟，常与熊大一起对付光头强。\"},{\"name\":\"光头强\",\"role\":\"伐木工\",\"emoji\":\"🪓\",\"bio\":\"想砍树赚钱的伐木工，常与两头熊斗智斗勇。\"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (2, '喜羊羊与灰太狼', '动画,少儿,喜剧', 2005, 8.8, 9800, '530集', '经典', '🐑', 'linear-gradient(135deg,#fddb92,#d1fdff)', '青青草原上，喜羊羊等小羊与灰太狼之间永不停歇的欢乐较量，国产动画国民IP。', '[{\"name\":\"喜羊羊\",\"role\":\"主角（羊）\",\"emoji\":\"🐑\",\"bio\":\"聪明机智的羊村小英雄，总能想出办法化解危机。\"},{\"name\":\"灰太狼\",\"role\":\"反派（狼）\",\"emoji\":\"🐺\",\"bio\":\"执着抓羊的狼，口头禅“我一定会回来的！”，其实很爱家人。\"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (3, '巴啦啦小魔仙', '动画,少儿,奇幻', 2008, 8.5, 9500, '52集', '经典', '✨', 'linear-gradient(135deg,#c471f5,#fa71cd)', '平凡女孩美琪、美雪结识魔仙小蓝，开启守护正义的魔法冒险，少女魔法启蒙经典。', '[{\"name\":\"小蓝\",\"role\":\"魔仙\",\"emoji\":\"🔮\",\"bio\":\"来自魔仙堡的魔仙，负责引导两位人类女孩学习魔法。\"},{\"name\":\"美琪 / 美雪\",\"role\":\"主角（人类）\",\"emoji\":\"✨\",\"bio\":\"一对姐妹，意外获得魔法能量，成为实习小魔仙。\"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (4, '小猪佩奇', '动画,少儿,启蒙', 2004, 8.6, 9000, '300+集', '经典', '🐷', 'linear-gradient(135deg,#ffb6c1,#ffdde1)', '粉色小猪佩奇一家温馨有趣的日常，跳泥坑、过生日，陪伴全球小朋友快乐成长。', '[{\"name\":\"佩奇\",\"role\":\"主角（小猪）\",\"emoji\":\"🐷\",\"bio\":\"活泼爱跳泥坑的小猪女孩，有个弟弟乔治。\"},{\"name\":\"乔治\",\"role\":\"弟弟（小猪）\",\"emoji\":\"🐤\",\"bio\":\"佩奇的弟弟，最爱抱着恐龙玩具。\"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (5, '超级飞侠', '动画,少儿,冒险', 2015, 8.4, 8800, '200+集', '热播', '✈️', 'linear-gradient(135deg,#4facfe,#00f2fe)', '会变形的飞机乐迪环游世界送包裹，和伙伴们帮助各地小朋友解决难题，开阔眼界。', '[{\"name\":\"乐迪\",\"role\":\"主角（飞机）\",\"emoji\":\"✈️\",\"bio\":\"最快的飞机快递员，每次都能把包裹准时送达。\"},{\"name\":\"小爱\",\"role\":\"救援直升机\",\"emoji\":\"🚁\",\"bio\":\"热心助人的救援直升机，关键时刻伸援手。\"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (6, '猪猪侠', '动画,少儿,冒险', 2005, 8.3, 8700, '500+集', '经典', '🐭', 'linear-gradient(135deg,#f7971e,#ffd200)', '小猪猪猪侠化身超级英雄，凭借勇气与智慧守护童话世界的正义，寓教于乐。', '[{\"name\":\"猪猪侠\",\"role\":\"主角（猪）\",\"emoji\":\"🐭\",\"bio\":\"贪吃贪玩却充满正义感的小猪，关键时刻总能挺身而出。\"},{\"name\":\"菲菲\",\"role\":\"伙伴（猪）\",\"emoji\":\"🌸\",\"bio\":\"聪明伶俐的小猪女孩，猪猪侠的好搭档。\"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (7, '海绵宝宝', '动画,少儿,喜剧', 1999, 9.1, 9600, '260+集', '经典', '🧽', 'linear-gradient(135deg,#fceabb,#f8b500)', '海底比奇堡里，海绵宝宝和派大星一连串无厘头又温暖的爆笑日常，老少皆宜。', '[{\"name\":\"海绵宝宝\",\"role\":\"主角（海绵）\",\"emoji\":\"🧽\",\"bio\":\"乐观天真的黄色海绵，最爱抓水母和做蟹黄堡。\"},{\"name\":\"派大星\",\"role\":\"好友（海星）\",\"emoji\":\"⭐\",\"bio\":\"海绵宝宝最好的朋友，呆萌却常常神助攻。\"}]', '2026-11-02 10:00:00');

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
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户登录记录表（用于统计登录人数/次数）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of login_record
-- ----------------------------
INSERT INTO `login_record` VALUES (1, 'xx', '2026-10-28 09:18:14', '2026-10-28 09:18:14');
INSERT INTO `login_record` VALUES (2, 'xx', '2026-10-30 15:58:39', '2026-10-30 15:58:39');
INSERT INTO `login_record` VALUES (3, 'xx', '2026-10-30 15:58:39', '2026-10-30 15:58:39');
INSERT INTO `login_record` VALUES (4, 'xx', '2026-10-30 15:59:45', '2026-10-30 15:59:45');
INSERT INTO `login_record` VALUES (5, 'xiyangyang', '2026-10-30 15:59:45', '2026-10-30 15:59:45');
INSERT INTO `login_record` VALUES (6, 'xx', '2026-10-30 16:01:03', '2026-10-30 16:01:03');
INSERT INTO `login_record` VALUES (7, 'xx', '2026-10-30 16:02:00', '2026-10-30 16:02:00');
INSERT INTO `login_record` VALUES (8, 'xx', '2026-10-30 16:20:58', '2026-10-30 16:20:58');
INSERT INTO `login_record` VALUES (9, 'xx', '2026-11-02 10:41:46', '2026-11-02 10:41:46');
INSERT INTO `login_record` VALUES (10, 'xx', '2026-11-02 11:00:46', '2026-11-02 11:00:46');
INSERT INTO `login_record` VALUES (11, 'xx', '2026-11-02 11:13:02', '2026-11-02 11:13:02');
INSERT INTO `login_record` VALUES (12, 'xx', '2026-11-02 11:27:13', '2026-11-02 11:27:13');
INSERT INTO `login_record` VALUES (13, 'xx', '2026-11-02 11:33:47', '2026-11-02 11:33:47');
INSERT INTO `login_record` VALUES (14, 'xx', '2026-11-02 11:44:58', '2026-11-02 11:44:58');
INSERT INTO `login_record` VALUES (15, 'xx', '2026-11-02 11:45:13', '2026-11-02 11:45:13');
INSERT INTO `login_record` VALUES (16, 'xx', '2026-11-02 11:45:46', '2026-11-02 11:45:46');
INSERT INTO `login_record` VALUES (17, 'xiyangyang', '2026-11-02 11:47:25', '2026-11-02 11:47:25');
INSERT INTO `login_record` VALUES (18, 'xx', '2026-11-02 11:51:33', '2026-11-02 11:51:33');
INSERT INTO `login_record` VALUES (19, 'xx', '2026-11-02 11:53:24', '2026-11-02 11:53:24');
INSERT INTO `login_record` VALUES (20, 'xx', '2026-11-04 08:34:41', '2026-11-04 08:34:41');
INSERT INTO `login_record` VALUES (21, 'xx', '2026-11-04 08:46:36', '2026-11-04 08:46:36');
INSERT INTO `login_record` VALUES (22, 'xx', '2026-11-04 08:53:00', '2026-11-04 08:53:00');
INSERT INTO `login_record` VALUES (23, 'xx', '2026-11-04 08:59:20', '2026-11-04 08:59:20');
INSERT INTO `login_record` VALUES (24, 'xx', '2026-11-04 09:08:42', '2026-11-04 09:08:42');
INSERT INTO `login_record` VALUES (25, 'xx', '2026-11-04 09:49:35', '2026-11-04 09:49:35');

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

-- ----------------------------
-- Table structure for variety
-- ----------------------------
DROP TABLE IF EXISTS `variety`;
CREATE TABLE `variety`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '节目名',
  `genres` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型，逗号分隔，如 综艺,真人秀',
  `year` int NOT NULL COMMENT '首播年份',
  `score` decimal(2, 1) NOT NULL COMMENT '评分 0.0~10.0',
  `hot` int NOT NULL COMMENT '热度值（用于热度榜排序）',
  `episodes` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '期数/季数描述，如 第1-2季 / 已完结',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标签：热播 / 独家 / 经典 / 治愈',
  `emoji` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '封面表情（无真实图片时用）',
  `gradient` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '封面渐变色 CSS，如 linear-gradient(135deg,#6a5bff,#b14dff)',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '简介',
  `cast` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '嘉宾资料(JSON数组: name/role/emoji/bio)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_hot`(`hot` ASC) USING BTREE,
  INDEX `idx_score`(`score` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '综艺节目表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of variety
-- ----------------------------
INSERT INTO `variety` VALUES (1, '现在就出发', '综艺,真人秀,户外', 2023, 8.7, 9200, '第1-2季', '热播', '🎤', 'linear-gradient(135deg,#fa709a,#fee140)', '沈腾领衔的轻松户外真人秀，一群好友说走就走，在路上制造爆笑与温情。', '[{\"name\":\"沈腾\",\"role\":\"常驻嘉宾\",\"emoji\":\"😆\",\"bio\":\"国民喜剧演员，自带笑点的“队宠”担当。\"},{\"name\":\"白敬亭\",\"role\":\"常驻嘉宾\",\"emoji\":\"🧢\",\"bio\":\"青年演员，活力满满的旅行搭子。\"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (2, '奔跑吧', '综艺,真人秀,竞技', 2014, 8.5, 9700, '第1-11季', '热播', '🏃', 'linear-gradient(135deg,#f857a6,#ff5858)', '国民级户外竞技真人秀，明星分队完成趣味任务，撕名牌名场面频出。', '[{\"name\":\"李晨\",\"role\":\"常驻嘉宾\",\"emoji\":\"💪\",\"bio\":\"“大黑牛”，力量担当，撕名牌高手。\"},{\"name\":\"Angelababy\",\"role\":\"常驻嘉宾\",\"emoji\":\"🌟\",\"bio\":\"活泼女神，奔跑团早期核心成员。\"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (3, '极限挑战', '综艺,真人秀,剧情', 2015, 9.0, 9600, '第1-10季', '经典', '🎯', 'linear-gradient(135deg,#0f2027,#2c5364)', '男人帮在充满反转的剧情任务中斗智斗勇，“这就是命”成经典梗，烧脑又爆笑。', '[{\"name\":\"黄磊\",\"role\":\"常驻嘉宾\",\"emoji\":\"🍳\",\"bio\":\"“神算子”老狐狸，智商担当。\"},{\"name\":\"黄渤\",\"role\":\"常驻嘉宾\",\"emoji\":\"🎬\",\"bio\":\"国民影帝，极限男人帮核心。\"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (4, '快乐大本营', '综艺,访谈,娱乐', 1997, 8.8, 9400, '已完结', '经典', '🎉', 'linear-gradient(135deg,#ff9a9e,#fecfef)', '陪伴几代人的国民综艺，游戏、访谈、歌舞，周五晚上的快乐源泉。', '[{\"name\":\"何炅\",\"role\":\"主持人\",\"emoji\":\"🎙️\",\"bio\":\"“何老师”，快乐家族灵魂主持。\"},{\"name\":\"谢娜\",\"role\":\"主持人\",\"emoji\":\"🌈\",\"bio\":\"搞笑担当，气氛组组长。\"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (5, '向往的生活', '综艺,慢综艺,生活', 2017, 8.6, 9100, '第1-6季', '治愈', '🏡', 'linear-gradient(135deg,#a8e063,#56ab2f)', '蘑菇屋里的慢生活，种菜、做饭、招待客人，用烟火气温暖治愈都市人的疲惫。', '[{\"name\":\"黄磊\",\"role\":\"常驻嘉宾\",\"emoji\":\"🍳\",\"bio\":\"蘑菇屋“黄小厨”，美食担当。\"},{\"name\":\"彭昱畅\",\"role\":\"常驻嘉宾\",\"emoji\":\"😋\",\"bio\":\"活泼懂事的小师弟，干饭主力。\"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (6, '歌手', '综艺,音乐,竞演', 2013, 8.9, 9300, '多季', '经典', '🎙️', 'linear-gradient(135deg,#6a11cb,#2575fc)', '顶尖歌手同台竞演的Live音乐综艺，用实力唱腔定义华语乐坛现场水准。', '[{\"name\":\"待补充\",\"role\":\"—\",\"emoji\":\"🎵\",\"bio\":\"每季嘉宾阵容不同，请按真实情况补充。\"}]', '2026-11-02 10:00:00');

SET FOREIGN_KEY_CHECKS = 1;
