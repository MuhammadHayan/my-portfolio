import 'package:flutter/material.dart';

class IntroAnimationProvider extends ChangeNotifier {
  AnimationController? textController;
  AnimationController? handController;
  AnimationController? hoverController;

  late Animation<Offset> slideAnimation;
  late Animation<double> hoverScale;
  late Animation<double> hoverFill;

  bool _isHovered = false;
  bool _isInitialized = false;
  bool _isDisposed = false;

  final List<String> titles = [
    "A Flutter Developer",
    "A Mobile App Artisan",
    "A UI Enthusiast",
  ];

  int _currentTitleIndex = 0;
  String displayedTitle = "";

  /// Initialize all animations
  void initAnimations(TickerProvider vsync) {
    if (_isInitialized) return;
    _isInitialized = true;

    // 👋 Hand animation
    handController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: vsync,
    );

    // 📝 Text intro animation
    textController = AnimationController(
      duration: const Duration(milliseconds: 7000),
      vsync: vsync,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(-0.8, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: textController!, curve: Curves.easeOutCubic),
    );

    // 🖱️ Hover animation
    hoverController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );

    hoverScale = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: hoverController!, curve: Curves.easeOut),
    );

    hoverFill = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: hoverController!, curve: Curves.easeInOut),
    );

    hoverController!.addListener(() {
      if (!_isDisposed) notifyListeners();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        _startAnimations();
        _startTypingAnimation();
      }
    });
  }

  void _startAnimations() {
    textController?.forward();
    _waveHand();
  }

  Future<void> _waveHand() async {
    while (!_isDisposed) {
      for (int i = 0; i < 3; i++) {
        if (_isDisposed) return;
        await handController?.forward();
        await handController?.reverse();
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> _startTypingAnimation() async {
    while (!_isDisposed) {
      final currentText = titles[_currentTitleIndex];
      for (int i = 1; i <= currentText.length; i++) {
        if (_isDisposed) return;
        displayedTitle = currentText.substring(0, i);
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 70));
      }

      await Future.delayed(const Duration(seconds: 2));
      _currentTitleIndex = (_currentTitleIndex + 1) % titles.length;
      displayedTitle = "";
      notifyListeners();
    }
  }

  /// Hover control
  void onHover(bool hover) {
    if (_isDisposed) return;
    if (_isHovered == hover) return;

    _isHovered = hover;

    if (hover) {
      hoverController?.forward();
    } else {
      // slow reverse so gradient fades nicely
      hoverController?.reverse();
    }

    notifyListeners();
  }

  // Getters
  bool get isHovered => _isHovered;
  double get scale => hoverScale.value;
  double get fillProgress => hoverFill.value;

  void disposeAnimations() {
    if (_isDisposed) return;
    _isDisposed = true;
    textController?.dispose();
    handController?.dispose();
    hoverController?.dispose();
  }
}
