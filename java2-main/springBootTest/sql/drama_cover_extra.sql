-- ============================================================
-- 为 12 部剧设置真实封面
-- 封面图片文件位于：
--   前端  xiyangyang-login-vue/src/assets/covers/  （Vite 打包）
--   前端  xiyangyang-login-vue/public/covers/      （原样访问）
--   后端  springBootTest/src/main/resources/static/covers/
-- ============================================================
USE xiyangyang;

-- 若 drama 表还没有 cover 字段，先加上（已有则忽略报错）
-- ALTER TABLE drama ADD COLUMN cover VARCHAR(200) NULL DEFAULT NULL COMMENT '封面图片路径' AFTER gradient;

UPDATE drama SET cover='/covers/qieshitianxia.jpg'    WHERE title='且试天下';
UPDATE drama SET cover='/covers/linjiangxian.webp'   WHERE title='临江仙';
UPDATE drama SET cover='/covers/xuwoyaoyan.webp'     WHERE title='许我耀眼';
UPDATE drama SET cover='/covers/huaqiangu.webp'      WHERE title='花千骨';
UPDATE drama SET cover='/covers/baiyuefanxing.jpg'   WHERE title='白月梵星';
UPDATE drama SET cover='/covers/changgexing.jpg'     WHERE title='长歌行';
UPDATE drama SET cover='/covers/qingqingrichang.jpg' WHERE title='卿卿日常';
UPDATE drama SET cover='/covers/chenqianqian.jpg'    WHERE title='传闻中的陈芊芊';
UPDATE drama SET cover='/covers/xinghancanlan.jpg'   WHERE title='星汉灿烂';
UPDATE drama SET cover='/covers/changyuejinming.jpg' WHERE title='长月烬明';
UPDATE drama SET cover='/covers/laojiumen.jpg'       WHERE title='老九门';
UPDATE drama SET cover='/covers/zhuyu.jpg'           WHERE title='逐玉';

-- 核对结果
SELECT id, title, cover FROM drama ORDER BY id;
