# qingli - 清理工具应用

## 应用信息
- **应用名称**: qingli
- **包名**: com.jiangtaigong.app
- **支持系统**: Android 11 - Android 16 (API 30-35)

## 功能说明

本应用提供一键清理功能，通过Root权限执行`anqu.sh`脚本，实时显示脚本执行输出。

### 主要特性

1. **Root权限执行**
   - 自动检测设备Root权限
   - 使用su命令执行shell脚本
   - 实时捕获并显示脚本输出

2. **智能脚本查找**
   - 自动在多个常见位置搜索`anqu.sh`脚本
   - 支持的搜索路径：
     - 外部存储根目录 (/sdcard/)
     - Download目录
     - /data/local/tmp/
     - 应用私有目录

3. **用户界面**
   - 首页显示提示文字："刷机做环境找微信S78910JQKKKAA"
   - 清理按钮：触发脚本执行
   - 实时输出窗口：显示脚本执行过程和结果

4. **权限管理**
   - 兼容Android 11-16的存储权限
   - 自动适配不同Android版本的权限系统

## 使用前准备

### 1. 安装Android Studio

下载并安装最新版本的Android Studio：
https://developer.android.com/studio

### 2. 配置SDK路径

编辑 `local.properties` 文件，设置你的Android SDK路径：

```properties
sdk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk
```

Windows默认路径通常是：
```
C:\Users\你的用户名\AppData\Local\Android\Sdk
```

### 3. 准备脚本文件

将 `anqu.sh` 脚本文件放置到设备的以下任一位置：
- `/sdcard/anqu.sh`
- `/sdcard/Download/anqu.sh`
- `/data/local/tmp/anqu.sh`

确保脚本文件有执行权限：
```bash
adb shell
su
chmod +x /sdcard/anqu.sh
```

## 编译和安装

### 方法1：使用Android Studio

1. 打开Android Studio
2. 选择 "Open an Existing Project"
3. 选择本项目目录（包含build.gradle.kts的文件夹）
4. 等待Gradle同步完成
5. 连接设备或启动模拟器
6. 点击运行按钮（绿色三角形）

### 方法2：使用命令行

```powershell
# 在项目根目录执行
.\gradlew.bat assembleDebug

# 生成的APK位置：
# app\build\outputs\apk\debug\app-debug.apk
```

### 安装到设备

```powershell
# 通过ADB安装
adb install app\build\outputs\apk\debug\app-debug.apk
```

## 使用说明

### 首次使用

1. **授予Root权限**
   - 启动应用后点击"清理"按钮
   - 系统会弹出Root权限请求
   - 选择"允许"或"授权"

2. **授予存储权限**
   - 首次启动会请求存储权限
   - 点击"允许"以便应用访问脚本文件

### 执行脚本

1. 确保 `anqu.sh` 已放置在设备上
2. 打开应用
3. 点击"清理"按钮
4. 查看实时输出窗口中的执行结果

### 故障排查

**问题1：未找到Root权限**
- 解决：确保设备已Root，并授予本应用Root权限

**问题2：未找到脚本文件**
- 解决：检查脚本文件是否存在于支持的路径
- 使用 `adb shell ls -l /sdcard/anqu.sh` 验证

**问题3：脚本执行失败**
- 解决：检查脚本权限 `chmod +x /sdcard/anqu.sh`
- 查看输出窗口中的错误信息

**问题4：存储权限被拒绝**
- 解决：在系统设置中手动授予应用存储权限

## 技术架构

### 核心技术栈
- **语言**: Kotlin
- **构建工具**: Gradle 8.2
- **最低SDK**: 30 (Android 11)
- **目标SDK**: 35 (Android 16)
- **UI框架**: AndroidX + Material Design 3

### 关键组件

1. **MainActivity.kt**
   - 主界面逻辑
   - Root权限检测和执行
   - 协程异步处理

2. **Root执行引擎**
   - 使用Runtime.exec("su")获取Root权限
   - BufferedReader实时读取输出
   - 错误处理和异常捕获

3. **文件搜索系统**
   - 多路径智能搜索
   - 递归目录遍历
   - 权限安全处理

## 安全说明

?? **重要提示**：
- 本应用需要Root权限，仅在已Root的设备上使用
- 执行脚本可能对系统造成不可逆的修改
- 请确保脚本来源可信
- 建议在执行前备份重要数据

## 项目结构

```
app/
├── app/
│   ├── src/
│   │   └── main/
│   │       ├── java/com/jiangtaigong/app/
│   │       │   └── MainActivity.kt          # 主Activity
│   │       ├── res/
│   │       │   ├── layout/
│   │       │   │   └── activity_main.xml    # 主界面布局
│   │       │   ├── values/
│   │       │   │   ├── strings.xml          # 字符串资源
│   │       │   │   ├── colors.xml           # 颜色资源
│   │       │   │   └── themes.xml           # 主题配置
│   │       │   └── mipmap/                  # 应用图标
│   │       └── AndroidManifest.xml          # 应用清单
│   └── build.gradle.kts                     # 应用级构建配置
├── gradle/                                  # Gradle配置
├── build.gradle.kts                         # 项目级构建配置
├── settings.gradle.kts                      # 项目设置
├── gradle.properties                        # Gradle属性
└── local.properties                         # 本地配置(需自行配置)
```

## 版本历史

### v1.0 (当前版本)
- 初始版本
- Root权限执行脚本
- 实时输出显示
- 兼容Android 11-16

## 联系方式

刷机做环境找微信：S78910JQKKKAA

## 许可证

本项目仅供学习和研究使用。
