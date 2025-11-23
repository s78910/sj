# Android应用开发问题总结与AI配置Rules

## ? 项目背景
开发一个名为"qingli"的Android应用，用于在Root环境下执行shell脚本进行系统清理。

---

## ? 遇到的所有问题及解决方案

### **问题1: GitHub Actions使用了弃用的v3版本**

**错误信息**:
```
This request has been automatically failed because it uses a deprecated version of `actions/upload-artifact: v3`
```

**原因**: GitHub Actions在2024年4月弃用了v3版本的artifact actions

**解决方案**:
- 将 `actions/checkout@v3` 升级到 `@v4`
- 将 `actions/setup-java@v3` 升级到 `@v4`
- 将 `actions/upload-artifact@v3` 升级到 `@v4`

**教训**: 使用最新版本的GitHub Actions，定期检查弃用通知

---

### **问题2: 缺少gradle-wrapper.jar文件**

**错误信息**:
```
Could not find or load main class org.gradle.wrapper.GradleWrapperMain
Caused by: java.lang.ClassNotFoundException: org.gradle.wrapper.GradleWrapperMain
```

**原因**: Gradle Wrapper的核心JAR文件缺失，无法启动Gradle

**解决方案**:
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/gradle/gradle/v8.2.0/gradle/wrapper/gradle-wrapper.jar" -OutFile "gradle/wrapper/gradle-wrapper.jar"
git add gradle/wrapper/gradle-wrapper.jar
git commit -m "添加gradle-wrapper.jar文件"
```

**教训**: Android项目必须包含完整的Gradle Wrapper文件（gradle-wrapper.jar + gradle-wrapper.properties）

---

### **问题3: XML布局文件UTF-8编码错误**

**错误信息**:
```
/app/src/main/res/layout/activity_main.xml:15:23: Error: Invalid byte 1 of 1-byte UTF-8 sequence.
```

**原因**: XML文件中直接包含中文字符，在Linux构建环境下编码不一致

**解决方案**:
1. 将所有中文文本移至 `strings.xml`
2. 布局文件使用 `android:text="@string/xxx"` 引用
3. 代码中使用 `getString(R.string.xxx)` 获取

**错误示例**:
```xml
<TextView android:text="清理" />  ?
```

**正确示例**:
```xml
<TextView android:text="@string/btn_clean" />  ?
```

**教训**: 永远不要在XML中硬编码中文，使用字符串资源

---

### **问题4: strings.xml中文显示乱码**

**现象**: 应用安装后界面显示为 `????` 等乱码

**原因**: strings.xml文件在跨平台保存时编码不一致

**解决方案**: 使用**Unicode转义序列**
```xml
<!-- 错误：直接使用中文 -->
<string name="btn_clean">清理</string>  ?

<!-- 正确：使用Unicode转义 -->
<string name="btn_clean">&#x6E05;&#x7406;</string>  ?
```

**转换工具**: 
- 在线工具: https://www.branah.com/unicode-converter
- Python: `'清理'.encode('unicode_escape')`

**教训**: 对于跨平台项目，中文字符串使用Unicode转义最安全

---

### **问题5: MainActivity.kt中硬编码中文导致乱码**

**原因**: Kotlin源文件中直接写中文字符串，编译时可能出现编码问题

**解决方案**: 
```kotlin
// 错误：硬编码中文
Toast.makeText(this, "需要Root权限", Toast.LENGTH_SHORT).show()  ?

// 正确：使用字符串资源
Toast.makeText(this, getString(R.string.root_required), Toast.LENGTH_SHORT).show()  ?
```

**带参数的字符串**:
```xml
<!-- strings.xml -->
<string name="script_found">找到脚本: %1$s\n正在执行…\n</string>
```
```kotlin
// MainActivity.kt
getString(R.string.script_found, scriptFile.absolutePath)
```

**教训**: 代码中所有用户可见的文本都应使用字符串资源

---

### **问题6: 脚本文件需要用户手动部署**

**问题**: 用户需要手动 `adb push anqu.sh /sdcard/`

**解决方案**: 将脚本内置到assets目录

**步骤**:
1. 创建 `app/src/main/assets/` 目录
2. 将 `anqu.sh` 放入该目录
3. 在代码中自动复制到应用私有目录

```kotlin
private fun copyScriptFromAssets(scriptName: String) {
    val outputFile = File(filesDir, scriptName)
    assets.open(scriptName).use { input ->
        outputFile.outputStream().use { output ->
            input.copyTo(output)
        }
    }
    outputFile.setExecutable(true, false)
}
```

**教训**: 将必需的资源文件打包进APK，提升用户体验

---

## ? AI配置Rules（重要！）

以下规则可直接作为AI助手的配置，避免重复犯错：

### **Rule 1: Android中文处理规范**

```
【强制】所有中文文本必须使用Unicode转义序列
- XML文件: 使用 &#xXXXX; 格式
- strings.xml: 所有中文字符串使用Unicode转义
- 布局文件: 使用 @string/xxx 引用，禁止硬编码
- Kotlin/Java: 使用 getString(R.string.xxx)，禁止硬编码

【原因】避免跨平台编码不一致导致乱码

【工具】使用在线Unicode转换器或Python脚本转换
```

---

### **Rule 2: GitHub Actions版本规范**

```
【强制】使用最新稳定版本的GitHub Actions
- actions/checkout: 使用 @v4
- actions/setup-java: 使用 @v4
- actions/upload-artifact: 使用 @v4
- actions/download-artifact: 使用 @v4

【检查】定期查看 https://github.blog/changelog/ 了解弃用通知
```

---

### **Rule 3: Android项目必需文件**

```
【强制】以下文件必须包含在Git仓库中：
? gradle/wrapper/gradle-wrapper.jar (63KB)
? gradle/wrapper/gradle-wrapper.properties
? gradlew (Unix shell脚本)
? gradlew.bat (Windows批处理)

【禁止】将以上文件加入 .gitignore
```

---

### **Rule 4: 资源文件结构规范**

```
【强制】项目结构必须包含：
app/src/main/
├── assets/              # 打包进APK的资源文件
├── java/                # Kotlin/Java源代码
├── res/
│   ├── layout/          # XML布局
│   ├── values/
│   │   ├── strings.xml  # 所有文本资源（Unicode转义）
│   │   ├── colors.xml
│   │   └── themes.xml
│   └── drawable/        # 图标资源
└── AndroidManifest.xml

【原则】所有用户可见文本集中在 strings.xml 管理
```

---

### **Rule 5: 代码中文处理检查清单**

```
开发Android应用时，对每个包含中文的位置进行检查：

□ XML布局文件: 中文是否使用 @string/xxx 引用？
□ strings.xml: 中文是否使用Unicode转义？
□ Kotlin/Java: 是否使用 getString() 而非硬编码？
□ Toast/Dialog: 提示文本是否使用字符串资源？
□ Log输出: 可以直接中文（不面向用户）
□ 注释: 可以直接中文

【自动化】构建前运行检查脚本：
grep -r '[\u4e00-\u9fa5]' app/src/main/res/layout/
grep -r '".*[\u4e00-\u9fa5].*"' app/src/main/java/
```

---

### **Rule 6: 构建失败排查流程**

```
GitHub Actions构建失败时按以下顺序排查：

1. 检查Actions版本（是否使用最新v4）
2. 检查gradle-wrapper.jar是否存在
3. 检查XML文件UTF-8编码问题
4. 检查依赖版本兼容性
5. 检查权限配置（AndroidManifest.xml）
6. 检查资源文件完整性

【工具】使用 --stacktrace 查看详细错误
```

---

### **Rule 7: 脚本和资源部署规范**

```
【推荐】将运行时需要的文件打包进APK：
- 使用 assets/ 目录存放
- 首次运行时复制到应用私有目录
- 设置适当的文件权限

【示例】
assets/
├── anqu.sh          # Shell脚本
├── config.json      # 配置文件
└── data/            # 数据文件

【避免】依赖用户手动操作（如adb push）
```

---

### **Rule 8: Git提交规范**

```
【强制】提交信息格式：
<类型>: <简短描述>

类型包括：
- feat: 新功能
- fix: 修复bug
- docs: 文档更新
- style: 代码格式调整
- refactor: 重构
- test: 测试相关
- chore: 构建/工具相关

【示例】
? fix: 修复UTF-8编码导致的中文乱码问题
? feat: 添加脚本自动部署功能
? chore: 升级GitHub Actions到v4

【备份】重要修改前创建Git分支：
git checkout -b backup-before-major-change
```

---

## ? 快速修复命令合集

### **修复编码问题**
```bash
# 查找所有包含中文的XML文件
find app/src/main/res -name "*.xml" -exec grep -l '[\u4e00-\u9fa5]' {} \;

# 查找所有硬编码中文的Kotlin文件
grep -r '".*[\u4e00-\u9fa5].*"' app/src/main/java/
```

### **重置到上一个提交**
```bash
# 查看提交历史
git log --oneline -10

# 回退到指定提交（保留修改）
git reset --soft <commit-id>

# 回退到指定提交（丢弃修改）
git reset --hard <commit-id>

# 推送到远程（强制）
git push origin main --force
```

### **下载gradle-wrapper.jar**
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/gradle/gradle/v8.2.0/gradle/wrapper/gradle-wrapper.jar" -OutFile "gradle/wrapper/gradle-wrapper.jar"
```

---

## ? 问题统计

| 问题类型 | 发生次数 | 严重程度 | 解决难度 |
|---------|---------|---------|---------|
| 中文编码问题 | 3次 | 高 | 中 |
| GitHub Actions配置 | 1次 | 中 | 低 |
| Gradle配置问题 | 1次 | 高 | 低 |
| 用户体验问题 | 1次 | 低 | 低 |

---

## ? 经验总结

### **最重要的教训**

1. **编码问题是跨平台开发的最大隐患**
   - 解决方案：Unicode转义 + 字符串资源化
   - 预防措施：开发规范 + 自动化检查

2. **GitHub Actions需要完整的构建环境**
   - gradle-wrapper.jar 必须提交
   - 使用最新版本的Actions
   - 本地测试通过不代表CI会通过

3. **用户体验优先**
   - 减少用户手动操作
   - 资源自动部署
   - 清晰的错误提示

---

## ? 最佳实践

### **创建新Android项目时的检查清单**

```
□ 使用Android Studio创建标准项目结构
□ 立即配置.gitignore（但不忽略gradle-wrapper.jar）
□ 创建 strings.xml 并规划所有文本资源
□ 所有中文使用Unicode转义
□ 配置GitHub Actions使用v4版本
□ 添加assets目录用于资源文件
□ 编写README和使用说明
□ 配置合适的minSdk和targetSdk
□ 测试在真实设备上的表现
□ 编写单元测试和UI测试
```

---

## ? 相关资源

- Android开发文档: https://developer.android.com
- GitHub Actions文档: https://docs.github.com/en/actions
- Gradle文档: https://docs.gradle.org
- Unicode转换工具: https://www.branah.com/unicode-converter

---

**项目信息**
- 应用名称: qingli
- 包名: com.jiangtaigong.app
- 联系方式: 刷机做环境找微信S78910JQKKKAA

**文档版本**: v1.0
**更新日期**: 2025-11-24
