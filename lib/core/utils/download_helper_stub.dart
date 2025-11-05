import 'package:url_launcher/url_launcher.dart';

Future<void> downloadAsset(String assetPath) async {
  // Fallback: try opening the asset path as a URL. On mobile this may not download
  final uri = Uri.parse(assetPath);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    // ignore: avoid_print
    print('Could not launch $assetPath');
  }
}
