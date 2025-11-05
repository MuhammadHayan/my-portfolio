import 'package:flutter/material.dart';
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
      icon: Icons.design_services_outlined,
      title: 'UI/UX Design',
      description:
          'Designing elegant, intuitive interfaces that enhance user experience across platforms.',
    ),
    ServiceModel(
      icon: Icons.code_rounded,
      title: 'Flutter Development',
      description:
          'Building beautiful, high-performance apps for mobile, web, and desktop using Flutter.',
    ),
    ServiceModel(
      icon: Icons.speed_rounded,
      title: 'Performance Optimization',
      description:
          'Improving app performance and responsiveness through efficient architecture and clean code.',
    ),
  ];
}
