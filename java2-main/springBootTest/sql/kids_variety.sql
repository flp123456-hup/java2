/*
 Navicat Premium Dump SQL（新增：少儿 / 综艺）

 说明：
   1. 本文件在已有 xiyangyang 库的基础上，新增 `kids`（少儿动画）和 `variety`（综艺）两张表。
   2. 字段结构刻意与已有 `drama`（电视剧）表保持一致，方便后续统一查询 / 统计。
   3. 导入顺序：先导入 xiyangyang.sql（建库 + drama/user 等），再导入本文件即可。
      若单独运行本文件，开头会自动 CREATE DATABASE IF NOT EXISTS 并 USE。

 Source Server Type    : MySQL
 Source Server Version : 80039 (8.0.39)
 File Encoding         : 65001
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 若数据库尚未创建则自动创建（与 application-dev.properties 中的库名保持一致）
CREATE DATABASE IF NOT EXISTS `xiyangyang` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `xiyangyang`;

-- ----------------------------
-- Table structure for kids（少儿动画）
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
INSERT INTO `kids` VALUES (1, '熊出没', '动画,少儿,喜剧', 2012, 9.0, 9900, '200+集', '经典', '🐻', 'linear-gradient(135deg,#43e97b,#38f9d7)', '森林里熊大、熊二与光头强之间妙趣横生的护林故事，寓教于乐，陪伴无数孩子成长。', '[{"name":"熊大","role":"主角（熊）","emoji":"🐻","bio":"聪明勇敢的狗熊哥哥，带领弟弟熊二保护森林。"},{"name":"熊二","role":"主角（熊）","emoji":"🐻","bio":"憨厚贪吃的狗熊弟弟，常与熊大一起对付光头强。"},{"name":"光头强","role":"伐木工","emoji":"🪓","bio":"想砍树赚钱的伐木工，常与两头熊斗智斗勇。"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (2, '喜羊羊与灰太狼', '动画,少儿,喜剧', 2005, 8.8, 9800, '530集', '经典', '🐑', 'linear-gradient(135deg,#fddb92,#d1fdff)', '青青草原上，喜羊羊等小羊与灰太狼之间永不停歇的欢乐较量，国产动画国民IP。', '[{"name":"喜羊羊","role":"主角（羊）","emoji":"🐑","bio":"聪明机智的羊村小英雄，总能想出办法化解危机。"},{"name":"灰太狼","role":"反派（狼）","emoji":"🐺","bio":"执着抓羊的狼，口头禅“我一定会回来的！”，其实很爱家人。"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (3, '巴啦啦小魔仙', '动画,少儿,奇幻', 2008, 8.5, 9500, '52集', '经典', '✨', 'linear-gradient(135deg,#c471f5,#fa71cd)', '平凡女孩美琪、美雪结识魔仙小蓝，开启守护正义的魔法冒险，少女魔法启蒙经典。', '[{"name":"小蓝","role":"魔仙","emoji":"🔮","bio":"来自魔仙堡的魔仙，负责引导两位人类女孩学习魔法。"},{"name":"美琪 / 美雪","role":"主角（人类）","emoji":"✨","bio":"一对姐妹，意外获得魔法能量，成为实习小魔仙。"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (4, '小猪佩奇', '动画,少儿,启蒙', 2004, 8.6, 9000, '300+集', '经典', '🐷', 'linear-gradient(135deg,#ffb6c1,#ffdde1)', '粉色小猪佩奇一家温馨有趣的日常，跳泥坑、过生日，陪伴全球小朋友快乐成长。', '[{"name":"佩奇","role":"主角（小猪）","emoji":"🐷","bio":"活泼爱跳泥坑的小猪女孩，有个弟弟乔治。"},{"name":"乔治","role":"弟弟（小猪）","emoji":"🐤","bio":"佩奇的弟弟，最爱抱着恐龙玩具。"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (5, '超级飞侠', '动画,少儿,冒险', 2015, 8.4, 8800, '200+集', '热播', '✈️', 'linear-gradient(135deg,#4facfe,#00f2fe)', '会变形的飞机乐迪环游世界送包裹，和伙伴们帮助各地小朋友解决难题，开阔眼界。', '[{"name":"乐迪","role":"主角（飞机）","emoji":"✈️","bio":"最快的飞机快递员，每次都能把包裹准时送达。"},{"name":"小爱","role":"救援直升机","emoji":"🚁","bio":"热心助人的救援直升机，关键时刻伸援手。"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (6, '猪猪侠', '动画,少儿,冒险', 2005, 8.3, 8700, '500+集', '经典', '🐭', 'linear-gradient(135deg,#f7971e,#ffd200)', '小猪猪猪侠化身超级英雄，凭借勇气与智慧守护童话世界的正义，寓教于乐。', '[{"name":"猪猪侠","role":"主角（猪）","emoji":"🐭","bio":"贪吃贪玩却充满正义感的小猪，关键时刻总能挺身而出。"},{"name":"菲菲","role":"伙伴（猪）","emoji":"🌸","bio":"聪明伶俐的小猪女孩，猪猪侠的好搭档。"}]', '2026-11-02 10:00:00');
INSERT INTO `kids` VALUES (7, '海绵宝宝', '动画,少儿,喜剧', 1999, 9.1, 9600, '260+集', '经典', '🧽', 'linear-gradient(135deg,#fceabb,#f8b500)', '海底比奇堡里，海绵宝宝和派大星一连串无厘头又温暖的爆笑日常，老少皆宜。', '[{"name":"海绵宝宝","role":"主角（海绵）","emoji":"🧽","bio":"乐观天真的黄色海绵，最爱抓水母和做蟹黄堡。"},{"name":"派大星","role":"好友（海星）","emoji":"⭐","bio":"海绵宝宝最好的朋友，呆萌却常常神助攻。"}]', '2026-11-02 10:00:00');

-- ----------------------------
-- Table structure for variety（综艺）
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
INSERT INTO `variety` VALUES (1, '现在就出发', '综艺,真人秀,户外', 2023, 8.7, 9200, '第1-2季', '热播', '🎤', 'linear-gradient(135deg,#fa709a,#fee140)', '沈腾领衔的轻松户外真人秀，一群好友说走就走，在路上制造爆笑与温情。', '[{"name":"沈腾","role":"常驻嘉宾","emoji":"😆","bio":"国民喜剧演员，自带笑点的“队宠”担当。"},{"name":"白敬亭","role":"常驻嘉宾","emoji":"🧢","bio":"青年演员，活力满满的旅行搭子。"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (2, '奔跑吧', '综艺,真人秀,竞技', 2014, 8.5, 9700, '第1-11季', '热播', '🏃', 'linear-gradient(135deg,#f857a6,#ff5858)', '国民级户外竞技真人秀，明星分队完成趣味任务，撕名牌名场面频出。', '[{"name":"李晨","role":"常驻嘉宾","emoji":"💪","bio":"“大黑牛”，力量担当，撕名牌高手。"},{"name":"Angelababy","role":"常驻嘉宾","emoji":"🌟","bio":"活泼女神，奔跑团早期核心成员。"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (3, '极限挑战', '综艺,真人秀,剧情', 2015, 9.0, 9600, '第1-10季', '经典', '🎯', 'linear-gradient(135deg,#0f2027,#2c5364)', '男人帮在充满反转的剧情任务中斗智斗勇，“这就是命”成经典梗，烧脑又爆笑。', '[{"name":"黄磊","role":"常驻嘉宾","emoji":"🍳","bio":"“神算子”老狐狸，智商担当。"},{"name":"黄渤","role":"常驻嘉宾","emoji":"🎬","bio":"国民影帝，极限男人帮核心。"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (4, '快乐大本营', '综艺,访谈,娱乐', 1997, 8.8, 9400, '已完结', '经典', '🎉', 'linear-gradient(135deg,#ff9a9e,#fecfef)', '陪伴几代人的国民综艺，游戏、访谈、歌舞，周五晚上的快乐源泉。', '[{"name":"何炅","role":"主持人","emoji":"🎙️","bio":"“何老师”，快乐家族灵魂主持。"},{"name":"谢娜","role":"主持人","emoji":"🌈","bio":"搞笑担当，气氛组组长。"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (5, '向往的生活', '综艺,慢综艺,生活', 2017, 8.6, 9100, '第1-6季', '治愈', '🏡', 'linear-gradient(135deg,#a8e063,#56ab2f)', '蘑菇屋里的慢生活，种菜、做饭、招待客人，用烟火气温暖治愈都市人的疲惫。', '[{"name":"黄磊","role":"常驻嘉宾","emoji":"🍳","bio":"蘑菇屋“黄小厨”，美食担当。"},{"name":"彭昱畅","role":"常驻嘉宾","emoji":"😋","bio":"活泼懂事的小师弟，干饭主力。"}]', '2026-11-02 10:00:00');
INSERT INTO `variety` VALUES (6, '歌手', '综艺,音乐,竞演', 2013, 8.9, 9300, '多季', '经典', '🎙️', 'linear-gradient(135deg,#6a11cb,#2575fc)', '顶尖歌手同台竞演的Live音乐综艺，用实力唱腔定义华语乐坛现场水准。', '[{"name":"待补充","role":"—","emoji":"🎵","bio":"每季嘉宾阵容不同，请按真实情况补充。"}]', '2026-11-02 10:00:00');

SET FOREIGN_KEY_CHECKS = 1;
