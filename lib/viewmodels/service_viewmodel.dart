import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:portfolio/data/service_model.dart';

class ServiceViewModel extends ChangeNotifier {
  bool _visible = false;

  bool get visible => _visible;

  void onVisibilityChanged(double visibleFraction) {
    if (!_visible && visibleFraction > 0.25) {
      _visible = true;
      notifyListeners();
    }
  }

  final List<ServiceModel> services = [
    ServiceModel(
      icon: LucideIcons.palette,
      title: 'UI/UX Design',
      description:
          'Crafting visually engaging and user-centered interface designs that blend aesthetics with functionality. Every design decision is guided by usability principles to deliver seamless digital experiences.',
    ),
    ServiceModel(
      icon: LucideIcons.code2,
      title: 'Flutter Development',
      description:
          'Developing scalable, high-quality cross-platform applications using Flutter. I focus on clean architecture, maintainable code, and pixel-perfect implementation to bring ideas to life across mobile, web, and desktop.',
    ),
    ServiceModel(
      icon: LucideIcons.gauge,
      title: 'Performance Optimization',
      description:
          'Enhancing application efficiency by analyzing and refining code, optimizing resource usage, and ensuring smooth performance across devices. My goal is to deliver apps that are both fast and reliable.',
    ),
  ];
}
