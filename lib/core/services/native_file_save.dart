import 'dart:io';

import 'package:flutter/services.dart';

import '../../utils/platform_utils.dart';

class NativeFileSave {
  static const MethodChannel _channel = MethodChannel('app.file_save');

  static Future<bool> saveFileFromPath({
    required String sourcePath,
    String? fileName,
  }) async {
    if (!Platform.isAndroid && !Platform.isIOS && !PlatformUtils.isOhos) {
      throw UnsupportedError(
        'Native file save is only supported on Android, iOS, and OHOS.',
      );
    }

    final result = await _channel.invokeMethod<dynamic>('saveFileFromPath', {
      'sourcePath': sourcePath,
      if (fileName != null && fileName.trim().isNotEmpty)
        'fileName': fileName.trim(),
    });
    if (result is bool) return result;
    return result == true;
  }
}
