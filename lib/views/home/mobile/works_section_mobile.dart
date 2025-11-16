import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/viewmodels/work_viewmodel.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:portfolio/views/home/widgets/hover_card.dart';
import 'package:portfolio/views/home/widgets/section_tile.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class WorksSectionMobile extends StatefulWidget {
  const WorksSectionMobile({super.key});

  @override
  State<WorksSectionMobile> createState() => _WorksSectionMobileState();
}

class _WorksSectionMobileState extends State<WorksSectionMobile> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;
  bool _showAllProjects = false; // Track if "See More" clicked

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
    final projects = context.watch<ProjectViewModel>().projects;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SectionTitle(title: "Projects"),
        SizedBox(height: 4.h),

        if (!_showAllProjects)
          // Carousel view
          SizedBox(
            height: 280,
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
                  child: ChangeNotifierProvider(
                    create: (_) => HoverProvider(),
                    child: HoverCard(
                      index: i,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      borderRadius: 20,
                      child: _ProjectCard(
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
          // Show all projects in a grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2.w,
              crossAxisSpacing: 2.w,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, i) {
              final project = projects[i];
              return ChangeNotifierProvider(
                create: (_) => HoverProvider(),
                child: HoverCard(
                  index: i,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  borderRadius: 20,
                  child: _ProjectCard(
                    image: project.image,
                    title: project.title,
                    description: project.description,
                    index: i,
                  ),
                ),
              );
            },
          ),

        SizedBox(height: 2.h),

        // See More / See Less button
        TextButton(
          onPressed: () {
            setState(() {
              _showAllProjects = !_showAllProjects;
            });
          },
          child: Text(
            _showAllProjects ? "See Less" : "See More",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int? index;

  const _ProjectCard({
    required this.image,
    required this.title,
    required this.description,
    this.index,
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
        Image.asset(image, width: 120, height: 120),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: hovered ? AppColors.accent : colorScheme.onSurface,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
