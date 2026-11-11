/*
  actor + media_segment 建库建表脚本

  说明：
    1. 在已有 xiyangyang 库基础上，新增 actor（演员/嘉宾）表 与
       media_segment（演员在某部作品中的出场片段/时间点）表。
    2. 数据从原 drama/kids/variety 的 cast 字段抽取：演员姓名、角色、
       简介、出场秒数，全部写入新表，便于“点击演员头像跳到她演的部分”。
  导入顺序：先导入 xiyangyang.sql（建库 + 三张媒体表），再导入本文件。
  若单独运行本文件，开头会自动 CREATE DATABASE IF NOT EXISTS 并 USE。

  Source Server Type : MySQL
  Source Server Version : 80039 (8.0.39)
  File Encoding : 65001
*/
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 若数据库尚未创建则自动创建（与 application-dev.properties 的库名保持一致）
CREATE DATABASE IF NOT EXISTS `xiyangyang` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `xiyangyang`;

-- ----------------------------
-- Table structure for actor（演员/嘉宾）
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '演员/嘉宾表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of actor
-- ----------------------------
INSERT IGNORE INTO `actor` (`name`, `avatar`, `bio`) VALUES
  ('杨幂', '/actors/杨幂.jpg', '青丘女君，与夜华历经三生三世终成眷属。'),
  ('赵又廷', '/actors/赵又廷.jpg', '九重天太子，深情隐忍，为白浅甘愿付出一切。'),
  ('迪丽热巴', '/actors/迪丽热巴.jpg', '青丘九尾红狐，灵动俏皮，痴情守候东华帝君。'),
  ('张智尧', '/actors/张智尧.jpg', '开天辟地第一只火凤凰，种十里桃林，善酿酒行医。'),
  ('高伟光', '/actors/高伟光.jpg', '上古神祇，曾经的天地共主，气势威严心系六界。'),
  ('杨紫', '/actors/杨紫.jpg', '花神之女，天真烂漫，吞陨丹断情绝爱，最终为爱苏醒。'),
  ('邓伦', '/actors/邓伦.jpg', '天帝之子火神，深情专一，为锦觅甘堕魔道。'),
  ('罗云熙', '/actors/罗云熙.jpg', '天帝长子夜神，温润如玉却因爱生恨走入歧途。'),
  ('陈钰琪', '/actors/陈钰琪.jpg', '魔界公主，英姿飒爽，与奇鸢虐恋动人。'),
  ('赵露思', '/actors/赵露思.jpg', '误入自己剧本的三公主，古灵精怪，逆天改命。'),
  ('丁禹兮', '/actors/丁禹兮.jpg', '玄虎城少城主，腹黑深情，与芊芊先婚后爱。'),
  ('盛英豪', '/actors/盛英豪.jpg', '花垣城司学，温润如玉、深情隐忍。'),
  ('周紫馨', '/actors/周紫馨.jpg', '花垣城二公主，端庄善良却因嫉妒迷失。'),
  ('孙怡', '/actors/孙怡.jpg', '同里馄饨店女孩，身负苏绣天赋的千金，励志逆袭。'),
  ('吴优', '/actors/吴优.jpg', '果果的姐妹，留学归来的心机对手。'),
  ('代超', '/actors/代超.jpg', '时创集团二把手，理性冷淡、心思缜密。'),
  ('吴刚', '/actors/吴刚.jpg', '中医药大学教授，辞职创办中医传承班广传中医。'),
  ('罗一舟', '/actors/罗一舟.jpg', '任新正之子，成长于中医世家，严谨有血性。'),
  ('张萌', '/actors/张萌.jpg', '精英律师，意外后走进传承班重寻人生。'),
  ('江珊', '/actors/江珊.jpg', '名医，任新正事业的最佳同路人。'),
  ('成毅', '/actors/成毅.jpg', '守护结界的六界帝君，正直果敢的战神。'),
  ('张睿', '/actors/张睿.jpg', '妖王之子，颜淡挚友，一路相伴同行。'),
  ('孟子义', '/actors/孟子义.jpg', '颜淡双生姐姐，四叶菡萏化形。'),
  ('田曦薇', '/actors/田曦薇.jpg', '承安伯府真千金，市井中坚韧成长，智斗冒牌千金。'),
  ('闫桉', '/actors/闫桉.jpg', '战伤世子，被魏娆真情打动渐生情愫。'),
  ('刘小北', '/actors/刘小北.jpg', '陆家相关角色，剧情张力十足。'),
  ('潘珺雅', '/actors/潘珺雅.jpg', '魏娆侍女，忠心耿耿暗护主。'),
  ('熊大', '/actors/熊大.jpg', '聪明勇敢的狗熊哥哥，带领弟弟熊二保护森林。'),
  ('熊二', '/actors/熊二.jpg', '憨厚贪吃的狗熊弟弟，常与熊大一起对付光头强。'),
  ('光头强', '/actors/光头强.jpg', '想砍树赚钱的伐木工，常与两头熊斗智斗勇。'),
  ('喜羊羊', '/actors/喜羊羊.jpg', '聪明机智的羊村小英雄，总能想出办法化解危机。'),
  ('灰太狼', '/actors/灰太狼.jpg', '执着抓羊的狼，口头禅“我一定会回来的！”，其实很爱家人。'),
  ('小蓝', '/actors/小蓝.jpg', '来自魔仙堡的魔仙，负责引导两位人类女孩学习魔法。'),
  ('美琪 / 美雪', '/actors/美琪 / 美雪.jpg', '一对姐妹，意外获得魔法能量，成为实习小魔仙。'),
  ('佩奇', '/actors/佩奇.jpg', '活泼爱跳泥坑的小猪女孩，有个弟弟乔治。'),
  ('乔治', '/actors/乔治.jpg', '佩奇的弟弟，最爱抱着恐龙玩具。'),
  ('乐迪', '/actors/乐迪.jpg', '最快的飞机快递员，每次都能把包裹准时送达。'),
  ('小爱', '/actors/小爱.jpg', '热心助人的救援直升机，关键时刻伸援手。'),
  ('猪猪侠', '/actors/猪猪侠.jpg', '贪吃贪玩却充满正义感的小猪，关键时刻总能挺身而出。'),
  ('菲菲', '/actors/菲菲.jpg', '聪明伶俐的小猪女孩，猪猪侠的好搭档。'),
  ('海绵宝宝', '/actors/海绵宝宝.jpg', '乐观天真的黄色海绵，最爱抓水母和做蟹黄堡。'),
  ('派大星', '/actors/派大星.jpg', '海绵宝宝最好的朋友，呆萌却常常神助攻。'),
  ('沈腾', '/actors/沈腾.jpg', '国民喜剧演员，自带笑点的“队宠”担当。'),
  ('白敬亭', '/actors/白敬亭.jpg', '青年演员，活力满满的旅行搭子。'),
  ('李晨', '/actors/李晨.jpg', '“大黑牛”，力量担当，撕名牌高手。'),
  ('Angelababy', '/actors/Angelababy.jpg', '活泼女神，奔跑团早期核心成员。'),
  ('黄磊', '/actors/黄磊.jpg', '“神算子”老狐狸，智商担当。'),
  ('黄渤', '/actors/黄渤.jpg', '国民影帝，极限男人帮核心。'),
  ('何炅', '/actors/何炅.jpg', '“何老师”，快乐家族灵魂主持。'),
  ('谢娜', '/actors/谢娜.jpg', '搞笑担当，气氛组组长。'),
  ('彭昱畅', '/actors/彭昱畅.jpg', '活泼懂事的小师弟，干饭主力。');

-- ----------------------------
-- Table structure for media_segment（演员出场片段）
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '演员出场片段表（用于点击头像跳转到其出场位置）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of media_segment（通过剧名/演员名关联，避免依赖自增 id）
-- ----------------------------
INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '白浅 / 素素 / 司音', 10
FROM `drama` t, `actor` a
WHERE t.title = '三生三世十里桃花' AND a.name = '杨幂';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '夜华 / 墨渊', 25
FROM `drama` t, `actor` a
WHERE t.title = '三生三世十里桃花' AND a.name = '赵又廷';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '白凤九', 40
FROM `drama` t, `actor` a
WHERE t.title = '三生三世十里桃花' AND a.name = '迪丽热巴';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '折颜', 55
FROM `drama` t, `actor` a
WHERE t.title = '三生三世十里桃花' AND a.name = '张智尧';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '东华帝君', 70
FROM `drama` t, `actor` a
WHERE t.title = '三生三世十里桃花' AND a.name = '高伟光';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '锦觅', 10
FROM `drama` t, `actor` a
WHERE t.title = '香蜜沉沉烬如霜' AND a.name = '杨紫';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '旭凤', 25
FROM `drama` t, `actor` a
WHERE t.title = '香蜜沉沉烬如霜' AND a.name = '邓伦';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '润玉', 40
FROM `drama` t, `actor` a
WHERE t.title = '香蜜沉沉烬如霜' AND a.name = '罗云熙';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '鎏英', 55
FROM `drama` t, `actor` a
WHERE t.title = '香蜜沉沉烬如霜' AND a.name = '陈钰琪';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '陈芊芊 / 陈小千', 10
FROM `drama` t, `actor` a
WHERE t.title = '传闻中的陈芊芊' AND a.name = '赵露思';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '韩烁', 25
FROM `drama` t, `actor` a
WHERE t.title = '传闻中的陈芊芊' AND a.name = '丁禹兮';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '裴恒', 40
FROM `drama` t, `actor` a
WHERE t.title = '传闻中的陈芊芊' AND a.name = '盛英豪';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '陈楚楚', 55
FROM `drama` t, `actor` a
WHERE t.title = '传闻中的陈芊芊' AND a.name = '周紫馨';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '张果果', 10
FROM `drama` t, `actor` a
WHERE t.title = '因为遇见你' AND a.name = '孙怡';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '李云恺', 25
FROM `drama` t, `actor` a
WHERE t.title = '因为遇见你' AND a.name = '邓伦';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '张雨欣', 40
FROM `drama` t, `actor` a
WHERE t.title = '因为遇见你' AND a.name = '吴优';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '李云哲', 55
FROM `drama` t, `actor` a
WHERE t.title = '因为遇见你' AND a.name = '代超';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '任新正', 10
FROM `drama` t, `actor` a
WHERE t.title = '后浪' AND a.name = '吴刚';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '孙头头', 25
FROM `drama` t, `actor` a
WHERE t.title = '后浪' AND a.name = '赵露思';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '任天真', 40
FROM `drama` t, `actor` a
WHERE t.title = '后浪' AND a.name = '罗一舟';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '杨小红', 55
FROM `drama` t, `actor` a
WHERE t.title = '后浪' AND a.name = '张萌';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '宋灵兰', 70
FROM `drama` t, `actor` a
WHERE t.title = '后浪' AND a.name = '江珊';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '颜淡', 10
FROM `drama` t, `actor` a
WHERE t.title = '沉香如屑·沉香重华' AND a.name = '杨紫';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '应渊 / 唐周', 25
FROM `drama` t, `actor` a
WHERE t.title = '沉香如屑·沉香重华' AND a.name = '成毅';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '余墨', 40
FROM `drama` t, `actor` a
WHERE t.title = '沉香如屑·沉香重华' AND a.name = '张睿';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '芷昔', 55
FROM `drama` t, `actor` a
WHERE t.title = '沉香如屑·沉香重华' AND a.name = '孟子义';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '魏娆 / 君黛', 10
FROM `drama` t, `actor` a
WHERE t.title = '嫁金钗' AND a.name = '田曦薇';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '陆濯', 25
FROM `drama` t, `actor` a
WHERE t.title = '嫁金钗' AND a.name = '闫桉';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '戚仲恺', 40
FROM `drama` t, `actor` a
WHERE t.title = '嫁金钗' AND a.name = '刘小北';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'drama', t.id, a.id, '碧桃', 55
FROM `drama` t, `actor` a
WHERE t.title = '嫁金钗' AND a.name = '潘珺雅';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '主角（熊）', 8
FROM `kids` t, `actor` a
WHERE t.title = '熊出没' AND a.name = '熊大';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '主角（熊）', 20
FROM `kids` t, `actor` a
WHERE t.title = '熊出没' AND a.name = '熊二';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '伐木工', 32
FROM `kids` t, `actor` a
WHERE t.title = '熊出没' AND a.name = '光头强';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '主角（羊）', 8
FROM `kids` t, `actor` a
WHERE t.title = '喜羊羊与灰太狼' AND a.name = '喜羊羊';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '反派（狼）', 20
FROM `kids` t, `actor` a
WHERE t.title = '喜羊羊与灰太狼' AND a.name = '灰太狼';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '魔仙', 8
FROM `kids` t, `actor` a
WHERE t.title = '巴啦啦小魔仙' AND a.name = '小蓝';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '主角（人类）', 20
FROM `kids` t, `actor` a
WHERE t.title = '巴啦啦小魔仙' AND a.name = '美琪 / 美雪';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '主角（小猪）', 8
FROM `kids` t, `actor` a
WHERE t.title = '小猪佩奇' AND a.name = '佩奇';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '弟弟（小猪）', 20
FROM `kids` t, `actor` a
WHERE t.title = '小猪佩奇' AND a.name = '乔治';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '主角（飞机）', 8
FROM `kids` t, `actor` a
WHERE t.title = '超级飞侠' AND a.name = '乐迪';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '救援直升机', 20
FROM `kids` t, `actor` a
WHERE t.title = '超级飞侠' AND a.name = '小爱';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '主角（猪）', 8
FROM `kids` t, `actor` a
WHERE t.title = '猪猪侠' AND a.name = '猪猪侠';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '伙伴（猪）', 20
FROM `kids` t, `actor` a
WHERE t.title = '猪猪侠' AND a.name = '菲菲';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '主角（海绵）', 8
FROM `kids` t, `actor` a
WHERE t.title = '海绵宝宝' AND a.name = '海绵宝宝';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'kids', t.id, a.id, '好友（海星）', 20
FROM `kids` t, `actor` a
WHERE t.title = '海绵宝宝' AND a.name = '派大星';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'variety', t.id, a.id, '常驻嘉宾', 10
FROM `variety` t, `actor` a
WHERE t.title = '现在就出发' AND a.name = '沈腾';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'variety', t.id, a.id, '常驻嘉宾', 25
FROM `variety` t, `actor` a
WHERE t.title = '现在就出发' AND a.name = '白敬亭';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'variety', t.id, a.id, '常驻嘉宾', 10
FROM `variety` t, `actor` a
WHERE t.title = '奔跑吧' AND a.name = '李晨';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'variety', t.id, a.id, '常驻嘉宾', 25
FROM `variety` t, `actor` a
WHERE t.title = '奔跑吧' AND a.name = 'Angelababy';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'variety', t.id, a.id, '常驻嘉宾', 10
FROM `variety` t, `actor` a
WHERE t.title = '极限挑战' AND a.name = '黄磊';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'variety', t.id, a.id, '常驻嘉宾', 25
FROM `variety` t, `actor` a
WHERE t.title = '极限挑战' AND a.name = '黄渤';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'variety', t.id, a.id, '主持人', 10
FROM `variety` t, `actor` a
WHERE t.title = '快乐大本营' AND a.name = '何炅';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'variety', t.id, a.id, '主持人', 25
FROM `variety` t, `actor` a
WHERE t.title = '快乐大本营' AND a.name = '谢娜';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'variety', t.id, a.id, '常驻嘉宾', 10
FROM `variety` t, `actor` a
WHERE t.title = '向往的生活' AND a.name = '黄磊';

INSERT INTO `media_segment` (`media_type`, `media_id`, `actor_id`, `role`, `segment_start`)
SELECT 'variety', t.id, a.id, '常驻嘉宾', 25
FROM `variety` t, `actor` a
WHERE t.title = '向往的生活' AND a.name = '彭昱畅';

SET FOREIGN_KEY_CHECKS = 1;