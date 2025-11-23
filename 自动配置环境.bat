@echo off
chcp 65001 >nul
echo ============================================
echo   Android开发环境自动配置向导
echo ============================================
echo.
echo 本脚本将帮助你配置Android构建环境
echo.
pause

echo.
echo [检查1] 检查Java环境...
java -version 2>nul
if %errorlevel% neq 0 (
    echo ? 未检测到Java
    echo.
    echo 请下载并安装JDK 17:
    echo https://adoptium.net/temurin/releases/?version=17
    echo.
    echo 安装后重新运行本脚本
    pause
    exit /b 1
)

for /f "tokens=3" %%i in ('java -version 2^>^&1 ^| findstr /i "version"') do (
    set JAVA_VERSION=%%i
)
echo 当前Java版本: %JAVA_VERSION%
echo.

echo [检查2] 检查Android SDK...
if not exist "C:\Android\Sdk" (
    echo ? 未找到Android SDK
    echo.
    echo 你有两个选择:
    echo.
    echo 【方案A】安装Android Studio (推荐)
    echo   - 下载: https://developer.android.com/studio
    echo   - 自动安装SDK和所有工具
    echo   - 提供图形界面
    echo.
    echo 【方案B】仅安装命令行工具
    echo   - 下载: https://developer.android.com/studio#command-tools
    echo   - 解压到 C:\Android\Sdk\cmdline-tools\latest\
    echo   - 运行: sdkmanager "platform-tools" "platforms;android-35"
    echo.
    echo 请选择并安装后重新运行本脚本
    pause
    exit /b 1
)

echo ? 找到Android SDK: C:\Android\Sdk
echo.

echo [检查3] 检查构建工具...
if not exist "C:\Android\Sdk\build-tools" (
    echo ? 未安装构建工具
    echo.
    echo 请运行:
    echo cd C:\Android\Sdk\cmdline-tools\latest\bin
    echo sdkmanager "build-tools;34.0.0"
    pause
    exit /b 1
)
echo ? 构建工具已安装
echo.

echo [检查4] 检查Android平台...
if not exist "C:\Android\Sdk\platforms\android-35" (
    echo ? 未安装Android 35平台
    echo.
    echo 请运行:
    echo cd C:\Android\Sdk\cmdline-tools\latest\bin
    echo sdkmanager "platforms;android-35"
    pause
    exit /b 1
)
echo ? Android平台已安装
echo.

echo ============================================
echo   环境检查完成！
echo ============================================
echo.
echo 所有必需组件已就绪，现在可以构建APK了！
echo.
echo 按任意键开始构建...
pause >nul

echo.
echo [构建APK]
echo.
cd /d "%~dp0"
call gradlew.bat assembleDebug

if %errorlevel% neq 0 (
    echo.
    echo ============================================
    echo   构建失败
    echo ============================================
    echo.
    echo 建议: 使用Android Studio打开项目
    echo   1. 打开Android Studio
    echo   2. Open → 选择 %~dp0
    echo   3. Build → Build APK
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================
echo   构建成功！
echo ============================================
echo.
echo APK位置:
echo %~dp0app\build\outputs\apk\debug\app-debug.apk
echo.
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo 是否打开APK所在文件夹? (Y/N)
    set /p choice=
    if /i "%choice%"=="Y" (
        explorer "app\build\outputs\apk\debug\"
    )
)
echo.
pause
