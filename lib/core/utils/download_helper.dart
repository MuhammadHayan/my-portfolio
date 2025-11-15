import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;

Future<void> downloadPdfWeb() async {
  const pdfUrl = 'assets/hayan_resume.pdf';

  final anchor = html.AnchorElement(href: pdfUrl)
    ..download = 'hayan_resume.pdf'
    ..click();
}
