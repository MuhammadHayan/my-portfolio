import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/viewmodels/work_viewmodel.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:portfolio/views/home/widgets/hover_card.dart';
import 'package:portfolio/views/home/widgets/section_tile.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class WorksSectionMobile extends StatelessWidget {
  const WorksSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = context.watch<ProjectViewModel>().projects;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surface.withValues(alpha: 0.03),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SectionTitle(
            padding: 7.w,
            title: "Projects",
          ),
          SizedBox(height: 6.h),

          // ✅ Grid with 3 fixed columns
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: projects.map((project) {
              return ChangeNotifierProvider(
                create: (_) => HoverProvider(),
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: HoverCard(
                    index: projects.indexOf(project),
                    child: _ProjectCard(
                      image: project.image,
                      title: project.title,
                      description: project.description,
                      index: projects.indexOf(project),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int? index;

  const _ProjectCard(
      {required this.image,
      required this.title,
      required this.description,
      this.index});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hoverState = context.watch<HoverProvider>();
    final hovered = hoverState.isHovered(index ?? 0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // ✅ center vertically
        //crossAxisAlignment: CrossAxisAlignment.center, // ✅ center horizontally
        children: [
          Image.asset(
            image,
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: hovered
                  ? AppColors.accent
                  : Theme.of(context).colorScheme.onSurface,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
