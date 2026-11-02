-- 给 drama 表新增封面图字段，并为 5 部剧设置真实封面
-- 封面图片文件位于前端 xiyangyang-login-vue/public/covers/
CREATE DATABASE IF NOT EXISTS xiyangyang;
USE xiyangyang;

ALTER TABLE drama ADD COLUMN cover VARCHAR(200) NULL DEFAULT NULL COMMENT '封面图片路径' AFTER gradient;

UPDATE drama SET cover='/covers/sanshengsanshi.jpg' WHERE title='三生三世十里桃花';
UPDATE drama SET cover='/covers/xiangmi.jpg'        WHERE title='香蜜沉沉烬如霜';
UPDATE drama SET cover='/covers/chenxiang.jpg'      WHERE title='沉香如屑·沉香重华';
UPDATE drama SET cover='/covers/yujian.jpg'         WHERE title='因为遇见你';
UPDATE drama SET cover='/covers/jiajinchai.jpg'     WHERE title='嫁金钗';
