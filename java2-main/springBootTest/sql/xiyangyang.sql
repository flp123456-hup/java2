/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80044 (8.0.44)
 Source Host           : localhost:3306
 Source Schema         : xiyangyang

 Target Server Type    : MySQL
 Target Server Version : 80044 (8.0.44)
 File Encoding         : 65001

 Date: 11/11/2026 20:37:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for actor
-- ----------------------------
DROP TABLE IF EXISTS `actor`;
CREATE TABLE `actor`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '演员/嘉宾姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像图片路径，如 /actors/杨幂.jpg',
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '简介',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_actor_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '演员/嘉宾表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of actor
-- ----------------------------
INSERT INTO `actor` VALUES (1, '杨幂', '/actors/杨幂.jpg', '青丘女君，与夜华历经三生三世终成眷属。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (2, '赵又廷', '/actors/赵又廷.jpg', '九重天太子，深情隐忍，为白浅甘愿付出一切。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (3, '迪丽热巴', '/actors/迪丽热巴.jpg', '青丘九尾红狐，灵动俏皮，痴情守候东华帝君。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (4, '张智尧', '/actors/张智尧.jpg', '开天辟地第一只火凤凰，种十里桃林，善酿酒行医。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (5, '高伟光', '/actors/高伟光.jpg', '上古神祇，曾经的天地共主，气势威严心系六界。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (6, '杨紫', '/actors/杨紫.jpg', '花神之女，天真烂漫，吞陨丹断情绝爱，最终为爱苏醒。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (7, '邓伦', '/actors/邓伦.jpg', '天帝之子火神，深情专一，为锦觅甘堕魔道。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (8, '罗云熙', '/actors/罗云熙.jpg', '天帝长子夜神，温润如玉却因爱生恨走入歧途。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (9, '陈钰琪', '/actors/陈钰琪.jpg', '魔界公主，英姿飒爽，与奇鸢虐恋动人。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (10, '赵露思', '/actors/赵露思.jpg', '误入自己剧本的三公主，古灵精怪，逆天改命。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (11, '丁禹兮', '/actors/丁禹兮.jpg', '玄虎城少城主，腹黑深情，与芊芊先婚后爱。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (12, '盛英豪', '/actors/盛英豪.jpg', '花垣城司学，温润如玉、深情隐忍。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (13, '周紫馨', '/actors/周紫馨.jpg', '花垣城二公主，端庄善良却因嫉妒迷失。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (14, '孙怡', '/actors/孙怡.jpg', '同里馄饨店女孩，身负苏绣天赋的千金，励志逆袭。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (15, '吴优', '/actors/吴优.jpg', '果果的姐妹，留学归来的心机对手。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (16, '代超', '/actors/代超.jpg', '时创集团二把手，理性冷淡、心思缜密。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (17, '吴刚', '/actors/吴刚.jpg', '中医药大学教授，辞职创办中医传承班广传中医。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (18, '罗一舟', '/actors/罗一舟.jpg', '任新正之子，成长于中医世家，严谨有血性。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (19, '张萌', '/actors/张萌.jpg', '精英律师，意外后走进传承班重寻人生。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (20, '江珊', '/actors/江珊.jpg', '名医，任新正事业的最佳同路人。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (21, '成毅', '/actors/成毅.jpg', '守护结界的六界帝君，正直果敢的战神。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (22, '张睿', '/actors/张睿.jpg', '妖王之子，颜淡挚友，一路相伴同行。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (23, '孟子义', '/actors/孟子义.jpg', '颜淡双生姐姐，四叶菡萏化形。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (24, '田曦薇', '/actors/田曦薇.jpg', '承安伯府真千金，市井中坚韧成长，智斗冒牌千金。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (25, '闫桉', '/actors/闫桉.jpg', '战伤世子，被魏娆真情打动渐生情愫。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (26, '刘小北', '/actors/刘小北.jpg', '陆家相关角色，剧情张力十足。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (27, '潘珺雅', '/actors/潘珺雅.jpg', '魏娆侍女，忠心耿耿暗护主。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (28, '熊大', '/actors/熊大.jpg', '聪明勇敢的狗熊哥哥，带领弟弟熊二保护森林。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (29, '熊二', '/actors/熊二.jpg', '憨厚贪吃的狗熊弟弟，常与熊大一起对付光头强。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (30, '光头强', '/actors/光头强.jpg', '想砍树赚钱的伐木工，常与两头熊斗智斗勇。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (31, '喜羊羊', '/actors/喜羊羊.jpg', '聪明机智的羊村小英雄，总能想出办法化解危机。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (32, '灰太狼', '/actors/灰太狼.jpg', '执着抓羊的狼，口头禅“我一定会回来的！”，其实很爱家人。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (33, '小蓝', '/actors/小蓝.jpg', '来自魔仙堡的魔仙，负责引导两位人类女孩学习魔法。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (34, '美琪 / 美雪', '/actors/美琪 / 美雪.jpg', '一对姐妹，意外获得魔法能量，成为实习小魔仙。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (35, '佩奇', '/actors/佩奇.jpg', '活泼爱跳泥坑的小猪女孩，有个弟弟乔治。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (36, '乔治', '/actors/乔治.jpg', '佩奇的弟弟，最爱抱着恐龙玩具。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (37, '乐迪', '/actors/乐迪.jpg', '最快的飞机快递员，每次都能把包裹准时送达。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (38, '小爱', '/actors/小爱.jpg', '热心助人的救援直升机，关键时刻伸援手。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (39, '猪猪侠', '/actors/猪猪侠.jpg', '贪吃贪玩却充满正义感的小猪，关键时刻总能挺身而出。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (40, '菲菲', '/actors/菲菲.jpg', '聪明伶俐的小猪女孩，猪猪侠的好搭档。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (41, '海绵宝宝', '/actors/海绵宝宝.jpg', '乐观天真的黄色海绵，最爱抓水母和做蟹黄堡。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (42, '派大星', '/actors/派大星.jpg', '海绵宝宝最好的朋友，呆萌却常常神助攻。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (43, '沈腾', '/actors/沈腾.jpg', '国民喜剧演员，自带笑点的“队宠”担当。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (44, '白敬亭', '/actors/白敬亭.jpg', '青年演员，活力满满的旅行搭子。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (45, '李晨', '/actors/李晨.jpg', '“大黑牛”，力量担当，撕名牌高手。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (46, 'Angelababy', '/actors/Angelababy.jpg', '活泼女神，奔跑团早期核心成员。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (47, '黄磊', '/actors/黄磊.jpg', '“神算子”老狐狸，智商担当。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (48, '黄渤', '/actors/黄渤.jpg', '国民影帝，极限男人帮核心。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (49, '何炅', '/actors/何炅.jpg', '“何老师”，快乐家族灵魂主持。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (50, '谢娜', '/actors/谢娜.jpg', '搞笑担当，气氛组组长。', '2026-11-11 12:07:29');
INSERT INTO `actor` VALUES (51, '彭昱畅', '/actors/彭昱畅.jpg', '活泼懂事的小师弟，干饭主力。', '2026-11-11 12:07:29');

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
-- Table structure for danmaku
-- ----------------------------
DROP TABLE IF EXISTS `danmaku`;
CREATE TABLE `danmaku`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `video_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '视频/剧集标识（前端 media.id，如 d7 / fp1 / 长月烬明）',
  `episode` int NOT NULL DEFAULT 1 COMMENT '集数',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '弹幕文本',
  `color` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '#ffffff' COMMENT '颜色（CSS 颜色）',
  `play_time` double NULL DEFAULT 0 COMMENT '出现时间点(秒)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_video_ep`(`video_id` ASC, `episode` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '弹幕表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of danmaku
-- ----------------------------

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
INSERT INTO `drama` VALUES (1, '白月梵星', '古装,奇幻,爱情', 2025, 9.2, 9800, '40集', '热播', '🌙', 'linear-gradient(135deg,#6a5bff,#b14dff)', '/covers/baiyuefanxing.jpg', '上神之女白烁与妖王梵樾从针锋相对到并肩作战，携手守护苍生的东方奇幻爱情。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (2, '逐玉', '古装,传奇,权谋', 2026, 8.9, 8700, '40集', '独家', '♟️', 'linear-gradient(135deg,#ff7a59,#ff3d77)', '/covers/zhuyu.jpg', '将门孤女逐玉执玉而归，在权谋倾轧中以智谋改写命运、守护家国的古装传奇。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (3, '卿卿日常', '古装,轻喜,爱情', 2022, 8.7, 8200, '40集', '热播', '🏮', 'linear-gradient(135deg,#1fd1f9,#2a6cff)', '/covers/qingqingrichang.jpg', '少女李薇与六少主尹峥先婚后爱，新川大家庭鸡飞狗跳又温情满满的轻喜日常。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (4, '星汉灿烂', '古装,爱情,成长', 2022, 9.0, 9100, '56集', '独家', '⭐', 'linear-gradient(135deg,#43e97b,#38f9d7)', '/covers/xinghancanlan.jpg', '留守少女程少商在缺爱中倔强成长，与少年将军凌不疑双向救赎、共赴家国。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (5, '长歌行', '古装,传奇,家国', 2021, 8.5, 7600, '49集', '热播', '🐎', 'linear-gradient(135deg,#ff6ec4,#7873f5)', '/covers/changgexing.jpg', '公主李长歌女扮男装流亡草原，在家国与恩仇之间坚守大义、终成传奇。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (6, '临江仙', '古装,仙侠,爱情', 2025, 9.1, 9500, '40集', '经典', '🌊', 'linear-gradient(135deg,#f6d365,#fda085)', '/covers/linjiangxian.webp', '凡人江辞与上仙临江仙两世纠缠，一场跨越身份与生死的仙凡虐恋。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (7, '许我耀眼', '都市,爱情,励志', 2025, 8.8, 8900, '32集', '热播', '✨', 'linear-gradient(135deg,#30cfd0,#330867)', '/covers/xuwoyaoyan.webp', '都市里两个不完美的年轻人相遇，彼此照亮、互相成就，许下耀眼的未来。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (8, '花千骨', '古装,仙侠,虐恋', 2015, 8.6, 7400, '50集', '经典', '🌸', 'linear-gradient(135deg,#ffb347,#ffcc33)', '/covers/huaqiangu.webp', '天煞孤星花千骨拜入长留仙山，与尊上白子画一段虐彻心扉的师徒之恋。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (9, '长月烬明', '古装,仙侠,奇幻', 2023, 9.3, 9900, '40集', '热播', '🌘', 'linear-gradient(135deg,#0f2027,#2c5364)', '/covers/changyuejinming.jpg', '上古魔神澹台烬生而无欢，神女黎苏苏逆时救世，救赎与宿命交织的仙侠史诗。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (10, '子夜归', '古装,悬疑,权谋', 2026, 8.9, 8500, '40集', '独家', '🕯️', 'linear-gradient(135deg,#c79081,#dfa579)', '/covers/ziyegui.jpg', '子夜时分迷局重重，少年们在权谋与悬案中抽丝剥茧，寻回真相与本心。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (11, '老九门', '民国,悬疑,冒险', 2016, 8.4, 7100, '48集', '热播', '🔑', 'linear-gradient(135deg,#a8e063,#56ab2f)', '/covers/laojiumen.jpg', '民国长沙九门提督守秘镇邪，张大佛爷率众深入地下，揭开百年悬疑。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (12, '且试天下', '古装,武侠,权谋', 2022, 9.0, 9300, '40集', '热播', '⚔️', 'linear-gradient(135deg,#ee0979,#ff6a00)', '/covers/qieshitianxia.jpg', '黑丰息与白风夕江湖与庙堂双线博弈，棋逢对手、强强联手共定天下。', NULL, '2026-10-28 08:50:30');
INSERT INTO `drama` VALUES (13, '三生三世十里桃花', '古装,仙侠,爱情', 2017, 9.2, 9900, '58集', '经典', '🌸', 'linear-gradient(135deg,#ff9ed2,#ff5e9c)', '/covers/sanshengsanshi.jpg', '青丘白浅与九重天太子夜华历经三生三世的爱恨纠缠，最终打破宿命相守。', '[{\"name\":\"杨幂\",\"role\":\"白浅 / 素素 / 司音\",\"emoji\":\"🦊\",\"bio\":\"青丘女君，四海八荒第一绝色，与夜华历经三生三世终成眷属。\"},{\"name\":\"赵又廷\",\"role\":\"夜华 / 墨渊\",\"emoji\":\"🐉\",\"bio\":\"九重天太子，深情隐忍，为白浅甘愿付出一切。\"},{\"name\":\"迪丽热巴\",\"role\":\"白凤九\",\"emoji\":\"🦊\",\"bio\":\"青丘九尾红狐，灵动俏皮，痴情守候东华帝君。\"},{\"name\":\"张智尧\",\"role\":\"折颜\",\"emoji\":\"🍑\",\"bio\":\"开天辟地第一只火凤凰，种十里桃林，善酿酒行医。\"},{\"name\":\"高伟光\",\"role\":\"东华帝君\",\"emoji\":\"👑\",\"bio\":\"上古神祇，曾经的天地共主，气势威严心系六界。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (14, '香蜜沉沉烬如霜', '古装,仙侠,爱情', 2018, 9.0, 9700, '63集', '经典', '🔥', 'linear-gradient(135deg,#ff7a59,#ff3d77)', '/covers/xiangmi.jpg', '花神之女锦觅吞下陨丹断情绝爱，与天帝之子旭凤三世轮回的恩怨痴缠。', '[{\"name\":\"杨紫\",\"role\":\"锦觅\",\"emoji\":\"🍑\",\"bio\":\"花神之女，天真烂漫，吞陨丹断情绝爱，最终为爱苏醒。\"},{\"name\":\"邓伦\",\"role\":\"旭凤\",\"emoji\":\"🔥\",\"bio\":\"天帝之子火神，深情专一，为锦觅甘堕魔道。\"},{\"name\":\"罗云熙\",\"role\":\"润玉\",\"emoji\":\"🌙\",\"bio\":\"天帝长子夜神，温润如玉却因爱生恨走入歧途。\"},{\"name\":\"陈钰琪\",\"role\":\"鎏英\",\"emoji\":\"⚔️\",\"bio\":\"魔界公主，英姿飒爽，与奇鸢虐恋动人。\"}]', '2026-10-28 09:43:21');
INSERT INTO `drama` VALUES (15, '传闻中的陈芊芊', '古装,爱情,喜剧', 2020, 8.0, 9000, '24集', '经典', '🌹', 'linear-gradient(135deg,#ff6ec4,#ff9a3c)', '/covers/chenqianqian.jpg', '七流编剧陈小千穿进自己写的剧本，变成活不过三集的炮灰三公主，逆天改命。', '[{\"name\":\"赵露思\",\"role\":\"陈芊芊 / 陈小千\",\"emoji\":\"🌹\",\"bio\":\"误入自己剧本的三公主，古灵精怪，逆天改命。\"},{\"name\":\"丁禹兮\",\"role\":\"韩烁\",\"emoji\":\"🐯\",\"bio\":\"玄虎城少城主，腹黑深情，与芊芊先婚后爱。\"},{\"name\":\"盛英豪\",\"role\":\"裴恒\",\"emoji\":\"🌿\",\"bio\":\"花垣城司学，温润如玉、深情隐忍。\"},{\"name\":\"周紫馨\",\"role\":\"陈楚楚\",\"emoji\":\"🍃\",\"bio\":\"花垣城二公主，端庄善良却因嫉妒迷失。\"}]', '2026-10-28 09:43:21');
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
  `cover` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面图片路径',
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
INSERT INTO `kids` VALUES (1, '熊出没', '动画,少儿,喜剧', 2012, 9.0, 9900, '200+集', '经典', '🐻', 'linear-gradient(135deg,#43e97b,#38f9d7)', '/covers/xiongchumo.png', '森林里熊大、熊二与光头强之间妙趣横生的护林故事，寓教于乐，陪伴无数孩子成长。', '[{\"name\":\"熊大\",\"role\":\"主角（熊）\",\"emoji\":\"🐻\",\"bio\":\"聪明勇敢的狗熊哥哥，带领弟弟熊二保护森林。\"},{\"name\":\"熊二\",\"role\":\"主角（熊）\",\"emoji\":\"🐻\",\"bio\":\"憨厚贪吃的狗熊弟弟，常与熊大一起对付光头强。\"},{\"name\":\"光头强\",\"role\":\"伐木工\",\"emoji\":\"🪓\",\"bio\":\"想砍树赚钱的伐木工，常与两头熊斗智斗勇。\"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (2, '喜羊羊与灰太狼', '动画,少儿,喜剧', 2005, 8.8, 9800, '530集', '经典', '🐑', 'linear-gradient(135deg,#fddb92,#d1fdff)', '/covers/xiyangyang.jpg', '青青草原上，喜羊羊等小羊与灰太狼之间永不停歇的欢乐较量，国产动画国民IP。', '[{\"name\":\"喜羊羊\",\"role\":\"主角（羊）\",\"emoji\":\"🐑\",\"bio\":\"聪明机智的羊村小英雄，总能想出办法化解危机。\"},{\"name\":\"灰太狼\",\"role\":\"反派（狼）\",\"emoji\":\"🐺\",\"bio\":\"执着抓羊的狼，口头禅“我一定会回来的！”，其实很爱家人。\"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (3, '巴啦啦小魔仙', '动画,少儿,奇幻', 2008, 8.5, 9500, '52集', '经典', '✨', 'linear-gradient(135deg,#c471f5,#fa71cd)', '/covers/balala.jpg', '平凡女孩美琪、美雪结识魔仙小蓝，开启守护正义的魔法冒险，少女魔法启蒙经典。', '[{\"name\":\"小蓝\",\"role\":\"魔仙\",\"emoji\":\"🔮\",\"bio\":\"来自魔仙堡的魔仙，负责引导两位人类女孩学习魔法。\"},{\"name\":\"美琪 / 美雪\",\"role\":\"主角（人类）\",\"emoji\":\"✨\",\"bio\":\"一对姐妹，意外获得魔法能量，成为实习小魔仙。\"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (4, '小猪佩奇', '动画,少儿,启蒙', 2004, 8.6, 9000, '300+集', '经典', '🐷', 'linear-gradient(135deg,#ffb6c1,#ffdde1)', '/covers/xiaozhupeiji.jpg', '粉色小猪佩奇一家温馨有趣的日常，跳泥坑、过生日，陪伴全球小朋友快乐成长。', '[{\"name\":\"佩奇\",\"role\":\"主角（小猪）\",\"emoji\":\"🐷\",\"bio\":\"活泼爱跳泥坑的小猪女孩，有个弟弟乔治。\"},{\"name\":\"乔治\",\"role\":\"弟弟（小猪）\",\"emoji\":\"🐤\",\"bio\":\"佩奇的弟弟，最爱抱着恐龙玩具。\"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (5, '超级飞侠', '动画,少儿,冒险', 2015, 8.4, 8800, '200+集', '热播', '✈️', 'linear-gradient(135deg,#4facfe,#00f2fe)', '/covers/chaojifeixia.webp', '会变形的飞机乐迪环游世界送包裹，和伙伴们帮助各地小朋友解决难题，开阔眼界。', '[{\"name\":\"乐迪\",\"role\":\"主角（飞机）\",\"emoji\":\"✈️\",\"bio\":\"最快的飞机快递员，每次都能把包裹准时送达。\"},{\"name\":\"小爱\",\"role\":\"救援直升机\",\"emoji\":\"🚁\",\"bio\":\"热心助人的救援直升机，关键时刻伸援手。\"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (6, '猪猪侠', '动画,少儿,冒险', 2005, 8.3, 8700, '500+集', '经典', '🐭', 'linear-gradient(135deg,#f7971e,#ffd200)', '/covers/zhuzhuxia.jpg', '小猪猪猪侠化身超级英雄，凭借勇气与智慧守护童话世界的正义，寓教于乐。', '[{\"name\":\"猪猪侠\",\"role\":\"主角（猪）\",\"emoji\":\"🐭\",\"bio\":\"贪吃贪玩却充满正义感的小猪，关键时刻总能挺身而出。\"},{\"name\":\"菲菲\",\"role\":\"伙伴（猪）\",\"emoji\":\"🌸\",\"bio\":\"聪明伶俐的小猪女孩，猪猪侠的好搭档。\"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (7, '海绵宝宝', '动画,少儿,喜剧', 1999, 9.1, 9600, '260+集', '经典', '🧽', 'linear-gradient(135deg,#fceabb,#f8b500)', '/covers/haimianbaobao.jpg', '海底比奇堡里，海绵宝宝和派大星一连串无厘头又温暖的爆笑日常，老少皆宜。', '[{\"name\":\"海绵宝宝\",\"role\":\"主角（海绵）\",\"emoji\":\"🧽\",\"bio\":\"乐观天真的黄色海绵，最爱抓水母和做蟹黄堡。\"},{\"name\":\"派大星\",\"role\":\"好友（海星）\",\"emoji\":\"⭐\",\"bio\":\"海绵宝宝最好的朋友，呆萌却常常神助攻。\"}]', '2026-11-02 10:00:00');

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
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户登录记录表（用于统计登录人数/次数）' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `login_record` VALUES (26, 'xx', '2026-11-06 15:36:43', '2026-11-06 15:36:43');
INSERT INTO `login_record` VALUES (27, 'xx', '2026-11-06 16:10:22', '2026-11-06 16:10:22');
INSERT INTO `login_record` VALUES (28, 'xx', '2026-11-09 20:15:18', '2026-11-09 20:15:18');
INSERT INTO `login_record` VALUES (29, 'xx', '2026-11-09 20:41:14', '2026-11-09 20:41:14');
INSERT INTO `login_record` VALUES (30, 'xx', '2026-11-09 20:46:06', '2026-11-09 20:46:06');
INSERT INTO `login_record` VALUES (31, 'xx', '2026-11-09 20:55:26', '2026-11-09 20:55:26');
INSERT INTO `login_record` VALUES (32, 'xx', '2026-11-09 20:58:21', '2026-11-09 20:58:21');
INSERT INTO `login_record` VALUES (33, 'xx', '2026-11-09 21:21:06', '2026-11-09 21:21:06');
INSERT INTO `login_record` VALUES (34, 'xx', '2026-11-10 11:11:41', '2026-11-10 11:11:41');
INSERT INTO `login_record` VALUES (35, 'xx', '2026-11-10 11:29:07', '2026-11-10 11:29:07');
INSERT INTO `login_record` VALUES (36, 'xx', '2026-11-10 11:32:06', '2026-11-10 11:32:06');
INSERT INTO `login_record` VALUES (37, 'xx', '2026-11-10 11:33:00', '2026-11-10 11:33:00');
INSERT INTO `login_record` VALUES (38, 'xx', '2026-11-10 11:39:59', '2026-11-10 11:39:59');
INSERT INTO `login_record` VALUES (39, 'xx', '2026-11-10 11:39:59', '2026-11-10 11:39:59');
INSERT INTO `login_record` VALUES (40, 'xx', '2026-11-10 11:43:38', '2026-11-10 11:43:38');
INSERT INTO `login_record` VALUES (41, 'xx', '2026-11-11 11:31:55', '2026-11-11 11:31:55');
INSERT INTO `login_record` VALUES (42, 'xx', '2026-11-11 11:31:55', '2026-11-11 11:31:55');
INSERT INTO `login_record` VALUES (43, 'xx', '2026-11-11 11:42:39', '2026-11-11 11:42:39');
INSERT INTO `login_record` VALUES (44, 'xx', '2026-11-11 11:42:39', '2026-11-11 11:42:39');
INSERT INTO `login_record` VALUES (45, 'xx', '2026-11-11 11:50:38', '2026-11-11 11:50:38');
INSERT INTO `login_record` VALUES (46, 'xx', '2026-11-11 11:57:18', '2026-11-11 11:57:18');
INSERT INTO `login_record` VALUES (47, 'xx', '2026-11-11 12:25:56', '2026-11-11 12:25:56');
INSERT INTO `login_record` VALUES (48, 'xx', '2026-11-11 12:28:47', '2026-11-11 12:28:47');
INSERT INTO `login_record` VALUES (49, 'xx', '2026-11-11 12:34:06', '2026-11-11 12:34:06');
INSERT INTO `login_record` VALUES (50, 'xx', '2026-11-11 12:35:53', '2026-11-11 12:35:53');
INSERT INTO `login_record` VALUES (51, 'xx', '2026-11-11 12:58:43', '2026-11-11 12:58:43');
INSERT INTO `login_record` VALUES (52, 'xx', '2026-11-11 13:00:26', '2026-11-11 13:00:26');
INSERT INTO `login_record` VALUES (53, 'xx', '2026-11-11 13:05:54', '2026-11-11 13:05:54');
INSERT INTO `login_record` VALUES (54, 'xx', '2026-11-11 19:00:45', '2026-11-11 19:00:45');
INSERT INTO `login_record` VALUES (55, 'xx', '2026-11-11 19:00:45', '2026-11-11 19:00:45');
INSERT INTO `login_record` VALUES (56, 'xx', '2026-11-11 19:08:33', '2026-11-11 19:08:33');
INSERT INTO `login_record` VALUES (57, 'xx', '2026-11-11 19:24:53', '2026-11-11 19:24:53');
INSERT INTO `login_record` VALUES (58, 'xx', '2026-11-11 19:37:04', '2026-11-11 19:37:04');
INSERT INTO `login_record` VALUES (59, 'xx', '2026-11-11 19:38:50', '2026-11-11 19:38:50');
INSERT INTO `login_record` VALUES (60, 'xiyangyang', '2026-11-11 19:39:44', '2026-11-11 19:39:44');
INSERT INTO `login_record` VALUES (61, 'xiyangyang', '2026-11-11 19:40:08', '2026-11-11 19:40:08');
INSERT INTO `login_record` VALUES (62, 'xiyangyang', '2026-11-11 19:40:39', '2026-11-11 19:40:39');
INSERT INTO `login_record` VALUES (63, 'xx', '2026-11-11 19:42:56', '2026-11-11 19:42:56');
INSERT INTO `login_record` VALUES (64, 'xx', '2026-11-11 20:09:59', '2026-11-11 20:09:59');
INSERT INTO `login_record` VALUES (65, 'xiyangyang', '2026-11-11 20:10:58', '2026-11-11 20:10:58');
INSERT INTO `login_record` VALUES (66, 'xiyangyang', '2026-11-11 20:11:40', '2026-11-11 20:11:40');
INSERT INTO `login_record` VALUES (67, 'xiyangyang', '2026-11-11 20:12:29', '2026-11-11 20:12:29');
INSERT INTO `login_record` VALUES (68, 'xx', '2026-11-11 20:26:44', '2026-11-11 20:26:44');
INSERT INTO `login_record` VALUES (69, 'xx', '2026-11-11 20:31:42', '2026-11-11 20:31:42');
INSERT INTO `login_record` VALUES (70, 'xx', '2026-11-11 20:33:26', '2026-11-11 20:33:26');

-- ----------------------------
-- Table structure for media_segment
-- ----------------------------
DROP TABLE IF EXISTS `media_segment`;
CREATE TABLE `media_segment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `media_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属媒体类型：drama(电视剧)/kids(少儿)/variety(综艺)',
  `media_id` bigint NOT NULL COMMENT '对应 drama/kids/variety 表的 id',
  `actor_id` bigint NOT NULL COMMENT '对应 actor 表的 id',
  `role` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '在该作品中的角色',
  `segment_start` double NULL DEFAULT NULL COMMENT '出场开始时间（秒）',
  `segment_end` double NULL DEFAULT NULL COMMENT '出场结束时间（秒，可空）',
  `episode` int NULL DEFAULT NULL COMMENT '出场集数（可空）',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_media`(`media_type` ASC, `media_id` ASC) USING BTREE,
  INDEX `idx_actor`(`actor_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '演员出场片段表（用于点击头像跳转到其出场位置）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of media_segment
-- ----------------------------
INSERT INTO `media_segment` VALUES (1, 'drama', 13, 1, '白浅 / 素素 / 司音', 10, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (2, 'drama', 13, 2, '夜华 / 墨渊', 25, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (3, 'drama', 13, 3, '白凤九', 40, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (4, 'drama', 13, 4, '折颜', 55, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (5, 'drama', 13, 5, '东华帝君', 70, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (6, 'drama', 14, 6, '锦觅', 10, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (7, 'drama', 14, 7, '旭凤', 25, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (8, 'drama', 14, 8, '润玉', 40, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (9, 'drama', 14, 9, '鎏英', 55, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (10, 'drama', 15, 10, '陈芊芊 / 陈小千', 10, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (11, 'drama', 15, 11, '韩烁', 25, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (12, 'drama', 15, 12, '裴恒', 40, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (13, 'drama', 15, 13, '陈楚楚', 55, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (14, 'drama', 16, 14, '张果果', 10, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (15, 'drama', 16, 7, '李云恺', 25, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (16, 'drama', 16, 15, '张雨欣', 40, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (17, 'drama', 16, 16, '李云哲', 55, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (18, 'drama', 17, 17, '任新正', 10, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (19, 'drama', 17, 10, '孙头头', 25, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (20, 'drama', 17, 18, '任天真', 40, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (21, 'drama', 17, 19, '杨小红', 55, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (22, 'drama', 17, 20, '宋灵兰', 70, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (23, 'drama', 18, 6, '颜淡', 10, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (24, 'drama', 18, 21, '应渊 / 唐周', 25, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (25, 'drama', 18, 22, '余墨', 40, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (26, 'drama', 18, 23, '芷昔', 55, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (27, 'drama', 19, 24, '魏娆 / 君黛', 10, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (28, 'drama', 19, 25, '陆濯', 25, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (29, 'drama', 19, 26, '戚仲恺', 40, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (30, 'drama', 19, 27, '碧桃', 55, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (31, 'kids', 1, 28, '主角（熊）', 8, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (32, 'kids', 1, 29, '主角（熊）', 20, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (33, 'kids', 1, 30, '伐木工', 32, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (34, 'kids', 2, 31, '主角（羊）', 8, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (35, 'kids', 2, 32, '反派（狼）', 20, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (36, 'kids', 3, 33, '魔仙', 8, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (37, 'kids', 3, 34, '主角（人类）', 20, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (38, 'kids', 4, 35, '主角（小猪）', 8, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (39, 'kids', 4, 36, '弟弟（小猪）', 20, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (40, 'kids', 5, 37, '主角（飞机）', 8, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (41, 'kids', 5, 38, '救援直升机', 20, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (42, 'kids', 6, 39, '主角（猪）', 8, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (43, 'kids', 6, 40, '伙伴（猪）', 20, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (44, 'kids', 7, 41, '主角（海绵）', 8, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (45, 'kids', 7, 42, '好友（海星）', 20, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (46, 'variety', 1, 43, '常驻嘉宾', 10, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (47, 'variety', 1, 44, '常驻嘉宾', 25, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (48, 'variety', 2, 45, '常驻嘉宾', 10, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (49, 'variety', 2, 46, '常驻嘉宾', 25, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (50, 'variety', 3, 47, '常驻嘉宾', 10, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (51, 'variety', 3, 48, '常驻嘉宾', 25, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (52, 'variety', 4, 49, '主持人', 10, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (53, 'variety', 4, 50, '主持人', 25, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (54, 'variety', 5, 47, '常驻嘉宾', 10, NULL, NULL, NULL, '2026-11-11 12:07:29');
INSERT INTO `media_segment` VALUES (55, 'variety', 5, 51, '常驻嘉宾', 25, NULL, NULL, NULL, '2026-11-11 12:07:29');

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
  `cover` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面图片路径',
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
INSERT INTO `variety` VALUES (1, '现在就出发', '综艺,真人秀,户外', 2023, 8.7, 9200, '第1-2季', '热播', '🎤', 'linear-gradient(135deg,#fa709a,#fee140)', '/covers/xianzaichufa.jpg', '沈腾领衔的轻松户外真人秀，一群好友说走就走，在路上制造爆笑与温情。', '[{\"name\":\"沈腾\",\"role\":\"常驻嘉宾\",\"emoji\":\"😆\",\"bio\":\"国民喜剧演员，自带笑点的“队宠”担当。\"},{\"name\":\"白敬亭\",\"role\":\"常驻嘉宾\",\"emoji\":\"🧢\",\"bio\":\"青年演员，活力满满的旅行搭子。\"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (2, '奔跑吧', '综艺,真人秀,竞技', 2014, 8.5, 9700, '第1-11季', '热播', '🏃', 'linear-gradient(135deg,#f857a6,#ff5858)', '/covers/benpaoba.jpg', '国民级户外竞技真人秀，明星分队完成趣味任务，撕名牌名场面频出。', '[{\"name\":\"李晨\",\"role\":\"常驻嘉宾\",\"emoji\":\"💪\",\"bio\":\"“大黑牛”，力量担当，撕名牌高手。\"},{\"name\":\"Angelababy\",\"role\":\"常驻嘉宾\",\"emoji\":\"🌟\",\"bio\":\"活泼女神，奔跑团早期核心成员。\"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (3, '极限挑战', '综艺,真人秀,剧情', 2015, 9.0, 9600, '第1-10季', '经典', '🎯', 'linear-gradient(135deg,#0f2027,#2c5364)', '/covers/jixian.jpg', '男人帮在充满反转的剧情任务中斗智斗勇，“这就是命”成经典梗，烧脑又爆笑。', '[{\"name\":\"黄磊\",\"role\":\"常驻嘉宾\",\"emoji\":\"🍳\",\"bio\":\"“神算子”老狐狸，智商担当。\"},{\"name\":\"黄渤\",\"role\":\"常驻嘉宾\",\"emoji\":\"🎬\",\"bio\":\"国民影帝，极限男人帮核心。\"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (4, '快乐大本营', '综艺,访谈,娱乐', 1997, 8.8, 9400, '已完结', '经典', '🎉', 'linear-gradient(135deg,#ff9a9e,#fecfef)', '/covers/kuaile.jpg', '陪伴几代人的国民综艺，游戏、访谈、歌舞，周五晚上的快乐源泉。', '[{\"name\":\"何炅\",\"role\":\"主持人\",\"emoji\":\"🎙️\",\"bio\":\"“何老师”，快乐家族灵魂主持。\"},{\"name\":\"谢娜\",\"role\":\"主持人\",\"emoji\":\"🌈\",\"bio\":\"搞笑担当，气氛组组长。\"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (5, '向往的生活', '综艺,慢综艺,生活', 2017, 8.6, 9100, '第1-6季', '治愈', '🏡', 'linear-gradient(135deg,#a8e063,#56ab2f)', '/covers/xiangwang.webp', '蘑菇屋里的慢生活，种菜、做饭、招待客人，用烟火气温暖治愈都市人的疲惫。', '[{\"name\":\"黄磊\",\"role\":\"常驻嘉宾\",\"emoji\":\"🍳\",\"bio\":\"蘑菇屋“黄小厨”，美食担当。\"},{\"name\":\"彭昱畅\",\"role\":\"常驻嘉宾\",\"emoji\":\"😋\",\"bio\":\"活泼懂事的小师弟，干饭主力。\"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (6, '歌手', '综艺,音乐,竞演', 2013, 8.9, 9300, '多季', '经典', '🎙️', 'linear-gradient(135deg,#6a11cb,#2575fc)', '/covers/geshou.jpg', '顶尖歌手同台竞演的Live音乐综艺，用实力唱腔定义华语乐坛现场水准。', '[{\"name\":\"待补充\",\"role\":\"—\",\"emoji\":\"🎵\",\"bio\":\"每季嘉宾阵容不同，请按真实情况补充。\"}]', '2026-11-02 10:00:00');

SET FOREIGN_KEY_CHECKS = 1;
