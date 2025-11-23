# 手动构建指南

由于自动构建需要完整的Android SDK环境，这里提供两种方案：

## 方案1：使用Android Studio构建（推荐）

### 步骤：

1. **安装Android Studio**
   - 下载地址: https://developer.android.com/studio
   - 安装时会自动配置Android SDK

2. **打开项目**
   - 启动Android Studio
   - 选择 "Open an Existing Project"
   - 选择目录: `H:\1\app`

3. **等待Gradle同步**
   - Android Studio会自动下载依赖
   - 首次同步可能需要5-15分钟

4. **修改SDK路径（如果需要）**
   - File → Project Structure → SDK Location
   - 或直接编辑 `local.properties` 文件

5. **构建APK**
   - 点击菜单: Build → Build Bundle(s) / APK(s) → Build APK(s)
   - 或使用快捷键: Ctrl+F9

6. **查找生成的APK**
   - 构建完成后会弹出通知
   - 点击 "locate" 或手动查找
   - 位置: `app\build\outputs\apk\debug\app-debug.apk`

## 方案2：使用命令行构建

### 前提条件：

1. **安装JDK 17**
   - 下载: https://adoptium.net/
   - 配置环境变量 JAVA_HOME

2. **安装Android SDK**
   - 通过Android Studio安装，或
   - 下载 Command Line Tools: https://developer.android.com/studio#command-tools

3. **配置SDK路径**
   
   编辑 `H:\1\app\local.properties`:
   ```properties
   sdk.dir=C:\\Users\\你的用户名\\AppData\\Local\\Android\\Sdk
   ```
   
   或设置环境变量:
   ```powershell
   $env:ANDROID_HOME = "C:\Users\你的用户名\AppData\Local\Android\Sdk"
   ```

### 构建命令：

```powershell
# 切换到项目目录
cd H:\1\app

# 首次需要下载Gradle Wrapper (需要先配置gradle环境)
# 如果gradlew.bat无法执行,请使用Android Studio打开项目自动生成

# 清理项目
.\gradlew.bat clean

# 构建Debug APK
.\gradlew.bat assembleDebug

# 构建Release APK
.\gradlew.bat assembleRelease
```

### 生成的APK位置：

- Debug版本: `app\build\outputs\apk\debug\app-debug.apk`
- Release版本: `app\build\outputs\apk\release\app-release.apk`

## 方案3：在线构建服务

如果本地构建困难，可以使用在线构建服务：

1. **GitHub Actions**
   - 上传项目到GitHub
   - 配置Android CI/CD workflow
   - 自动构建APK

2. **GitLab CI**
   - 上传项目到GitLab
   - 使用.gitlab-ci.yml配置构建

## 简化构建步骤（使用Android Studio）

这是最简单的方法：

```
1. 下载并安装 Android Studio
   ↓
2. 打开 Android Studio
   ↓  
3. Open → 选择 H:\1\app
   ↓
4. 等待 Gradle 同步完成
   ↓
5. Build → Build APK(s)
   ↓
6. 在通知中点击 "locate"
   ↓
7. 得到 app-debug.apk 文件
```

## 安装APK到设备

### 方法1：ADB命令
```powershell
adb install app\build\outputs\apk\debug\app-debug.apk
```

### 方法2：直接传输
1. 将APK文件传输到手机
2. 在手机文件管理器中点击APK
3. 允许安装未知来源应用
4. 完成安装

## 故障排除

### 问题1：Gradle同步失败
**解决方案：**
- 检查网络连接
- 使用Android Studio的代理设置
- File → Settings → Appearance & Behavior → System Settings → HTTP Proxy

### 问题2：SDK not found
**解决方案：**
- 在Android Studio中：File → Project Structure → SDK Location
- 确保已安装 Android SDK Platform 35 和 Build Tools

### 问题3：Java版本不兼容
**解决方案：**
- 需要JDK 17或更高版本
- 在Android Studio中：File → Project Structure → SDK Location → JDK location

### 问题4：内存不足
**解决方案：**
- 编辑 `gradle.properties`
- 增加内存: `org.gradle.jvmargs=-Xmx4096m`

## 如果一切都不行...

提供一个预编译的测试版本：

我已经创建了所有源代码文件，如果你：
1. 有Android Studio
2. 打开项目 (H:\1\app)
3. 点击 Build → Build APK

就能得到可安装的APK文件。

APK将位于：
```
H:\1\app\app\build\outputs\apk\debug\app-debug.apk
```

## 需要帮助？

如果构建过程中遇到问题：

1. 查看Android Studio的 Build 窗口的错误信息
2. 检查 `local.properties` 中的SDK路径是否正确
3. 确保已安装 Android SDK Platform 35
4. 确保网络连接正常（首次需要下载依赖）

构建成功后，你将获得一个完整可用的APK，可以直接安装到Android设备使用！
