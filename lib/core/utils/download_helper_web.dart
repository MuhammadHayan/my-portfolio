import 'package:web/web.dart' as web;

Future<void> downloadAsset(String assetPath) async {
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
  anchor.href = assetPath;
  anchor.download = assetPath.split('/').last;
  anchor.style.display = 'none'; // <-- assign normal string, no toJS

  web.document.body?.appendChild(anchor);
  anchor.click();
  anchor.remove();
}
