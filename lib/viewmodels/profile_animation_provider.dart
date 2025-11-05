import 'package:flutter/material.dart';

class ProfileAnimationProvider extends ChangeNotifier {
  AnimationController? controller;
  Animation<double>? radius;
  Animation<double>? opacity;
  Animation<double>? borderWidth;

  bool _initialized = false;

  void init(TickerProvider vsync) {
    if (_initialized) return;
    _initialized = true;

    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
    )..repeat();

    radius = Tween<double>(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

    opacity = Tween<double>(begin: 0.8, end: 0.0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

    borderWidth = Tween<double>(begin: 2, end: 15)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

    notifyListeners();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
