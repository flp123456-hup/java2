-- ============================================================
-- 为 6 档综艺设置真实封面
-- 封面图片文件位于：
--   前端  xiyangyang-login-vue/src/assets/covers/  （Vite 打包）
--   前端  xiyangyang-login-vue/public/covers/      （原样访问）
--   后端  springBootTest/src/main/resources/static/covers/
-- ============================================================
USE xiyangyang;

-- variety 表原本没有 cover 字段，先加上（重复执行会报 1060 错误，忽略即可）
ALTER TABLE variety ADD COLUMN cover VARCHAR(200) NULL DEFAULT NULL COMMENT '封面图片路径' AFTER gradient;

UPDATE variety SET cover='/covers/xianzaichufa.jpg' WHERE title='现在就出发';
UPDATE variety SET cover='/covers/benpaoba.jpg'     WHERE title='奔跑吧';
UPDATE variety SET cover='/covers/jixian.jpg'       WHERE title='极限挑战';
UPDATE variety SET cover='/covers/kuaile.jpg'       WHERE title='快乐大本营';
UPDATE variety SET cover='/covers/xiangwang.webp'   WHERE title='向往的生活';
UPDATE variety SET cover='/covers/geshou.jpg'       WHERE title='歌手';

-- 核对结果
SELECT id, title, cover FROM variety ORDER BY id;
