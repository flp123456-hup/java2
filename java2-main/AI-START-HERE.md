# AI-START-HERE —— 未来的我，先读这个，别重复踩坑

> 本文件是给 AI 助手（WorkBuddy）看的操作手册。用户要求每次开机电脑重置后
> （node_modules 和 target 会被删除），按此文件快速恢复项目，减少不必要的探索。

## 项目概况
- 仓库根目录即本文件所在目录（本地无 .git 历史时重新 init + 关联远程）
- `xiyangyang-login-vue/` — Vue3 + Vite 前端（登录+注册，canvas 验证码，密码 1-18 位）
- `springBootTest/` — Spring Boot 3.4.5 后端（MyBatis-Plus 3.5.7 + MySQL，包名 com.fenglin.springboottest）
- 数据库：MySQL 8.0，库名 `xiyangyang`，表 `user`，账号 root / 123456
- 端口约定：**前端 5173，后端 8081，MySQL 3306**
- 接口：POST /api/user/register、POST /api/user/login（前端走 vite 代理 /api → 8081）

## 最快启动方式（优先）
用户双击 `start.bat`（GBK 编码，相对路径）即可；停止用 `stop.bat`。
脚本会：检查 MySQL → 自动 npm install（若 node_modules 被删）→ 开两个窗口跑前后端。

## AI 自己启动（在 WorkBuddy 终端里）的命令
```bash
# 后端（工作目录 springBootTest/，首次会自动编译，无需 target）
mvnw.cmd spring-boot:run -DskipTests -Dspring-boot.run.arguments=--server.port=8081
# 前端（工作目录 xiyangyang-login-vue/，node_modules 被删则先 npm install）
node node_modules/vite/bin/vite.js   # 或 npm run dev
```
系统 node 路径：`D:\Program Files\nodejs\npm.cmd`（PATH 里有，直接用 npm 即可）。
Maven：优先用项目里的 `mvnw.cmd`；~/.m2/wrapper/dists 里有 3.9.9 可直接用，
~/.m2/settings.xml 已配阿里云镜像。

## 必须记住的坑
1. **SERVER__PORT 环境变量**：WorkBuddy 沙箱里有 `SERVER__PORT=52909`，
   会覆盖 Spring Boot 的 server.port 配置导致端口冲突。
   → AI 在终端启动后端时**必须**带 `-Dspring-boot.run.arguments=--server.port=8081`。
   （用户自己双击 start.bat 不受影响，但脚本里已带该参数，保持即可。）
2. **node_modules / target 每次开机被删**：启动前检查，缺了先装（前端 .npmrc 已配
   国内镜像 npmmirror）。Maven 依赖在 ~/.m2，不会被删，编译很快。
3. **数据库若也被重置**：执行 `springBootTest/sql/init.sql`
   （`"C:/Program Files/MySQL/MySQL Server 8.0/bin/mysql.exe" -uroot -p123456 < init.sql`）。
4. **git 推送**：远程 `https://github.com/flp123456-hup/java2.git`。
   沙箱内需 `git config http.proxy http://127.0.0.1:52968`（端口看 env HTTP_PROXY）、
   `http.sslVerify=false`（代理是拦截式的），且需要用户提供 PAT。
   提交人配置已在仓库本地设置（flp123456-hup）。
5. **MySQL 服务**：若 3306 没监听，提醒用户启动 MySQL80 服务（services.msc）。

## 验证项目是否正常（30 秒）
```bash
curl -s -X POST http://localhost:8081/api/user/login \
  -H "Content-Type: application/json" \
  -d '{"username":"xiyangyang","password":"123456"}'
# 期望: {"msg":"登录成功","code":200,...}
```

## 历史遗留
- git push 到 GitHub 尚未完成（等用户提供 Personal Access Token），本地已有提交。
