-- 弹幕表：存储每条弹幕，供前端多人共享、跨设备/刷新不丢
CREATE DATABASE IF NOT EXISTS xiyangyang;
USE xiyangyang;

CREATE TABLE IF NOT EXISTS danmaku (
  id         BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  video_id   VARCHAR(64)  NOT NULL DEFAULT ''    COMMENT '视频/剧集标识（前端 media.id，如 d7 / fp1 / 长月烬明）',
  episode    INT          NOT NULL DEFAULT 1     COMMENT '集数',
  content    VARCHAR(200) NOT NULL DEFAULT ''    COMMENT '弹幕文本',
  color      VARCHAR(16)  NOT NULL DEFAULT '#ffffff' COMMENT '颜色（CSS 颜色）',
  play_time  DOUBLE       DEFAULT 0             COMMENT '出现时间点(秒)',
  create_time DATETIME    DEFAULT NULL          COMMENT '发送时间',
  PRIMARY KEY (id),
  KEY idx_video_ep (video_id, episode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='弹幕表';
