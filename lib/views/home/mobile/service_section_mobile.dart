import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio/viewmodels/service_viewmodel.dart';
import 'package:provider/provider.dart';

class ServiceSectionMobile extends StatefulWidget {
  const ServiceSectionMobile({super.key});

  @override
  State<ServiceSectionMobile> createState() => _ServiceSectionMobileState();
}

class _ServiceSectionMobileState extends State<ServiceSectionMobile> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.82);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted || !_pageController.hasClients) return;
      _currentPage++;
      _pageController.animateToPage(
        _currentPage % 10000,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ServiceViewModel>();
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    final double sectionHeight = size.height * 0.4;
    final double cardWidth = size.width * 0.78;

    return Container(
      color: colorScheme.surface,
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.05,
        horizontal: size.width * 0.04,
      ),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "What I Do",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
          ),
          SizedBox(height: size.height * 0.03),

          // ✅ Prevent overflow by constraining height
          SizedBox(
            height: sectionHeight,
            child: PageView.builder(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: vm.services.isEmpty ? 1 : 10000,
              itemBuilder: (context, index) {
                final i = index % vm.services.length;
                final s = vm.services[i];

                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                    } else {
                      value = (_currentPage - index).toDouble();
                    }

                    double scale = (1 - (value.abs() * 0.18)).clamp(0.85, 1.0);
                    double opacity = (1 - (value.abs() * 0.5)).clamp(0.4, 1.0);
                    double translateY = (1 - scale) * 30;

                    return Opacity(
                      opacity: opacity,
                      child: Transform.translate(
                        offset: Offset(0, translateY),
                        child: Transform.scale(
                          scale: scale,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: _ServiceCard(
                    service: s,
                    width: cardWidth,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final dynamic service;
  final double width;

  const _ServiceCard({
    required this.service,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    final double iconSize = size.width * 0.10;
    final double titleFontSize = size.width * 0.04;
    final double descFontSize = size.width * 0.025;

    return Center(
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02,
          horizontal: size.width * 0.05,
        ),
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorScheme.primary.withOpacity(0.25)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(service.icon, size: iconSize, color: colorScheme.primary),
            SizedBox(height: size.height * 0.015),
            Text(
              service.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: titleFontSize,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.012),
            Flexible(
              child: Text(
                service.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                      fontSize: descFontSize,
                      height: 1.5,
                    ),
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
