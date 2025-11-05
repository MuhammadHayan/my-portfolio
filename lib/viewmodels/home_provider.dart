import 'package:flutter/material.dart';
import 'package:portfolio/viewmodels/navbar_viewmodel.dart';

class HomeProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  final List<GlobalKey> sectionKeys = [
    GlobalKey(), // Intro
    GlobalKey(), // Services
    GlobalKey(), // Works
    GlobalKey(), // Contact
  ];

  int _currentSection = 0;
  int get currentSection => _currentSection;

  bool _scrolled = false;
  bool get scrolled => _scrolled;

  HomeProvider() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.offset > 20 && !_scrolled) {
      _scrolled = true;
      notifyListeners();
    } else if (scrollController.offset <= 20 && _scrolled) {
      _scrolled = false;
      notifyListeners();
    }
  }

  // 🔹 Smooth scroll to specific section
  void scrollToSection(int index) {
    if (index < 0 || index >= sectionKeys.length) return;
    final context = sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeInOutCubic,
      );
      _currentSection = index;
      notifyListeners();
    }
  }

  // 🔹 Scroll to next section
  void scrollToNext() {
    if (_currentSection < sectionKeys.length - 1) {
      _currentSection++;
      scrollToSection(_currentSection);
    }
  }

  // 🔹 Scroll to previous section
  void scrollToPrevious() {
    if (_currentSection > 0) {
      _currentSection--;
      scrollToSection(_currentSection);
    }
  }

  // 🔹 Scroll to top
  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOutCubic,
    );
    _currentSection = 0;
    notifyListeners();
  }
// inside HomeProvider class

// Replace the previous updateCurrentSection() with this:
  void updateCurrentSection(NavBarViewModel navBarVM) {
    // If user tapped recently, skip automatic updates to prevent flicker
    if (navBarVM.isManuallySelecting) return;

    for (int i = 0; i < sectionKeys.length; i++) {
      final ctx = sectionKeys[i].currentContext;
      if (ctx != null) {
        final renderBox = ctx.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero).dy;
        // adjust threshold to fit your layout
        if (offset.abs() < 300) {
          if (_currentSection != i) {
            _currentSection = i;
            navBarVM.setCurrentIndex(i); // sync navbar underline
            notifyListeners();
          }
          break;
        }
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
