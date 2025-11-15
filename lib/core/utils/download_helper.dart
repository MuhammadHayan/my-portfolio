import 'package:web/web.dart' as web;

Future<void> download(String path) async {
  final filename = path.split('/').last;
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement;

  anchor.href = path;
  anchor.download = filename;
  anchor.style.display = 'none';

  web.document.body?.appendChild(anchor);
  anchor.click();
  anchor.remove();
}
