@echo off
rem ============================================================
rem  喜羊羊登录注册项目 - 一键启动脚本 (加固版 v4)
rem ============================================================
rem  防闪退机制: 本脚本会用 cmd /k 重新拉起自己到一个常驻窗口，
rem  所以无论中途是否报错，主窗口都不会一闪而过，错误会停在屏幕上。

rem ---- 防闪退: 若还不是常驻模式，则重新拉起一个 cmd /k 窗口 ----
if defined _IN_CMD goto :run
set "_IN_CMD=1"
start "" cmd /k ""%~f0""
exit /b

:run
setlocal

rem ---- 项目根目录(默认=脚本自身所在目录) ----
set "PROJECT_ROOT=%~dp0"
if "%PROJECT_ROOT:~-1%"=="\" set "PROJECT_ROOT=%PROJECT_ROOT:~0,-1%"
set "LOG=%PROJECT_ROOT%\start.log"

echo [%date% %time%] ========== 启动脚本开始 ========== > "%LOG%"
echo 项目根目录: %PROJECT_ROOT% >> "%LOG%"
echo 日志文件:   %LOG% >> "%LOG%"

cd /d "%PROJECT_ROOT%" 2>>"%LOG%" || (
  echo [致命错误] 无法切换到项目目录: %PROJECT_ROOT%
  echo [致命错误] 无法切换到项目目录 >> "%LOG%"
  echo 请确认 start.bat 没有被单独移到别处。
  pause
  exit /b 1
)

echo ============================================
echo   喜羊羊登录注册项目 - 一键启动 (v4)
echo ============================================
echo   项目根目录: %PROJECT_ROOT%
echo   运行日志:   %LOG%
echo.

rem ---- 0. 运行环境 ----
echo [0/4] 检查运行环境 (node / npm / java)...
echo [0/4] 检查运行环境 >> "%LOG%"
set "MISSING="
where node >nul 2>&1 || set "MISSING=%MISSING% node"
where npm  >nul 2>&1 || set "MISSING=%MISSING% npm"
where java >nul 2>&1 || set "MISSING=%MISSING% java"
if defined MISSING (
  echo [错误] 缺少以下运行环境:%MISSING%
  echo [错误] 缺少运行环境:%MISSING% >> "%LOG%"
  echo   请先安装 Node.js 和 JDK，并把它们加入系统 PATH。
  echo   Node: https://nodejs.org    JDK: https://adoptium.net
  pause
  exit /b 1
)
for /f "delims=" %%i in ('node -v') do echo   node: %%i
for /f "delims=" %%i in ('npm -v')  do echo   npm : %%i
for /f "delims=" %%i in ('java -version 2^>^&1') do echo   %%i
echo   [OK] 运行环境齐全 >> "%LOG%"

rem ---- 1. MySQL ----
echo.
echo [1/4] 检查 MySQL 数据库 (端口 3306)...
echo [1/4] 检查 MySQL >> "%LOG%"
netstat -ano 2>nul | findstr ":3306" | findstr "LISTENING" >nul 2>&1
if errorlevel 1 (
  echo   [警告] 没有检测到 MySQL 在 3306 端口运行！
  echo   [警告] 未检测到 MySQL >> "%LOG%"
  echo   后端启动后会连不上数据库而报错。请先启动 MySQL：
  echo   按 Win+R 输入 services.msc，找到 MySQL 服务点"启动"。
  echo.
  choice /c YN /m "仍然继续启动(后端可能失败)？按 Y 继续 / N 退出"
  if errorlevel 2 (
    echo 已取消。请启动 MySQL 后重新运行本脚本。
    pause
    exit /b 1
  )
) else (
  echo   [OK] MySQL 正在运行 >> "%LOG%"
)

rem ---- 2. 前端 ----
echo.
echo [2/4] 启动前端 Vue (端口 5173)...
echo [调试] 准备启动前端 >> "%LOG%"
set "FRONT_DIR=%PROJECT_ROOT%\xiyangyang-login-vue"
if not exist "%FRONT_DIR%" (
  echo [错误] 找不到前端目录: %FRONT_DIR%
  echo [错误] 找不到前端目录 >> "%LOG%"
  pause
  exit /b 1
)
if not exist "%FRONT_DIR%\node_modules" (
  echo   node_modules 不存在，将自动安装依赖(npm install)...
  echo   前端首次安装中 >> "%LOG%"
  start "前端-自动装依赖并启动" /d "%FRONT_DIR%" cmd /k "npm install && npm run dev"
) else (
  start "前端-vue" /d "%FRONT_DIR%" cmd /k "npm run dev"
)
echo   [OK] 前端窗口已打开 >> "%LOG%"

rem ---- 3. 后端 ----
echo.
echo [3/4] 启动后端 Spring Boot (端口 8081)...
echo [调试] 准备启动后端 >> "%LOG%"
set "BACK_DIR=%PROJECT_ROOT%\springBootTest"
if not exist "%BACK_DIR%" (
  echo [错误] 找不到后端目录: %BACK_DIR%
  echo [错误] 找不到后端目录 >> "%LOG%"
  pause
  exit /b 1
)
if not exist "%BACK_DIR%\mvnw.cmd" (
  echo [错误] 找不到: %BACK_DIR%\mvnw.cmd
  echo [错误] 找不到 mvnw.cmd >> "%LOG%"
  pause
  exit /b 1
)
start "后端-springboot" /d "%BACK_DIR%" cmd /k "call mvnw.cmd spring-boot:run -DskipTests -Dspring-boot.run.arguments=--server.port=8081"
echo   [OK] 后端窗口已打开 >> "%LOG%"

rem ---- 4. 完成 ----
echo.
echo [4/4] 启动命令已全部发出！
echo [调试] 脚本执行完毕 >> "%LOG%"
echo.
echo   使用说明:
echo    1. 后端窗口出现 "Started SpringBootTestApplication" 即成功(首次约1-3分钟)
echo    2. 前端窗口出现 "Local: http://localhost:5173/" 即成功
echo    3. 浏览器访问 http://localhost:5173
echo    4. 测试账号: xiyangyang / 123456
echo    5. 关闭项目: 双击 stop.bat
echo.
echo   注意: 前后端是两个独立黑窗口，运行期间不要关它们。
echo         如果某个窗口一闪而过/自动关闭，说明该服务启动失败，
echo         请看该窗口里的红色报错，或打开日志查看: %LOG%
echo.
echo   本窗口由 cmd /k 常驻，任务做完也不会自动关闭；
echo   看完说明后可直接点右上角 X 关闭，不影响已启动的服务。
echo.
echo   按任意键关闭本窗口(服务继续在另外两个窗口运行)。
echo.
pause
