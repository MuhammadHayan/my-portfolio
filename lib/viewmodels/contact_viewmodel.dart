import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  final List<ContactModel> _contacts = [
    ContactModel(
      icon: FontAwesomeIcons.envelopeOpenText,
      title: 'EMAIL',
      subtitle: 'hayanarshad1234@gmail.com',
      onTap: () {}, // optional click handler
    ),
    ContactModel(
      icon: FontAwesomeIcons.whatsapp,
      title: 'WHATSAPP',
      subtitle: '+92 311 4858538',
      onTap: () {},
    ),
    ContactModel(
      icon: FontAwesomeIcons.linkedin,
      title: 'LINKEDIN',
      subtitle: 'Connect with me',
      onTap: () {},
    ),
    ContactModel(
      icon: FontAwesomeIcons.github,
      title: 'GITHUB',
      subtitle: 'View my projects',
      onTap: () {},
    ),
  ];

  List<ContactModel> get contacts => _contacts;
}
