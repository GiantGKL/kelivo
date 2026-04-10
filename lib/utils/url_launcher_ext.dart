import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'platform_utils.dart';

const String _harmonyBrowserPageRoute = 'pages/HarmonyBrowserPage';

bool _isWebUri(Uri uri) => uri.scheme == 'http' || uri.scheme == 'https';

Future<bool> launchBrowserUrl(Uri uri) async {
  if (PlatformUtils.isOhos && _isWebUri(uri)) {
    try {
      final ok = await launchUrl(
        uri,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
          headers: <String, String>{
            'harmony_browser_page': _harmonyBrowserPageRoute,
          },
        ),
      );
      if (ok) return true;
    } catch (_) {}
  }

  try {
    final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (ok) return true;
  } catch (_) {}

  try {
    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    return false;
  }
}

extension BuildContextUrlLauncher on BuildContext {
  Future<void> openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchBrowserUrl(uri);
  }
}
