# 构建说明

## 快速开始

### 1. 修改local.properties

**重要**：首先修改 `local.properties` 文件中的SDK路径：

```properties
sdk.dir=你的Android SDK实际路径
```

查找你的SDK路径：
- Windows: 通常在 `C:\Users\你的用户名\AppData\Local\Android\Sdk`
- 在Android Studio中查看: File → Project Structure → SDK Location

### 2. 构建APK

在项目根目录（H:/1/app）打开PowerShell或CMD，执行：

```powershell
# 构建Debug版本
.\gradlew.bat assembleDebug

# 构建Release版本
.\gradlew.bat assembleRelease
```

### 3. 查找生成的APK

构建完成后，APK位于：
```
app\build\outputs\apk\debug\app-debug.apk
```

### 4. 安装到设备

```powershell
# 确保设备已连接并开启USB调试
adb devices

# 安装APK
adb install app\build\outputs\apk\debug\app-debug.apk

# 如果已安装，使用-r参数覆盖安装
adb install -r app\build\outputs\apk\debug\app-debug.apk
```

## 准备脚本文件

### 推送脚本到设备

```powershell
# 推送anqu.sh到设备
adb push anqu.sh /sdcard/anqu.sh

# 进入设备shell
adb shell

# 获取root权限
su

# 添加执行权限
chmod +x /sdcard/anqu.sh

# 退出
exit
exit
```

## 常见问题

### 问题1：Gradle同步失败

**解决方案**：
1. 检查网络连接
2. 在Android Studio中：File → Invalidate Caches / Restart
3. 删除 `.gradle` 文件夹后重新同步

### 问题2：SDK not found

**解决方案**：
确保 `local.properties` 中的路径正确，路径中的反斜杠需要转义：
```
sdk.dir=C:\\Users\\YourName\\AppData\\Local\\Android\\Sdk
```

### 问题3：编译错误

**解决方案**：
1. 确保已安装 Android SDK Platform 35
2. 在Android Studio SDK Manager中下载所需组件
3. 运行 `.\gradlew.bat clean` 清理后重新构建

### 问题4：adb不可用

**解决方案**：
将Android SDK的platform-tools目录添加到系统PATH：
```
C:\Users\你的用户名\AppData\Local\Android\Sdk\platform-tools
```

## 测试应用

### 1. 测试Root权限检测

应用会自动检测Root权限，首次运行时会弹出授权请求。

### 2. 测试脚本执行

可以先使用简单的test.sh测试：
```bash
adb push test.sh /sdcard/test.sh
adb shell chmod +x /sdcard/test.sh
```

然后临时修改MainActivity.kt中的脚本名称为"test.sh"进行测试。

### 3. 查看日志

```powershell
# 实时查看应用日志
adb logcat | Select-String "jiangtaigong"

# 或者使用grep（需要安装Git for Windows）
adb logcat | grep -i "jiangtaigong\|AndroidRuntime"
```

## 优化建议

### 减小APK体积

在 `app/build.gradle.kts` 中启用代码压缩：
```kotlin
buildTypes {
    release {
        isMinifyEnabled = true
        isShrinkResources = true
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
}
```

### 签名Release版本

创建签名密钥：
```powershell
keytool -genkey -v -keystore qingli.keystore -alias qingli -keyalg RSA -keysize 2048 -validity 10000
```

配置签名（在app/build.gradle.kts中添加）：
```kotlin
android {
    signingConfigs {
        create("release") {
            storeFile = file("../qingli.keystore")
            storePassword = "your_password"
            keyAlias = "qingli"
            keyPassword = "your_password"
        }
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            // ...
        }
    }
}
```

## 开发环境要求

- **JDK**: 17 或更高版本
- **Android Studio**: Hedgehog (2023.1.1) 或更新
- **Gradle**: 8.2 (已包含在项目中)
- **Android SDK**: 
  - Build Tools 34.0.0+
  - Platform 35 (Android 16)
  - Platform 30 (Android 11) 用于最低版本测试
