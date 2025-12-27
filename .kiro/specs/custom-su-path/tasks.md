# Implementation Plan: Custom SU Path Feature

## Overview

为Android应用实现自定义SU路径功能和启动权限提示弹窗。使用Kotlin语言，遵循现有代码风格。

## Tasks

- [x] 1. 添加字符串资源
  - 在 `strings.xml` 中添加启动弹窗、SU路径对话框相关的字符串资源
  - 包括权限请求文本、推广信息、错误提示等
  - _Requirements: 1.1, 1.2, 2.1, 2.4_

- [x] 2. 创建SuPathManager类
  - [x] 2.1 创建 `SuPathManager.kt` 文件
    - 实现SharedPreferences存储和读取SU路径
    - 实现 `getSuPath()`, `saveSuPath()`, `clearSuPath()`, `hasCustomSuPath()` 方法
    - _Requirements: 3.1, 3.2, 3.4, 4.4_
  
  - [ ]* 2.2 编写SuPathManager属性测试
    - **Property 1: SU路径存储Round-trip一致性**
    - **Validates: Requirements 3.1, 3.2**
  
  - [ ]* 2.3 编写默认值回退属性测试
    - **Property 2: 默认SU路径回退**
    - **Validates: Requirements 4.4**

- [x] 3. 实现启动弹窗功能
  - [x] 3.1 在MainActivity中添加 `showStartupDialog()` 方法
    - 显示权限请求和推广信息
    - 点击确定后请求权限
    - _Requirements: 1.1, 1.2, 1.3, 1.4_
  
  - [x] 3.2 修改 `onCreate()` 在启动时调用启动弹窗
    - 确保每次启动都显示
    - _Requirements: 1.4_

- [x] 4. 实现SU路径输入对话框
  - [x] 4.1 添加 `showSuPathInputDialog()` 方法
    - 包含输入框让用户输入自定义SU路径
    - 提供确定和取消按钮
    - _Requirements: 2.1, 2.2_
  
  - [x] 4.2 实现SU路径验证逻辑
    - 添加 `validateSuPath()` 方法到SuPathManager
    - 通过执行测试命令验证路径有效性
    - _Requirements: 2.3, 2.4_

- [x] 5. 修改Root权限检测和命令执行
  - [x] 5.1 修改 `checkRootAccess()` 方法
    - 使用SuPathManager获取SU路径
    - 检测失败时显示SU路径输入对话框
    - _Requirements: 2.1, 4.1_
  
  - [x] 5.2 修改 `executeRootCommand()` 方法
    - 使用自定义SU路径执行命令
    - _Requirements: 4.1, 4.2_
  
  - [ ]* 5.3 编写自定义路径使用属性测试
    - **Property 3: 自定义路径优先使用**
    - **Validates: Requirements 3.3, 4.1, 4.2**

- [x] 6. 添加MANAGE_EXTERNAL_STORAGE权限支持
  - [x] 6.1 更新AndroidManifest.xml添加权限声明
    - 添加 MANAGE_EXTERNAL_STORAGE 权限
    - _Requirements: 5.1_
  
  - [x] 6.2 实现 `requestManageStoragePermission()` 方法
    - Android 11+引导用户到设置页面授权
    - _Requirements: 5.1, 5.2, 5.3_

- [x] 7. Checkpoint - 确保所有功能正常工作
  - 确保所有测试通过，如有问题请询问用户

## Notes

- 任务标记 `*` 的为可选测试任务，可跳过以加快MVP开发
- 每个任务都引用了具体的需求条款以便追溯
- 使用Kotlin语言，遵循现有代码风格
- 属性测试验证核心正确性属性
