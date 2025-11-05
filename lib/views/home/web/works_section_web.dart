import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:portfolio/viewmodels/work_viewmodel.dart';
import 'package:portfolio/views/home/widgets/Animated_Card.dart';
import 'package:portfolio/views/home/widgets/hover_card.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/views/home/widgets/section_tile.dart';

class WorksSectionWeb extends StatelessWidget {
  const WorksSectionWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final worksVM = context.watch<ProjectViewModel>();
    final projects = worksVM.projects;

    return VisibilityDetector(
      key: const Key('works-section'),
      onVisibilityChanged: (info) =>
          worksVM.onVisibilityChanged(info.visibleFraction),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(title: "Projects"),
          const SizedBox(height: 60),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: List.generate(projects.length, (i) {
              final project = projects[i];
              final visible = worksVM.visible;
              return AnimatedCard(
                index: i,
                visible: visible,
                child: ChangeNotifierProvider(
                  create: (_) => HoverProvider(),
                  child: HoverCard(
                    index: i,
                    onTap: () {},
                    child: _ProjectCardContent(project: project, index: i),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ProjectCardContent extends StatelessWidget {
  final dynamic project;
  final int? index;
  const _ProjectCardContent({required this.project, this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hoverState = context.watch<HoverProvider>();
    final hovered = hoverState.isHovered(index ?? 0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            project.image,
            fit: BoxFit.cover,
            height: 100,
            //idth: 100,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          project.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: hovered
                ? AppColors.accent
                : Theme.of(context).colorScheme.onSurface,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          project.description,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.75),
            height: 1.4,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
