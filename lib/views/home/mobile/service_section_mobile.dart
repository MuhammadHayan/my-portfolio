import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/viewmodels/service_viewmodel.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:portfolio/views/home/widgets/hover_card.dart';
import 'package:portfolio/views/home/widgets/section_tile.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
    _pageController = PageController(viewportFraction: 0.79);
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
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.05,
        horizontal: size.width * 0.04,
      ),
      width: double.infinity,
      child: Column(
        children: [
          const SectionTitle(
            title: "What I Do",
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 14 / 15,
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
                  // ✅ Wrap each service card in hover functionality
                  child: ChangeNotifierProvider(
                    create: (_) => HoverProvider(),
                    child: HoverCard(
                      isMobile: true,
                      border: 1,
                      borderRadius: 20,
                      index: i,
                      child: _ServiceCard(
                        service: s,
                        index: i,
                      ),
                    ),
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
  final int? index;

  const _ServiceCard({required this.service, this.index});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hoverState = context.watch<HoverProvider>();
    final hovered = hoverState.isHovered(index ?? 0);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(service.icon,
              size: 12.w,
              color: hovered
                  ? AppColors.accent
                  : Theme.of(context).colorScheme.onSurface),
          const SizedBox(height: 10),
          Text(
            service.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: hovered
                      ? AppColors.accent
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Text(
              service.description,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 15.sp,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
