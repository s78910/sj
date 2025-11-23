# 快速启动指南

## ? 5分钟快速构建

### 步骤1：配置Android SDK路径

编辑 `local.properties` 文件，修改SDK路径：

```properties
sdk.dir=C:\\Users\\你的用户名\\AppData\\Local\\Android\\Sdk
```

### 步骤2：构建APK

在项目目录打开PowerShell执行：

```powershell
.\gradlew.bat assembleDebug
```

等待构建完成（首次构建需要下载依赖，约5-10分钟）。

### 步骤3：安装到设备

```powershell
adb install app\build\outputs\apk\debug\app-debug.apk
```

### 步骤4：推送脚本

```powershell
adb push anqu.sh /sdcard/anqu.sh
adb shell chmod +x /sdcard/anqu.sh
```

### 步骤5：运行应用

1. 在设备上启动"qingli"应用
2. 点击"清理"按钮
3. 授予Root权限（首次使用）
4. 查看脚本执行输出

## ? 应用信息

- **应用名**: qingli
- **包名**: com.jiangtaigong.app
- **支持系统**: Android 11-16

## ? 故障排除

### 找不到SDK
确保Android Studio已安装，SDK路径正确

### 构建失败
```powershell
.\gradlew.bat clean
.\gradlew.bat assembleDebug
```

### ADB不可用
确保已安装Android SDK Platform Tools，并添加到PATH环境变量

### 设备未授权
在手机上允许USB调试授权

### 未找到Root权限
确保设备已Root，并授予应用Root权限

## ? 详细文档

- 完整说明: `README.md`
- 构建详解: `BUILD_INSTRUCTIONS.md`
