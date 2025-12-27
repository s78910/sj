# Requirements Document

## Introduction

为Android应用增加自定义SU路径功能和启动权限提示弹窗。当应用检测不到标准Root权限时，允许用户手动输入SU二进制文件路径来获取Root权限。同时在应用启动时显示权限请求和频道推广信息。

## Glossary

- **SU_Path**: SU二进制文件的完整路径，用于获取Root权限执行命令
- **Root_Permission**: 超级用户权限，允许应用执行需要系统级权限的操作
- **File_Permission**: 文件管理权限，允许应用读写外部存储
- **Startup_Dialog**: 应用启动时显示的弹窗，用于请求权限和显示推广信息
- **SharedPreferences**: Android本地存储机制，用于保存用户配置的SU路径

## Requirements

### Requirement 1: 启动弹窗显示

**User Story:** 作为应用开发者，我希望在应用启动时显示权限请求和推广信息弹窗，以便用户了解所需权限并获取联系方式。

#### Acceptance Criteria

1. WHEN the application starts for the first time, THE Startup_Dialog SHALL display a message requesting file management permission and root permission
2. WHEN the Startup_Dialog is displayed, THE System SHALL show the promotional text "刷机做环境找姜太公钓瑜 电报频道 为@jiangtaigong7"
3. WHEN the user clicks the confirm button on Startup_Dialog, THE System SHALL proceed to request necessary permissions
4. THE Startup_Dialog SHALL be displayed every time the application launches

### Requirement 2: Root权限检测与提示

**User Story:** 作为用户，我希望在Root权限检测失败时收到明确提示，以便我知道需要授予权限或提供自定义SU路径。

#### Acceptance Criteria

1. WHEN the standard SU path fails to obtain root permission, THE System SHALL display a dialog prompting the user to grant root permission or input a custom SU path
2. WHEN the root permission check fails, THE System SHALL provide an input field for the user to enter a custom SU path
3. WHEN the user enters a custom SU path, THE System SHALL validate the path by attempting to execute a test command
4. IF the custom SU path validation fails, THEN THE System SHALL display an error message and allow the user to retry

### Requirement 3: 自定义SU路径存储

**User Story:** 作为用户，我希望应用能记住我输入的自定义SU路径，以便下次使用时不需要重新输入。

#### Acceptance Criteria

1. WHEN a custom SU path is successfully validated, THE System SHALL save the path to SharedPreferences
2. WHEN the application starts, THE System SHALL load the previously saved custom SU path from SharedPreferences
3. WHEN executing root commands, THE System SHALL use the saved custom SU path if available
4. THE System SHALL provide an option to clear the saved custom SU path

### Requirement 4: 使用自定义SU路径执行命令

**User Story:** 作为用户，我希望应用能使用我提供的自定义SU路径来执行需要Root权限的命令。

#### Acceptance Criteria

1. WHEN a custom SU path is configured, THE System SHALL use that path instead of the default "su" command
2. WHEN executing root commands with custom SU path, THE System SHALL pass the command to the custom SU binary
3. IF the custom SU path execution fails, THEN THE System SHALL prompt the user to update the SU path or grant standard root permission
4. WHEN the custom SU path is empty or not set, THE System SHALL fall back to using the default "su" command

### Requirement 5: 文件管理权限请求

**User Story:** 作为用户，我希望应用能正确请求文件管理权限，以便应用能够访问和执行脚本文件。

#### Acceptance Criteria

1. WHEN the application needs file access, THE System SHALL request MANAGE_EXTERNAL_STORAGE permission on Android 11+
2. WHEN the user denies file permission, THE System SHALL display a message explaining why the permission is needed
3. THE System SHALL guide the user to system settings if the permission needs to be granted manually
