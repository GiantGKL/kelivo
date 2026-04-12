# Kelivo OHOS 本地备份文件操作修复需求

## Goal
修复 OpenHarmony / HarmonyOS 上“设置 -> 数据备份”中本地文件相关操作无响应或无反馈的问题。

## Deliverable
- 本地备份导入可正常选择 zip 文件
- 其他应用导入（Cherry Studio / Chatbox）可正常选择文件
- 导出到本地文件可正常弹出系统保存选择器并完成导出
- 导出完成后给出成功提示

## Constraints
- 不破坏 WebDAV / S3 远程备份逻辑
- 不提交 OHOS 生成文件与本地日志

## Acceptance Criteria
1. OHOS 上本地导入类入口能拉起文件选择器
2. OHOS 上导出到本地文件能拉起保存选择器
3. 选择保存位置后可实际生成备份文件
4. 导出完成后有明确成功反馈

## Manual Spot Checks
- 数据备份 -> 导出到本地文件
- 数据备份 -> 导入本地备份文件
- 数据备份 -> 导入 Cherry Studio
- 数据备份 -> 导入 Chatbox
