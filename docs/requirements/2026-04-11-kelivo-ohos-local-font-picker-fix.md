# Kelivo OHOS 本地字体选择修复需求

## Goal
修复设置 -> 显示设置 -> 本地字体选择在 OpenHarmony / HarmonyOS 上无法工作的故障。

## Deliverable
- 应用字体支持从本地选择 `.ttf` / `.otf`
- 代码字体支持从本地选择 `.ttf` / `.otf`
- 选择失败时给出清晰错误提示

## Constraints
- 不破坏现有 Google Fonts / 系统字体逻辑
- 不扩大到全局文件选择器体系重构
- 不提交 OHOS 生成文件

## Acceptance Criteria
1. OHOS 上点击“选择本地文件”能拉起系统文件选择器
2. 选中 `.ttf/.otf` 后路径可传给现有 `SettingsProvider.setAppFontFromLocal/setCodeFontFromLocal`
3. 用户取消时静默返回，不报错
4. 插件失败时展示明确错误提示

## Manual Spot Checks
- 设置 -> 显示设置 -> 应用字体 -> 选择本地文件
- 设置 -> 显示设置 -> 代码字体 -> 选择本地文件

## Non-goals
- 不处理字体预览增强
- 不处理多选字体
- 不重写本地字体加载逻辑
