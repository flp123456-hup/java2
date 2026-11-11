-- ============================================================
-- 重置后台管理员密码（admin_user 表，密码明文存储，学习演示用）
-- 用途：忘记后台管理系统密码时，把 admin 账号密码改回可用值。
-- 用法：在 MySQL 客户端 / IDEA Database 工具里，先 use 到本项目库
--       （库名一般叫 xiyangyang），再执行下面这条 UPDATE。
-- ============================================================

-- 把 admin 账号的密码重置为 admin123（可直接登录）
UPDATE admin_user
SET password = 'admin123'
WHERE username = 'admin';

-- （可选）如果想换成自己的密码，把上面 'admin123' 改成你想要的内容即可，例如：
-- UPDATE admin_user SET password = 'myNewPass2026' WHERE username = 'admin';

-- 确认结果：
SELECT id, username, password, create_time FROM admin_user;
