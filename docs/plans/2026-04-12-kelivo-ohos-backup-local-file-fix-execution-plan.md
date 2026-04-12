# Kelivo OHOS 本地备份文件操作修复执行计划

## Internal Grade
L（串行执行）

## Plan
1. 确认备份页仍在使用不支持 OHOS 的 `file_picker`
2. 将导入/桌面保存切换到 `file_selector`
3. 为 OHOS 增加原生 `app.file_save` 插件，处理备份导出保存
4. 增加导出成功/失败提示
5. 运行 l10n、格式化、分析、OHOS 构建与真机覆盖安装验证

## Scope
- `lib/features/backup/pages/backup_page.dart`
- `lib/core/services/native_file_save.dart`
- `ohos/entry/src/main/ets/plugins/OhosFileSavePlugin.ets`
- `ohos/entry/src/main/ets/entryability/EntryAbility.ets`
- `lib/l10n/*.arb`

## Verification
- `flutter gen-l10n`
- `dart format`
- `dart analyze lib/features/backup/pages/backup_page.dart lib/core/services/native_file_save.dart`
- `E:\sdk\flutter_ohos_3358\bin\flutter.bat build hap --debug`
- `hdc install -r <signed hap>` 真机覆盖安装验证
