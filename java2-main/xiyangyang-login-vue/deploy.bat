@echo off
chcp 65001 >nul
setlocal

:: ============ 配置路径（按需修改） ============
set "VUE=C:\Users\36651\IdeaProjects\java2\java2-main\xiyangyang-login-vue"
set "STATIC=C:\Users\36651\IdeaProjects\java2\java2-main\springBootTest\src\main\resources\static"
set "CLASSES=C:\Users\36651\IdeaProjects\java2\java2-main\springBootTest\target\classes\static"

echo ============================================
echo  前端一键部署：构建 Vue 并同步到 Spring Boot
echo ============================================

:: 1) 构建前端
echo [1/3] npm run build ...
cd /d "%VUE%" || (echo 找不到前端目录 & pause & exit /b 1)
call npm run build
if errorlevel 1 (echo 构建失败，已中止 & pause & exit /b 1)

:: 2) 同步到 src/main/resources/static（打包/部署源）
echo [2/3] 复制 dist -> src/main/resources/static ...
xcopy /E /Y /I "%VUE%\dist\*" "%STATIC%"

:: 3) 同步到 target/classes/static（让正在运行的 IDE 实例立即生效，省去 restart）
echo [3/3] 复制 dist -> target/classes/static ...
if exist "%CLASSES%\" (
  xcopy /E /Y /I "%VUE%\dist\*" "%CLASSES%"
) else (
  echo   (target/classes/static 不存在，跳过；下次用 IDE 启动 Spring Boot 时会自动生成)
)

echo.
echo 完成！短视频等静态资源已更新。
echo 如果页面仍不显示，请在 IDE 中重启 Spring Boot 应用。
echo.
pause
