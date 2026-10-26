@echo off
rem ============================================================
rem  喜羊羊登录注册项目 - 一键启动脚本 (v5 修正版)
rem  流程:
rem   [0] 检查运行环境 (node / npm / java)
rem   [1] 定位 MySQL 客户端并检查 3306 服务
rem   [2] 导入 SQL (建库 + 建表 + 初始数据，已存在则跳过)
rem   [3] 前端 Vue: 自动 npm install + npm run dev (端口 5173)
rem   [4] 后端 Spring Boot: maven 下载依赖 + 打包 jar + 运行 jar (端口 8081)
rem ============================================================

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
echo   喜羊羊登录注册项目 - 一键启动 (v5)
echo ============================================
echo   项目根目录: %PROJECT_ROOT%
echo   运行日志:   %LOG%
echo.

rem ============ [0] 运行环境检查 ============
echo [0/5] 检查运行环境 (node / npm / java)...
set "MISSING="
where node >nul 2>&1 || set "MISSING=%MISSING% node"
where npm  >nul 2>&1 || set "MISSING=%MISSING% npm"
where java >nul 2>&1 || set "MISSING=%MISSING% java"
if defined MISSING (
  echo [错误] 缺少以下运行环境:%MISSING%
  echo [错误] 缺少运行环境:%MISSING% >> "%LOG%"
  echo   请先安装 Node.js 和 JDK 17+，本项目用 JDK 21 也可以，并加入系统 PATH。
  echo   Node: https://nodejs.org    JDK: https://adoptium.net
  pause
  exit /b 1
)
for /f "delims=" %%i in ('node -v') do echo   node: %%i
for /f "delims=" %%i in ('npm -v')  do echo   npm : %%i
for /f "delims=" %%i in ('java -version 2^>^&1') do echo   %%i
echo   [完成] 运行环境齐全 >> "%LOG%"

rem ============ [1] 定位 MySQL 客户端 + 检查服务 ============
echo.
echo [1/5] 定位 MySQL 客户端并检查服务 (端口 3306)...
set "MYSQL_EXE="
rem 1) 先在系统 PATH 里找
for %%p in (mysql.exe) do set "MYSQL_EXE=%%~$PATH:p"
rem 2) 常见安装目录兜底
if not defined MYSQL_EXE (
  for %%d in (
    "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
    "C:\Program Files\MySQL\MySQL Server 8.1\bin\mysql.exe"
    "C:\Program Files\MySQL\MySQL Server 8.2\bin\mysql.exe"
    "C:\Program Files\MySQL\MySQL Server 5.7\bin\mysql.exe"
    "C:\Program Files (x86)\MySQL\MySQL Server 8.0\bin\mysql.exe"
  ) do (
    if not defined MYSQL_EXE if exist %%d set "MYSQL_EXE=%%~d"
  )
)
if not defined MYSQL_EXE (
  echo [错误] 找不到 mysql.exe，请确认 MySQL 已安装并记下安装路径。
  echo [错误] 未找到 mysql.exe >> "%LOG%"
  pause
  exit /b 1
)
echo   mysql 客户端: %MYSQL_EXE%
echo   mysql 客户端: %MYSQL_EXE% >> "%LOG%"

rem 数据库配置(必须与 springBootTest\src\main\resources\application-dev.properties 保持一致)
set "DB_HOST=localhost"
set "DB_PORT=3306"
set "DB_NAME=xiyangyang"
set "DB_USER=root"
set "DB_PASS=123456"

rem 检查 MySQL 是否真的在监听 3306
netstat -ano 2>nul | findstr ":3306" | findstr "LISTENING" >nul 2>&1
if errorlevel 1 (
  echo   [警告] 未检测到 MySQL 在 3306 端口运行！
  echo   [警告] 未检测到 MySQL >> "%LOG%"
  echo   后端启动后会连不上数据库。请先启动 MySQL：
  echo   按 Win+R 输入 services.msc，找到 MySQL 服务点"启动"。
  echo.
  choice /c YN /m "仍然继续(后面导入SQL/后端可能失败)？按 Y 继续 / N 退出"
  if errorlevel 2 (
    echo 已取消。请启动 MySQL 后重新运行本脚本。
    pause
    exit /b 1
  )
) else (
  echo   [OK] MySQL 正在运行 >> "%LOG%"
)

rem ============ [2] 导入 SQL ============
echo.
echo [2/5] 导入数据库 SQL (库: %DB_NAME%, 账号: %DB_USER%)...
rem 2.1 确保数据库存在(若不存在则创建)
"%MYSQL_EXE%" -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% -e "CREATE DATABASE IF NOT EXISTS `%DB_NAME%` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;" >nul 2>>"%LOG%"
if errorlevel 1 (
  echo [错误] 无法连接 MySQL 或创建数据库，请检查:
  echo        1. MySQL 服务是否已启动，见上一步；
  echo        2. 账号密码是否正确，当前: %DB_USER% / %DB_PASS%
  echo [错误] 创建/连接数据库失败 >> "%LOG%"
  pause
  exit /b 1
)
rem 2.2 判断 user 表是否已存在，避免每次启动都重置数据
set "TMPF=%PROJECT_ROOT%\.mysql_tbl.tmp"
"%MYSQL_EXE%" -N -s -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% %DB_NAME% -e "SHOW TABLES LIKE 'user';" > "%TMPF%" 2>nul
findstr /i "user" "%TMPF%" >nul
if not errorlevel 1 (
  echo   [跳过] 表 user 已存在，不重复导入，避免覆盖已有数据。
  echo   [跳过] user 表已存在 >> "%LOG%"
) else (
  echo   正在导入: springBootTest\sql\xiyangyang.sql
  echo   导入 SQL 开始 >> "%LOG%"
  "%MYSQL_EXE%" -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% %DB_NAME% < "%PROJECT_ROOT%\springBootTest\sql\xiyangyang.sql" >>"%LOG%" 2>&1
  if errorlevel 1 (
    echo [错误] SQL 导入失败，请打开日志查看详情: %LOG%
    echo [错误] SQL 导入失败 >> "%LOG%"
    if exist "%TMPF%" del /f /q "%TMPF%" >nul 2>&1
    pause
    exit /b 1
  )
  echo   [OK] SQL 导入完成，已建 user 表并写入测试账号 xiyangyang/123456
  echo   [OK] SQL 导入完成 >> "%LOG%"
)
if exist "%TMPF%" del /f /q "%TMPF%" >nul 2>&1

rem ============ [3] 前端 ============
echo.
echo [3/5] 启动前端 Vue (端口 5173)...
set "FRONT_DIR=%PROJECT_ROOT%\xiyangyang-login-vue"
if not exist "%FRONT_DIR%" (
  echo [错误] 找不到前端目录: %FRONT_DIR%
  echo [错误] 找不到前端目录 >> "%LOG%"
  pause
  exit /b 1
)
if not exist "%FRONT_DIR%\node_modules" (
  echo   node_modules 不存在，先自动安装依赖再启动...
  echo   前端首次安装中 >> "%LOG%"
  start "前端-装依赖并启动" /d "%FRONT_DIR%" cmd /k "npm install && npm run dev"
) else (
  echo   node_modules 已存在，直接启动 dev...
  start "前端-vue" /d "%FRONT_DIR%" cmd /k "npm run dev"
)
echo   [OK] 前端窗口已打开 >> "%LOG%"

rem ============ [4] 后端 ============
echo.
echo [4/5] 构建并启动后端 Spring Boot (端口 8081)...
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
rem 窗口内: maven 下载依赖 + 打包可执行 jar + 运行 jar
rem (jar 名固定为 springBootTest-0.0.1-SNAPSHOT.jar，由 pom.xml 的 artifactId/version 决定)
start "后端-springboot" /d "%BACK_DIR%" cmd /k "call mvnw.cmd clean package -DskipTests && java -jar target/springBootTest-0.0.1-SNAPSHOT.jar --server.port=8081"
echo   [OK] 后端窗口已打开(首次会下载依赖+打包 jar，约 1-5 分钟) >> "%LOG%"

rem ============ [5] 完成 ============
echo.
echo [5/5] 全部启动命令已发出！
echo [调试] 脚本执行完毕 >> "%LOG%"
echo.
echo   使用说明:
echo    1. 后端窗口出现 "Started SpringBootTestApplication" 即成功(首次约1-5分钟)
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
