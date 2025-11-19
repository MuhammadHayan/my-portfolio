import 'package:flutter/material.dart';

class NavBarViewModel extends ChangeNotifier {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;

  int _currentIndex = 0;
  bool _isManuallySelecting = false;

  int get currentIndex => _currentIndex;
  bool get isManuallySelecting => _isManuallySelecting;

  void init(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 3000),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutCubic,
    ));

    controller.forward();
  }

  void disposeController() {
    controller.dispose();
  }

  void setCurrentIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void startManualSelect() {
    _isManuallySelecting = true;
    notifyListeners();
  }

  void endManualSelect() {
    _isManuallySelecting = false;
    notifyListeners();
  }
}
