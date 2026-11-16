/*
 Navicat Premium Dump SQL（新增：首页短视频）

 说明：
   1. 本文件在已有 xiyangyang 库的基础上，新增 `video`（首页短视频）表。
   2. 首页功能栏点「视频」进入竖屏信息流：上下滑动切换、播放完自动滑到下一条。
   3. 视频文件在 xiyangyang-login-vue/public/videos/video1~5.mp4，
      同时拷贝到 springBootTest/src/main/resources/static/videos/，表里存相对地址 /videos/xxx.mp4。
   4. 导入顺序：先导入 xiyangyang.sql（建库 + drama/user 等），再导入本文件即可。
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
-- Table structure for video（首页短视频）
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '视频标题',
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '作者',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '简介',
  `video_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '视频地址，如 /videos/video1.mp4',
  `likes` int NOT NULL DEFAULT 0 COMMENT '点赞数',
  `comments` int NOT NULL DEFAULT 0 COMMENT '评论数',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '首页短视频表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of video（5 条短视频，与前端 public/videos/video1~5.mp4 对应）
-- ----------------------------
INSERT INTO `video` VALUES (1, '精彩视频 · 第 1 期', '熊猫影视', '上下滑动观看更多精彩视频～', '/videos/video1.mp4', 12000, 328, '2026-11-16 10:00:00');
INSERT INTO `video` VALUES (2, '精彩视频 · 第 2 期', '熊猫影视', '好内容根本停不下来！', '/videos/video2.mp4', 8765, 211, '2026-11-16 10:00:00');
INSERT INTO `video` VALUES (3, '精彩视频 · 第 3 期', '熊猫影视', '每一帧都不想快进。', '/videos/video3.mp4', 23000, 540, '2026-11-16 10:00:00');
INSERT INTO `video` VALUES (4, '精彩视频 · 第 4 期', '熊猫影视', '看到最后有惊喜！', '/videos/video4.mp4', 6543, 187, '2026-11-16 10:00:00');
INSERT INTO `video` VALUES (5, '精彩视频 · 第 5 期', '熊猫影视', '喜欢就点个赞再走～', '/videos/video5.mp4', 15000, 402, '2026-11-16 10:00:00');

SET FOREIGN_KEY_CHECKS = 1;
