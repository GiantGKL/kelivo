# Kelivo OpenHarmony 移植版

这是 [`Chevey339/kelivo`](https://github.com/Chevey339/kelivo) 的 OpenHarmony / HarmonyOS 移植仓库。

当前仓库已经裁剪为 **OHOS 构建优先** 的形态，主要用于产出 `.hap` 安装包，以及在真机上验证 OpenHarmony 适配。

## 当前状态

- 当前应用版本：`1.1.12+30`（已对齐上游版本）
- 当前包名：`com.psyche.kelivo`
- 当前已验证可构建的 Flutter OHOS SDK：`3.35.8-ohos-0.0.3`
- 已修复的 OHOS 适配问题包括：
  - 应用图标打包
  - 网页/文档链接打开
  - About 页系统版本显示
  - 触觉反馈
  - 本地头像图片选择
  - 本地字体文件选择
  - 本地备份导入/导出

## 原仓库

- 原项目地址：[Chevey339/kelivo](https://github.com/Chevey339/kelivo)

## 环境要求

在当前仓库状态下，自行构建至少需要：

1. **Flutter OpenHarmony SDK**
   - 已验证版本：`Flutter 3.35.8-ohos-0.0.3`
   - 本地示例路径：`E:\sdk\flutter_ohos_3358`
2. **DevEco Studio**
   - 用于打开 `ohos/` 工程并配置调试签名
3. **HarmonyOS / OpenHarmony 设备或模拟器**
   - 如果要安装到真机，建议能正常使用 `hdc`
4. **Git + 基本命令行环境**

🔗 原项目提供 [TestFlight](https://testflight.apple.com/join/erbGGykR) 测试。

## 重要：本仓库依赖本地路径包

这个仓库 **不是 clone 下来就能直接 `flutter pub get` 的纯独立仓库**。

`pubspec.yaml` 中使用了多个本地路径依赖，尤其是 OHOS 适配包：

- `../flutter_packages_ohos/packages/shared_preferences/shared_preferences`
- `../flutter_packages_ohos/packages/image_picker/image_picker`
- `../flutter_packages_ohos/packages/url_launcher/url_launcher`
- `../flutter_packages_ohos/packages/path_provider/path_provider`
- `../flutter_packages_ohos/packages/image_picker/image_picker_ohos`
- `../flutter_plus_plugins_ohos/packages/package_info_plus/package_info_plus`
- `../flutter_plus_plugins_ohos/packages/share_plus/share_plus`
- `../flutter_plus_plugins_ohos/packages/share_plus/share_plus_platform_interface`

因此，推荐目录结构如下：

```text
<workspace>/
├─ kelivo/
├─ flutter_packages_ohos/
└─ flutter_plus_plugins_ohos/
```

也就是说：

- `kelivo`、`flutter_packages_ohos`、`flutter_plus_plugins_ohos`
- 需要放在 **同一层目录** 下

否则 `flutter pub get` 会因为相对路径依赖找不到而失败。

## 获取代码

建议至少准备以下三个仓库（同级目录）：

```bash
git clone https://github.com/GiantGKL/kelivo.git
git clone <your-ohos-flutter-packages-repo-url> flutter_packages_ohos
git clone <your-ohos-flutter-plus-plugins-repo-url> flutter_plus_plugins_ohos
```

如果你没有后两者，就算本仓库 clone 成功，也无法完成 OHOS 构建。

## 构建步骤

### 1. 拉取依赖

在仓库根目录执行：

```bash
E:\sdk\flutter_ohos_3358\bin\flutter.bat pub get
```

如果你安装的 Flutter OHOS SDK 路径不同，请改成你自己的路径，但**建议使用与本仓库验证一致的版本**。

### 2. 在 DevEco Studio 中配置签名

打开 `ohos/` 工程后：

- `File -> Project Structure -> Signing Configs`
- 勾选 `Automatically generate signature`

如果不配置签名：

- 可以生成 `unsigned.hap`
- 但不能直接安装到真机

### 3. 构建 HAP

在仓库根目录执行：

```bash
E:\sdk\flutter_ohos_3358\bin\flutter.bat build hap --debug
```

这是当前仓库已验证通过的命令。

### 4. 查看产物

默认输出目录：

```text
ohos/entry/build/default/outputs/default/
```

常见文件包括：

- `entry-default-unsigned.hap`
- `entry-default-signed.hap`（配置好签名后可生成）

## 安装到设备

### 覆盖安装（不卸载旧版本）

```bash
hdc install -r ohos/entry/build/default/outputs/default/entry-default-signed.hap
```

说明：

- `-r` 表示覆盖安装
- 真机安装通常需要 **signed.hap**
- `unsigned.hap` 通常会报 `no signature file`

### 启动应用

```bash
hdc shell aa start -b com.psyche.kelivo -a EntryAbility
```

## Release 说明

GitHub Release 中上传的是：

- **unsigned hap**

原因：

- signed 包通常是本地调试签名产物
- unsigned 包更适合作为仓库发布附件保留

如果你只是下载 Release 附件并准备自行安装到真机，通常还需要你在本地完成签名流程。

## 已知构建注意事项

### 1. `no signature file`

如果你用 `hdc install` 安装 `unsigned.hap`，通常会看到：

```text
error: no signature file
```

这不是代码问题，而是 **未签名包不能直接安装到真机**。

### 2. `The target can not be empty`

如果 OHOS 构建时报：

```text
The target can not be empty
```

通常与 `ohos/build-profile.json5` 中错误的 `targetSdkVersion` 有关。

### 3. `No module found`

如果 DevEco / hvigor 报模块找不到，历史上遇到过：

- `ohos/.idea/workspace.xml` 里的模块名异常

### 4. `ohpm` / `ohos/oh_modules` 被占用

如果报 `EBUSY: resource busy or locked`，通常是：

- DevEco Studio
- hvigor
- 相关 Node / OHOS 进程

仍在占用 `ohos/oh_modules`

建议先关闭相关进程再重试。

### 5. 本地图片选择失败

如果“更换头像 -> 选择图片”失败，请先确认：

- 你运行的是最新构建版本
- `image_picker` 已接到本地 OHOS 适配包
- `EntryAbility.ets` 中已显式注册 `ImagePickerPlugin`

## 与原仓库的差异

这个仓库已经包含 OpenHarmony 方向的定制修改，和原仓库相比至少有以下差异：

- OHOS 相关依赖替换为本地 path 包
- OHOS 浏览器页面与路由补充
- 自定义系统信息插件
- OHOS 触觉反馈处理
- OHOS 本地头像选图修复

因此，这个仓库**不再等同于上游原版的直接镜像**。

## 免责声明

- 当前移植代码主要由 AI 辅助生成与修改
- 代码尚未经过严谨、系统、完整的人工验证
- 仅确认当前仓库在已知本地环境下可以构建出 OpenHarmony `.hap`
- 运行稳定性、功能完整性、兼容性与安全性仍需进一步人工测试与审查
