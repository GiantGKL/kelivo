# Kelivo OHOS 本地字体选择修复执行计划

## Internal Grade
L（串行执行）

## Plan
1. 确认当前 `file_picker` 缺少 OHOS 原生实现
2. 引入本地 `file_selector` / `file_selector_ohos` 路径依赖
3. 将显示设置中的本地字体选择切换到 `file_selector.openFile`
4. 补充错误提示文案并生成本地化文件
5. 运行依赖拉取、格式化、l10n 生成、分析、OHOS 构建验证

## Scope
- `pubspec.yaml`
- `lib/features/settings/pages/display_settings_page.dart`
- `lib/l10n/*.arb`

## Verification
- `flutter pub get`
- `flutter gen-l10n`
- `dart format`
- `flutter analyze`
- `E:\sdk\flutter_ohos_3358\bin\flutter.bat build hap --debug`

## Cleanup
- 还原 OHOS 构建生成文件
- 不提交本地产物
