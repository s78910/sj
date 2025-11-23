@echo off
chcp 65001 >nul
echo ========================================
echo   qingli应用构建脚本
echo ========================================
echo.

echo [1/5] 检查Java环境...
where java >nul 2>&1
if %errorlevel% neq 0 (
    echo ? 未检测到Java环境
    echo   请先安装JDK 17或更高版本
    echo   下载地址: https://adoptium.net/
    pause
    exit /b 1
)
java -version
echo ? Java环境正常
echo.

echo [2/5] 检查Android SDK...
if not exist "local.properties" (
    echo ? 未找到local.properties文件
    echo.
    echo 请先配置Android SDK路径:
    echo 1. 安装Android Studio
    echo 2. 编辑 local.properties 文件
    echo 3. 设置 sdk.dir=你的SDK路径
    echo.
    echo 示例: sdk.dir=C:\\Users\\YourName\\AppData\\Local\\Android\\Sdk
    pause
    exit /b 1
)
echo ? 找到配置文件
echo.

echo [3/5] 清理旧文件...
if exist "app\build\" (
    echo 删除旧的build目录...
    rmdir /s /q "app\build\" 2>nul
)
echo ? 清理完成
echo.

echo [4/5] 开始构建APK...
echo 这可能需要几分钟时间，请耐心等待...
echo.

call gradlew.bat assembleDebug

if %errorlevel% neq 0 (
    echo.
    echo ========================================
    echo   构建失败！
    echo ========================================
    echo.
    echo 常见问题:
    echo 1. SDK路径配置错误 - 检查local.properties
    echo 2. 网络连接问题 - 首次构建需要下载依赖
    echo 3. 内存不足 - 关闭其他程序后重试
    echo.
    echo 建议: 使用Android Studio打开项目进行构建
    echo.
    pause
    exit /b 1
)

echo.
echo [5/5] 检查生成的APK...
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo.
    echo ========================================
    echo   构建成功！
    echo ========================================
    echo.
    echo APK位置: app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo 文件大小:
    for %%I in ("app\build\outputs\apk\debug\app-debug.apk") do echo   %%~zI 字节 (%%~nI%%~xI)
    echo.
    echo 安装方法:
    echo 1. 使用ADB: adb install app\build\outputs\apk\debug\app-debug.apk
    echo 2. 复制到手机直接安装
    echo.
    echo 使用前准备:
    echo 1. 推送脚本: adb push anqu.sh /sdcard/anqu.sh
    echo 2. 添加权限: adb shell chmod +x /sdcard/anqu.sh
    echo 3. 确保设备已Root并授予应用Root权限
    echo.
    pause
    
    REM 询问是否打开目录
    echo 是否打开APK所在目录? (Y/N)
    set /p choice=请输入: 
    if /i "%choice%"=="Y" (
        explorer "app\build\outputs\apk\debug\"
    )
) else (
    echo.
    echo ? 未找到生成的APK文件
    echo   构建可能没有成功完成
    pause
    exit /b 1
)

echo.
echo 按任意键退出...
pause >nul
