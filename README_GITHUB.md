# qingli - Android Root清理工具

> 刷机做环境找微信: **S78910JQKKKAA**

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Android](https://img.shields.io/badge/Android-11%20to%2016-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## ? 应用介绍

qingli是一款需要Root权限的Android系统清理工具，支持通过界面按钮执行shell脚本，实时显示执行输出。

### 核心特性

- ? **Root权限执行** - 自动检测并获取Root权限
- ? **智能脚本查找** - 自动搜索多个常见路径
- ? **实时输出显示** - 完整显示脚本执行过程
- ? **兼容性强** - 支持Android 11-16
- ? **完善错误处理** - 健壮的异常捕获机制

### 应用信息

- **包名**: `com.jiangtaigong.app`
- **最低系统**: Android 11 (API 30)
- **目标系统**: Android 16 (API 35)
- **主要功能**: 执行anqu.sh脚本进行系统清理

## ? 快速开始

### 下载APK

**方法1: GitHub Actions自动构建**

1. 进入 [Actions](../../actions) 页面
2. 点击最新的成功构建
3. 在 Artifacts 部分下载 `app-debug`
4. 解压得到 `app-debug.apk`

**方法2: 本地构建**

需要安装Android Studio，详见 [BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md)

### 安装使用

1. **推送脚本到设备**
```bash
adb push anqu.sh /sdcard/anqu.sh
adb shell chmod +x /sdcard/anqu.sh
```

2. **安装APK**
```bash
adb install app-debug.apk
```

3. **启动应用**
   - 打开"qingli"应用
   - 授予Root权限（首次）
   - 授予存储权限（首次）
   - 点击"清理"按钮
   - 查看实时输出

## ? 系统要求

### 设备要求
- ? Android 11-16系统
- ? 已获取Root权限
- ? 允许安装未知来源应用

### 使用前准备
- 将 `anqu.sh` 脚本放置在 `/sdcard/` 目录
- 确保脚本有执行权限: `chmod +x /sdcard/anqu.sh`
- 备份重要数据（脚本可能修改系统）

## ?? 技术栈

- **语言**: Kotlin 1.9.20
- **构建工具**: Gradle 8.2
- **UI框架**: Material Design 3
- **异步处理**: Kotlin Coroutines
- **最低SDK**: 30
- **目标SDK**: 35

## ? 项目结构

```
qingli/
├── app/src/main/
│   ├── java/com/jiangtaigong/app/
│   │   └── MainActivity.kt          # 主Activity（300+行）
│   ├── res/
│   │   ├── layout/                  # 界面布局
│   │   ├── values/                  # 资源文件
│   │   └── drawable/                # 图标资源
│   └── AndroidManifest.xml          # 应用清单
├── build.gradle.kts                 # 构建配置
├── anqu.sh                          # 主清理脚本
└── .github/workflows/               # CI/CD配置
```

## ? 功能说明

### 主界面

- **标题**: "刷机做环境找微信S78910JQKKKAA"
- **清理按钮**: 触发脚本执行
- **输出窗口**: 实时显示执行结果

### Root执行引擎

```kotlin
// 核心功能实现
- checkRootAccess()      // Root权限检测
- findScriptFile()       // 智能脚本查找
- executeRootCommand()   // Root命令执行
- updateOutput()         // 实时输出更新
```

## ? 安全提示

?? **重要提示**

- 本应用需要Root权限，仅在已Root的设备上使用
- 执行脚本前请了解脚本功能和可能的影响
- 建议先使用test.sh进行测试
- 执行前务必备份重要数据
- 脚本执行可能对系统造成不可逆的修改

## ? 文档

- [完整项目文档](README.md)
- [构建说明](BUILD_INSTRUCTIONS.md)
- [快速开始指南](QUICKSTART.md)
- [GitHub上传说明](GitHub上传使用说明.txt)

## ? 持续集成

本项目使用GitHub Actions自动构建APK：

- 每次代码推送自动触发构建
- 构建成功后自动生成APK
- 可在Actions页面下载构建产物

## ? 贡献

欢迎提交Issue和Pull Request！

## ? 联系方式

刷机做环境找微信: **S78910JQKKKAA**

## ? 许可证

本项目仅供学习和研究使用。

---

**?? 免责声明**: 使用本应用可能对设备造成影响，请在了解风险的前提下使用。作者不对使用本应用造成的任何损失负责。
