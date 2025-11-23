@echo off
chcp 65001 >nul
echo ═══════════════════════════════════════════
echo   自动上传到GitHub - sj仓库
echo ═══════════════════════════════════════════
echo.

cd /d "%~dp0"

echo [步骤1] 检查Git配置...
git config --global user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo 首次使用Git需要配置用户信息
    echo.
    set /p USERNAME="请输入你的GitHub用户名: "
    set /p EMAIL="请输入你的GitHub邮箱: "
    
    git config --global user.name "!USERNAME!"
    git config --global user.email "!EMAIL!"
    echo ? Git配置完成
)

for /f "delims=" %%i in ('git config --global user.name') do set GIT_USER=%%i
echo ? 当前用户: %GIT_USER%
echo.

echo [步骤2] 初始化Git仓库...
if not exist ".git" (
    git init
    echo ? 仓库初始化完成
) else (
    echo ? 仓库已存在
)
echo.

echo [步骤3] 添加所有文件...
git add .
if %errorlevel% neq 0 (
    echo ? 添加文件失败
    pause
    exit /b 1
)
echo ? 文件已添加
echo.

echo [步骤4] 创建提交...
git commit -m "qingli应用完整代码 - Root权限清理工具"
if %errorlevel% neq 0 (
    echo 注意: 可能没有新的更改需要提交
)
echo ? 提交完成
echo.

echo [步骤5] 连接到远程仓库...
echo.
echo 请确认你的GitHub仓库地址:
echo 格式: https://github.com/你的用户名/sj.git
echo.
set /p REPO_URL="请输入完整的仓库地址: "

git remote remove origin 2>nul
git remote add origin %REPO_URL%
echo ? 远程仓库已配置
echo.

echo [步骤6] 推送到GitHub...
echo.
echo 注意: 
echo - 如果是首次推送,会要求输入GitHub密码
echo - 建议使用Personal Access Token而不是密码
echo - Token获取: Settings → Developer settings → Personal access tokens
echo.
pause
echo.

git branch -M main
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo ═══════════════════════════════════════════
    echo   推送失败！
    echo ═══════════════════════════════════════════
    echo.
    echo 可能的原因:
    echo 1. 仓库不存在 - 请先在GitHub创建"sj"仓库
    echo 2. 认证失败 - 检查用户名和密码/Token
    echo 3. 网络问题 - 检查网络连接
    echo.
    echo 如果仓库已存在内容,可以尝试:
    echo git pull origin main --allow-unrelated-histories
    echo git push -u origin main
    echo.
    pause
    exit /b 1
)

echo.
echo ═══════════════════════════════════════════
echo   ? 上传成功！
echo ═══════════════════════════════════════════
echo.
echo 代码已上传到: %REPO_URL%
echo.
echo GitHub Actions将自动开始构建APK
echo 查看构建状态: https://github.com/%GIT_USER%/sj/actions
echo.
echo 构建完成后（约5-10分钟）:
echo 1. 进入 Actions 页面
echo 2. 点击最新的构建
echo 3. 在 Artifacts 部分下载 app-debug
echo.
pause
