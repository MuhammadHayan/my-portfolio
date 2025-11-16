import 'dart:html' as html;
import 'package:flutter/services.dart' show rootBundle;

class DownloadHelper {
  /// Downloads the resume and returns the file size in bytes.
  static Future<int> downloadResume() async {
    // Load the PDF from assets
    final data = await rootBundle.load('assets/hayan_resume.pdf');
    final bytes = data.buffer.asUint8List();

    final fileSize = bytes.lengthInBytes; // <–– file size in bytes

    // Create a Blob and trigger download
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..download = "Hayan_Muhammad_Resume.pdf"
      ..click();

    html.Url.revokeObjectUrl(url);

    return fileSize;
  }

  /// Convert file size to human-readable form
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return "$bytes B";
    double kb = bytes / 1024;
    if (kb < 1024) return "${kb.toStringAsFixed(2)} KB";
    double mb = kb / 1024;
    return "${mb.toStringAsFixed(2)} MB";
  }
}
