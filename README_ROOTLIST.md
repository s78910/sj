# RootList - Root权限授予工具

## 功能说明

这是一个Root权限授予辅助工具，主要功能：

1. **应用列表展示** - 显示设备上所有已安装的应用
2. **Root权限触发** - 点击任意应用，触发该应用的Root权限申请弹窗

## 使用方法

1. 确保设备已Root（支持Magisk、KernelSU、Alpha Mask等）
2. 安装本应用并授予Root权限
3. 点击想要授权的应用
4. Root管理器会弹出授权对话框
5. 在弹窗中选择允许/拒绝

## 工作原理

通过以目标应用的UID身份执行su命令，触发Root管理器的授权界面：

```bash
su <目标UID> -c su
```

## 技术参数

- **应用名称**: rootlist
- **包名**: com.rolist.s
- **最低版本**: Android 10 (API 29)
- **目标版本**: Android 15 (API 35)
- **兼容范围**: Android 10 - Android 16

## 构建方法

```bash
./gradlew assembleRelease
```

输出APK位置: `app/build/outputs/apk/release/app-release.apk`

## 联系方式

刷机做环境找微信：**S78910JQKKKAA**
