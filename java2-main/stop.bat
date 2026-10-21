@echo off
rem ============================================================
rem  喜羊羊登录注册项目 - 一键停止脚本
rem  停止前端(5173)和后端(8081)，双击运行即可
rem ============================================================
echo 正在停止前端 (端口5173)...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":5173" ^| findstr "LISTENING"') do taskkill /f /pid %%a >nul 2>&1

echo 正在停止后端 (端口8081)...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8081" ^| findstr "LISTENING"') do taskkill /f /pid %%a >nul 2>&1

rem 顺便关掉启动脚本打开的黑窗口
taskkill /f /fi "WINDOWTITLE eq 前端-vue*" >nul 2>&1
taskkill /f /fi "WINDOWTITLE eq 前端-自动装依赖并启动*" >nul 2>&1
taskkill /f /fi "WINDOWTITLE eq 后端-springboot*" >nul 2>&1

echo 已全部停止！
pause
