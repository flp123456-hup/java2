-- ============================================================
-- 为 7 部少儿动画设置真实封面
-- 封面图片文件位于：
--   前端  xiyangyang-login-vue/src/assets/covers/  （Vite 打包）
--   前端  xiyangyang-login-vue/public/covers/      （原样访问）
--   后端  springBootTest/src/main/resources/static/covers/
-- ============================================================
USE xiyangyang;

-- kids 表原本没有 cover 字段，先加上（MySQL 8 不支持 ADD COLUMN IF NOT EXISTS，
-- 重复执行会报 1060 错误，忽略即可）
ALTER TABLE kids ADD COLUMN cover VARCHAR(200) NULL DEFAULT NULL COMMENT '封面图片路径' AFTER gradient;

UPDATE kids SET cover='/covers/xiongchumo.png'     WHERE title='熊出没';
UPDATE kids SET cover='/covers/xiyangyang.jpg'     WHERE title='喜羊羊与灰太狼';
UPDATE kids SET cover='/covers/balala.jpg'        WHERE title='巴啦啦小魔仙';
UPDATE kids SET cover='/covers/xiaozhupeiji.jpg'  WHERE title='小猪佩奇';
UPDATE kids SET cover='/covers/chaojifeixia.webp' WHERE title='超级飞侠';
UPDATE kids SET cover='/covers/zhuzhuxia.jpg'     WHERE title='猪猪侠';
UPDATE kids SET cover='/covers/haimianbaobao.jpg' WHERE title='海绵宝宝';

-- 核对结果
SELECT id, title, cover FROM kids ORDER BY id;
