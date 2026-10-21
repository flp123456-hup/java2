@echo off
rem ============================================================
rem  喜羊羊登录注册项目 - 一键启动脚本
rem  前端: Vue3 + Vite (端口 5173)
rem  后端: Spring Boot (端口 8081)
rem  用法: 双击本文件即可，会打开两个黑窗口分别跑前后端
rem  注意: 每次开机 node_modules 和 target 会被删除，
rem        本脚本会自动重装依赖，第一次可能要等几分钟
rem ============================================================
cd /d "%~dp0"

echo [1/4] 检查 MySQL 数据库 (端口3306)...
netstat -ano | findstr ":3306" | findstr "LISTENING" >nul 2>&1
if errorlevel 1 (
    echo   [警告] MySQL 没在运行！请先启动 MySQL80 服务再运行本脚本
    echo   启动方法: 按 Win+R 输入 services.msc 找到 MySQL80 点启动
    pause
    exit /b 1
)
echo   [OK] MySQL 正在运行

echo [2/4] 检查前端依赖 (node_modules)...
if not exist "xiyangyang-login-vue\node_modules" (
    echo   node_modules 不存在，将自动安装依赖(国内镜像，几分钟)...
    start "前端-自动装依赖并启动" cmd /k "cd xiyangyang-login-vue && npm install && npm run dev"
) else (
    start "前端-vue" cmd /k "cd xiyangyang-login-vue && npm run dev"
)
echo   [OK] 前端启动窗口已打开

echo [3/4] 启动后端 Spring Boot (端口8081，Maven 自动编译)...
start "后端-springboot" cmd /k "cd springBootTest && call mvnw.cmd spring-boot:run -DskipTests -Dspring-boot.run.arguments=--server.port=8081"
echo   [OK] 后端启动窗口已打开

echo [4/4] 完成！
echo.
echo  使用说明:
echo    1. 等后端窗口显示 "Started SpringBootTestApplication" (约30秒)
echo    2. 等前端窗口显示 "Local: http://localhost:5173/"
echo    3. 浏览器会自动打开，或手动访问 http://localhost:5173
echo    4. 测试账号: xiyangyang / 123456
echo    5. 停止项目: 双击 stop.bat
echo.
pause
