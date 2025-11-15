import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

Future<void> downloadAsset(String assetPath) async {
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement;

  // Flutter Web debug → assets live in /flutter_assets/
  final prefix = kDebugMode ? "/flutter_assets/" : "/";
  anchor.href = "$prefix$assetPath";

  anchor.download = assetPath.split('/').last;
  anchor.style.display = 'none';

  web.document.body?.appendChild(anchor);
  anchor.click();
  anchor.remove();
}
