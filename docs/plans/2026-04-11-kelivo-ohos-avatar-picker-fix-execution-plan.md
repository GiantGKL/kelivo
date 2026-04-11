# Kelivo OHOS 头像本地选图修复执行计划

## Internal Grade
L（串行执行）

## Wave Plan
1. 确认本地 OHOS `image_picker` / `image_picker_ohos` 可用
2. 将项目依赖切换到本地 OHOS 适配实现
3. 修正头像入口错误处理，避免失败后自动跳转 URL 输入
4. 运行 `flutter pub get`、格式化、分析、定向构建验证

## Ownership Boundary
- `pubspec.yaml`
- `lib/features/home/widgets/side_drawer.dart`
- `lib/features/provider/pages/provider_detail_page.dart`

## Verification Commands
- `flutter pub get`
- `dart format <changed-paths>`
- `flutter analyze`
- `E:\sdk\flutter_ohos_3358\bin\flutter.bat build hap --debug`

## Rollback Rules
- 若 OHOS 适配依赖解析失败，回退到原 `image_picker` 依赖声明
- 若 build 因 generated plugin 文件变化失败，仅保留手改源文件，重新执行构建生成

## Cleanup Expectations
- 不提交 `ohos/AppScope/app.json5`
- 不提交 `ohos/build-profile.json5`
- 不提交 `ohos/entry/oh-package.json5`
- 不提交 `ohos/entry/src/main/ets/plugins/GeneratedPluginRegistrant.ets`
- 不提交 `ohos/oh-package.json5`
- 不提交本地 `.hap`
