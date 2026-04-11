# Kelivo OHOS 头像本地选图修复需求

## Goal
修复 OpenHarmony / HarmonyOS 上“更换头像”无法调用本地图片选择的问题。

## Deliverable
- 用户头像支持从本地图库选择图片
- Provider 头像支持从本地图库选择图片
- 失败时不再自动跳转到“输入图片链接”流程

## Constraints
- 不影响 QQ 头像与手动输入链接入口
- 不扩大到相机拍摄或媒体体系重构
- 不提交 OHOS 生成文件与本地构建产物

## Acceptance Criteria
1. OHOS 下 `ImagePicker.pickImage(source: ImageSource.gallery)` 可正常接通原生实现
2. 用户头像入口选择图片后可以保存本地文件路径
3. Provider 头像入口选择图片后可以保存本地文件路径
4. 当本地选图失败时，仅提示错误，不自动切换到 URL 输入流程

## Manual Spot Checks
- 侧边栏用户头像 -> 选择图片
- Provider 详情页头像 -> 选择图片
- URL / QQ 头像入口仍可独立使用

## Non-goals
- 不处理拍照
- 不处理多图选择
- 不处理非头像相关的文件选择问题
