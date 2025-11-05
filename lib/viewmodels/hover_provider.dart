import 'package:flutter/material.dart';

/// 🔹 Hover state manager — efficient & global for cards
class HoverProvider extends ChangeNotifier {
  final Map<int, bool> _hoverMap = {};

  bool isHovered(int index) => _hoverMap[index] ?? false;

  void setHover(int index, bool value) {
    if (_hoverMap[index] != value) {
      _hoverMap[index] = value;
      notifyListeners();
    }
  }
}
