-- ============================================================
-- 喜羊羊登录注册项目 - 数据库初始化脚本
-- 数据库: xiyangyang    用户表: user
-- MySQL 8.x
-- ============================================================

-- 如果数据库已存在则先删除（演示用，生产环境慎用）
-- DROP DATABASE IF EXISTS xiyangyang;

-- 创建数据库（utf8mb4 支持完整的 Unicode，包括 emoji）
CREATE DATABASE IF NOT EXISTS xiyangyang
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_general_ci;

USE xiyangyang;

-- 用户表
CREATE TABLE IF NOT EXISTS `user` (
    `id`       BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
    `username` VARCHAR(50)  NOT NULL                COMMENT '用户名',
    `password` VARCHAR(64)  NOT NULL                COMMENT '密码（1-18位）',
    `create_time` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`)
) ENGINE = InnoDB COMMENT = '用户表';

-- 测试数据（用户名: xiyangyang，密码: 123456）
INSERT INTO `user` (`username`, `password`)
SELECT 'xiyangyang', '123456'
WHERE NOT EXISTS (
    SELECT 1 FROM `user` WHERE `username` = 'xiyangyang'
);

-- 验证
SELECT * FROM `user`;
