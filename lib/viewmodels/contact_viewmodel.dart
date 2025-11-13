import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // ✅ Add this import
import 'package:portfolio/data/contact_model.dart';

class ContactViewModel extends ChangeNotifier {
  bool _visible = false;
  bool get visible => _visible;

  /// 🔹 Trigger animation when at least 25% visible
  void onVisibilityChanged(double visibleFraction) {
    if (!_visible && visibleFraction > 0.25) {
      _visible = true;
      notifyListeners();
    }
  }

  /// 🔗 Helper to launch URLs or email/phone links
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // ✅ opens in browser/app
      );
    } else {
      debugPrint('❌ Could not launch $url');
    }
  }

  final List<ContactModel> _contacts = [];

  ContactViewModel() {
    _contacts.addAll([
      ContactModel(
        icon: FontAwesomeIcons.envelopeOpenText,
        title: 'EMAIL',
        subtitle: 'hayanarshad1234@gmail.com',
        onTap: () => _launchUrl('mailto:hayanarshad1234@gmail.com'),
      ),
      ContactModel(
        icon: FontAwesomeIcons.whatsapp,
        title: 'WHATSAPP',
        subtitle: '+92 311 4858538',
        onTap: () => _launchUrl('https://wa.me/923114858538'),
      ),
      ContactModel(
        icon: FontAwesomeIcons.linkedin,
        title: 'LINKEDIN',
        subtitle: 'Connect with me',
        onTap: () =>
            _launchUrl('https://www.linkedin.com/in/muhammad-hayan-ba7aa1362'),
      ),
      ContactModel(
        icon: FontAwesomeIcons.github,
        title: 'GITHUB',
        subtitle: 'View my projects',
        onTap: () => _launchUrl('https://github.com/MuhammadHayan'),
      ),
    ]);
  }

  List<ContactModel> get contacts => _contacts;
}
