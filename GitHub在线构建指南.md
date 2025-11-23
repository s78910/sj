# GitHub在线构建APK指南

## ? 无需本地环境，在云端构建APK

如果你不想安装Android Studio，可以使用GitHub的免费CI服务在云端构建APK。

---

## ? 步骤

### 1. 创建GitHub账号

访问 https://github.com 注册账号（免费）

### 2. 创建新仓库

1. 登录GitHub
2. 点击右上角 "+" → "New repository"
3. 填写：
   - Repository name: `qingli-app`
   - 选择 "Public" 或 "Private"
4. 点击 "Create repository"

### 3. 上传项目代码

**方法A：使用GitHub Desktop（推荐新手）**

1. 下载 GitHub Desktop: https://desktop.github.com/
2. 安装并登录
3. File → Add Local Repository
4. 选择 `H:\1\app`
5. Publish repository

**方法B：使用Git命令行**

```bash
cd H:\1\app
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/你的用户名/qingli-app.git
git push -u origin main
```

**方法C：直接上传文件（最简单）**

1. 在GitHub仓库页面点击 "uploading an existing file"
2. 将 H:\1\app 下的所有文件拖拽到浏览器
3. 点击 "Commit changes"

### 4. 启用GitHub Actions

项目上传后，GitHub会自动识别 `.github/workflows/build-apk.yml` 文件并开始构建。

查看构建状态：
1. 进入你的仓库页面
2. 点击 "Actions" 标签
3. 查看构建进度

### 5. 下载构建好的APK

构建完成后（约5-10分钟）：
1. 在 Actions 页面点击最新的构建
2. 在 "Artifacts" 部分找到 "app-debug"
3. 点击下载（会下载一个zip文件）
4. 解压得到 app-debug.apk

---

## ? 优点

? **不需要本地环境** - 在云端构建  
? **完全免费** - GitHub提供免费额度  
? **自动化** - 每次提交代码自动构建  
? **版本管理** - 同时获得代码版本控制  

---

## ? 注意事项

### 首次构建可能失败的原因

1. **gradlew没有执行权限**
   - 已在workflow中自动处理

2. **依赖下载失败**
   - GitHub服务器网络良好，通常不会有问题
   - 如失败会自动重试

3. **内存不足**
   - 使用 `ubuntu-latest` 运行器，内存充足

### 隐私考虑

- **Public仓库**: 代码公开可见
- **Private仓库**: 代码仅你可见（免费账号也支持）

**建议**: 
- anqu.sh脚本内容如果敏感，使用Private仓库
- 或使用 `.gitignore` 排除敏感文件

---

## ? 后续修改

如果需要修改代码：
1. 修改本地文件
2. 重新上传或用Git提交
3. GitHub自动重新构建
4. 下载新的APK

---

## ? 对比

| 方式 | 时间 | 难度 | 需要本地工具 |
|------|------|------|--------------|
| Android Studio | 40分钟 | 简单 | 是（3-5GB）|
| GitHub Actions | 15分钟 | 中等 | 否 |
| 手动配置环境 | 3-5小时 | 困难 | 是 |

---

## ? 推荐

**如果你：**
- 不想安装大型软件 → 用 GitHub Actions
- 想要最快速度 → 用 Android Studio  
- 经常开发Android → 用 Android Studio
- 只是偶尔构建 → 用 GitHub Actions

---

## ? 需要帮助？

查看GitHub Actions文档：
https://docs.github.com/en/actions

或联系：刷机做环境找微信 S78910JQKKKAA

---

## ? 总结

使用GitHub Actions是**不需要本地Android环境就能构建APK的最佳方案**。

只需：
1. 上传代码到GitHub（5分钟）
2. 等待自动构建（10分钟）
3. 下载APK（1分钟）

**总共16分钟，无需任何本地工具！**
