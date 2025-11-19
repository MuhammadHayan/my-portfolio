import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/viewmodels/work_viewmodel.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:portfolio/viewmodels/intro_animation_provider.dart';
import 'package:portfolio/views/home/widgets/animated_button.dart';
import 'package:portfolio/views/home/widgets/hover_card.dart';
import 'package:portfolio/views/home/widgets/section_tile.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class WorksSectionMobile extends StatefulWidget {
  const WorksSectionMobile({super.key});

  @override
  State<WorksSectionMobile> createState() => _WorksSectionMobileState();
}

class _WorksSectionMobileState extends State<WorksSectionMobile>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;
  bool _showAllProjects = false;

  late IntroAnimationProvider introAnimation;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.82);
    _startAutoScroll();

    introAnimation = IntroAnimationProvider();
    introAnimation.initAnimations(this);
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
    introAnimation.disposeAnimations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projects = context.watch<ProjectViewModel>().projects;

    return ChangeNotifierProvider.value(
      value: introAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(title: "Projects"),
          SizedBox(height: 4.h),
          if (!_showAllProjects)
            // Carousel view
            SizedBox(
              height: 27.h,
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: projects.isEmpty ? 1 : 10000,
                itemBuilder: (context, index) {
                  final i = index % projects.length;
                  final project = projects[i];

                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                      } else {
                        value = (_currentPage - index).toDouble();
                      }

                      double scale =
                          (1 - (value.abs() * 0.18)).clamp(0.85, 1.0);
                      double opacity =
                          (1 - (value.abs() * 0.5)).clamp(0.4, 1.0);
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
                    child: ChangeNotifierProvider(
                      create: (_) => HoverProvider(),
                      child: HoverCard(
                        border: 1,
                        index: i,
                        borderRadius: 20,
                        child: ProjectCard(
                          image: project.image,
                          title: project.title,
                          description: project.description,
                          index: i,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          else
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 5,
              runSpacing: 5,
              children: List.generate(projects.length, (i) {
                final project = projects[i];

                return ChangeNotifierProvider(
                  create: (_) => HoverProvider(),
                  child: HoverCard(
                    border: 1,
                    height: 24.h,
                    width: 9.3.w,
                    index: i,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    borderRadius: 10,
                    child: ProjectCard(
                      image: project.image,
                      title: project.title,
                      description: project.description,
                      index: i,
                      imageSize: 16,
                      titleFontSize: 15,
                      descriptionFontSize: 14,
                      spacing: 5,
                    ),
                  ),
                );
              }),
            ),
          SizedBox(height: 4.h),
          AnimatedHoverButton(
            border: 1,
            iconSize: 5.w,
            label: _showAllProjects ? "Show Less" : "Show All",
            icon: _showAllProjects
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            width: 30.w,
            height: 5.h,
            borderRadius: 50,
            fontSize: 14,
            onPressed: () {
              setState(() {
                _showAllProjects = !_showAllProjects;
              });
            },
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int? index;

  // ⬇️ Customizable parameters
  final double imageSize;
  final double titleFontSize;
  final double descriptionFontSize;
  final double spacing;

  const ProjectCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.index,

    // ⬇️ Default carousel values (can override for grid)
    this.imageSize = 28,
    this.titleFontSize = 16,
    this.descriptionFontSize = 15,
    this.spacing = 5,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hoverState = context.watch<HoverProvider>();
    final hovered = hoverState.isHovered(index ?? 0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: imageSize.w,
          height: imageSize.w,
        ),
        SizedBox(height: spacing),
        Text(
          title,
          textAlign: TextAlign.center,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: hovered ? AppColors.accent : colorScheme.onSurface,
            fontSize: titleFontSize.sp,
          ),
        ),
        SizedBox(height: spacing),
        Text(
          description,
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.7),
            fontSize: descriptionFontSize.sp,
          ),
        ),
      ],
    );
  }
}
