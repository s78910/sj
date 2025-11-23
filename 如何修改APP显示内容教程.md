# 如何修改qingli应用显示内容教程

## ? 概述

本教程教你如何修改qingli应用的界面文字、按钮和提示信息。

---

## ? 快速索引

- [修改界面文字](#修改界面文字)
- [修改按钮文字](#修改按钮文字)
- [修改运行时提示](#修改运行时提示)
- [修改应用名称和图标](#修改应用名称和图标)
- [测试和构建](#测试和构建)

---

## ? 修改界面文字

### **1. 修改首页标题**

**文件位置**: `app/src/main/res/values/strings.xml`

**步骤**:
1. 找到这一行：
```xml
<string name="header_text">&#x5237;&#x673A;&#x505A;&#x73AF;&#x5883;&#x627E;&#x5FAE;&#x4FE1;S78910JQKKKAA</string>
```

2. 替换为你想要的文字（使用Unicode转义）

**工具**: 使用在线转换器将中文转为Unicode
- 访问: https://www.branah.com/unicode-converter
- 输入: `你的新标题`
- 选择: `&#x` 格式
- 复制转换结果

**示例**:
```xml
<!-- 原标题: 刷机做环境找微信S78910JQKKKAA -->
<string name="header_text">&#x5237;&#x673A;&#x505A;&#x73AF;&#x5883;&#x627E;&#x5FAE;&#x4FE1;S78910JQKKKAA</string>

<!-- 新标题: 系统清理工具v2.0 -->
<string name="header_text">&#x7CFB;&#x7EDF;&#x6E05;&#x7406;&#x5DE5;&#x5177;v2.0</string>
```

---

### **2. 修改按钮文字**

**修改"清理"按钮**:
```xml
<!-- 原按钮: 清理 -->
<string name="btn_clean">&#x6E05;&#x7406;</string>

<!-- 改为: 开始 -->
<string name="btn_clean">&#x5F00;&#x59CB;</string>

<!-- 改为: 执行 -->
<string name="btn_clean">&#x6267;&#x884C;</string>
```

---

### **3. 修改初始提示文字**

```xml
<!-- 原提示: 点击清理按钮执行脚本 -->
<string name="output_hint">&#x70B9;&#x51FB;&#x6E05;&#x7406;&#x6309;&#x94AE;&#x6267;&#x884C;&#x811A;&#x672C;</string>

<!-- 改为: 准备就绪，点击开始 -->
<string name="output_hint">&#x51C6;&#x5907;&#x5C31;&#x7EEA;&#xFF0C;&#x70B9;&#x51FB;&#x5F00;&#x59CB;</string>
```

---

## ? 修改运行时提示

所有运行时的提示信息都在 `strings.xml` 中，修改后自动生效。

### **常用提示信息列表**

| 原文 | 字段名 | 用途 |
|------|-------|------|
| 需要存储权限才能访问脚本文件 | permission_storage_required | 权限被拒绝时提示 |
| 正在检查Root权限… | checking_root | 开始检查Root |
| 错误: 设备未获取Root权限或Root权限被拒绝 | root_denied | Root检查失败 |
| 需要Root权限 | root_required | Toast短提示 |
| Root权限已获取 | root_granted | Root检查成功 |
| 正在准备脚本文件… | copying_script | 复制脚本中 |
| 脚本执行完成 | execution_complete | 执行成功 |

### **修改示例**

**修改"正在检查Root权限…"**:

1. 找到这行：
```xml
<string name="checking_root">&#x6B63;&#x5728;&#x68C0;&#x67E5;Root&#x6743;&#x9650;&#x2026;\n</string>
```

2. 改为"检测Root中…"：
```xml
<string name="checking_root">&#x68C0;&#x6D4B;Root&#x4E2D;&#x2026;\n</string>
```

**注意**: `\n` 表示换行，保留它！

---

## ? 修改应用名称

### **方法1: 修改strings.xml（推荐）**

```xml
<!-- 原名称: qingli -->
<string name="app_name">qingli</string>

<!-- 改为: 清理大师 -->
<string name="app_name">&#x6E05;&#x7406;&#x5927;&#x5E08;</string>
```

### **方法2: 英文名称（无需转义）**

```xml
<string name="app_name">CleanMaster</string>
<string name="app_name">SystemCleaner</string>
<string name="app_name">RootTool</string>
```

---

## ? 修改包名和应用ID

?? **警告**: 修改包名会导致应用无法覆盖安装旧版本

**文件位置**: `app/build.gradle.kts`

```kotlin
defaultConfig {
    applicationId = "com.jiangtaigong.app"  // 原包名
    // 改为
    applicationId = "com.yourname.cleaner"  // 新包名
}
```

**同时修改**: `AndroidManifest.xml`
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.yourname.cleaner">  <!-- 改这里 -->
```

**和**: `MainActivity.kt` 第一行
```kotlin
package com.yourname.cleaner  // 改这里
```

---

## ? 修改应用图标

### **简单方法: 使用在线工具生成**

1. 访问: https://icon.kitchen/
2. 上传你的图标图片
3. 下载生成的资源包
4. 解压后替换 `app/src/main/res/` 下的所有mipmap文件夹

### **手动方法**:

**需要准备不同尺寸的PNG图片**:
- mdpi: 48x48
- hdpi: 72x72
- xhdpi: 96x96
- xxhdpi: 144x144
- xxxhdpi: 192x192

**放置位置**:
```
app/src/main/res/
├── mipmap-mdpi/
│   └── ic_launcher.png (48x48)
├── mipmap-hdpi/
│   └── ic_launcher.png (72x72)
├── mipmap-xhdpi/
│   └── ic_launcher.png (96x96)
├── mipmap-xxhdpi/
│   └── ic_launcher.png (144x144)
└── mipmap-xxxhdpi/
    └── ic_launcher.png (192x192)
```

---

## ? 完整修改流程示例

假设你要修改为"系统清理工具"：

### **步骤1: 修改strings.xml**

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- 应用名称 -->
    <string name="app_name">&#x7CFB;&#x7EDF;&#x6E05;&#x7406;&#x5DE5;&#x5177;</string>
    
    <!-- 首页标题 -->
    <string name="header_text">&#x7CFB;&#x7EDF;&#x6E05;&#x7406;&#x5DE5;&#x5177; v2.0</string>
    
    <!-- 按钮文字 -->
    <string name="btn_clean">&#x5F00;&#x59CB;&#x6E05;&#x7406;</string>
    
    <!-- 初始提示 -->
    <string name="output_hint">&#x70B9;&#x51FB;&#x6309;&#x94AE;&#x5F00;&#x59CB;&#x6E05;&#x7406;</string>
    
    <!-- 其他提示保持不变... -->
</resources>
```

### **步骤2: 提交修改**

```bash
cd H:\1\app
git add app/src/main/res/values/strings.xml
git commit -m "修改应用名称和界面文字"
git push origin main
```

### **步骤3: 等待构建**

访问: https://github.com/你的用户名/sj/actions

### **步骤4: 下载新APK**

构建完成后下载并安装

---

## ? Unicode转义对照表

常用中文字符的Unicode转义：

| 中文 | Unicode | 中文 | Unicode |
|------|---------|------|---------|
| 清理 | &#x6E05;&#x7406; | 开始 | &#x5F00;&#x59CB; |
| 执行 | &#x6267;&#x884C; | 停止 | &#x505C;&#x6B62; |
| 完成 | &#x5B8C;&#x6210; | 失败 | &#x5931;&#x8D25; |
| 成功 | &#x6210;&#x529F; | 错误 | &#x9519;&#x8BEF; |
| 正在 | &#x6B63;&#x5728; | 检查 | &#x68C0;&#x67E5; |
| 权限 | &#x6743;&#x9650; | 脚本 | &#x811A;&#x672C; |
| 系统 | &#x7CFB;&#x7EDF; | 工具 | &#x5DE5;&#x5177; |
| 重启 | &#x91CD;&#x542F; | 确认 | &#x786E;&#x8BA4; |

---

## ? 快速转换工具

### **Python脚本**

创建 `convert.py`:
```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

def text_to_unicode_escape(text):
    result = ""
    for char in text:
        if ord(char) > 127:  # 非ASCII字符
            result += f"&#x{ord(char):X};"
        else:
            result += char
    return result

if __name__ == "__main__":
    text = input("输入要转换的中文: ")
    converted = text_to_unicode_escape(text)
    print(f"\n转换结果:\n{converted}")
```

运行:
```bash
python convert.py
# 输入: 清理工具
# 输出: &#x6E05;&#x7406;&#x5DE5;&#x5177;
```

---

## ?? 注意事项

### **必须遵守的规则**

1. **永远使用Unicode转义**
   - ? `&#x6E05;&#x7406;`
   - ? `清理`

2. **保留特殊字符**
   - `\n` = 换行
   - `%1$s` = 第1个参数
   - `%2$s` = 第2个参数

3. **修改后必须测试**
   - 构建成功不代表显示正确
   - 必须在真机上测试

4. **备份原文件**
   ```bash
   cp strings.xml strings.xml.backup
   ```

5. **使用Git版本控制**
   ```bash
   git add .
   git commit -m "修改界面文字"
   ```

---

## ? 测试和构建

### **本地测试（如果有Android Studio）**

1. 打开项目
2. 点击 Run → Run 'app'
3. 选择设备
4. 查看效果

### **GitHub Actions构建**

1. 修改文件
2. 提交并推送
3. 访问 Actions 页面
4. 下载APK测试

---

## ? 常见问题

### **Q: 修改后界面还是显示乱码？**
A: 检查是否使用了Unicode转义格式，而不是直接的中文

### **Q: 修改后应用无法安装？**
A: 如果改了包名，需要先卸载旧版本

### **Q: 如何恢复到原来的版本？**
A: 
```bash
git log --oneline  # 查看提交历史
git reset --hard <commit-id>  # 回退到指定版本
git push origin main --force  # 强制推送
```

### **Q: 可以不用Unicode转义吗？**
A: 不行！直接中文在跨平台构建时会出现编码问题

---

## ? 修改检查清单

修改完成后检查：

- [ ] 所有中文是否使用Unicode转义？
- [ ] 是否保留了 `\n` 换行符？
- [ ] 是否保留了 `%1$s` 等参数占位符？
- [ ] 是否已备份原文件？
- [ ] 是否已提交到Git？
- [ ] 是否已推送到GitHub？
- [ ] 是否等待Actions构建完成？
- [ ] 是否在真机上测试过？

---

## ? 进阶技巧

### **批量修改**

使用脚本批量转换所有中文：

```bash
# 查找所有包含中文的地方
grep -r '[\u4e00-\u9fa5]' app/src/main/res/
```

### **多语言支持**

创建其他语言版本：
```
res/
├── values/strings.xml         # 默认（中文）
├── values-en/strings.xml      # 英文
└── values-ja/strings.xml      # 日文
```

---

## ? 获取帮助

如果遇到问题：
1. 查看构建日志
2. 检查Git提交历史
3. 联系: 刷机做环境找微信S78910JQKKKAA

---

**文档版本**: v1.0
**更新日期**: 2025-11-24
**适用应用**: qingli v1.0+
