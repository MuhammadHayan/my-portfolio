import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:portfolio/viewmodels/work_viewmodel.dart';
import 'package:portfolio/views/home/widgets/animated_card.dart';
import 'package:portfolio/views/home/widgets/hover_card.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/views/home/widgets/section_tile.dart';
import 'package:sizer/sizer.dart'; // ✅ Added Sizer import

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
          SectionTitle(padding: 7.w, title: "Projects"),
          SizedBox(height: 5.h),
          Wrap(
            spacing: 10,
            runSpacing: 10,
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
                    height: 230,
                    width: 15,
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
        /// ✅ Responsive Image
        ClipRRect(
          borderRadius: BorderRadius.circular(2.w),
          child: Image.asset(
            project.image,
            height: 6.w,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 0.5.h),

        /// ✅ Project Title
        Text(
          project.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: hovered ? AppColors.accent : colorScheme.onSurface,
            fontSize: 13.sp, // ✅ Responsive font size
          ),
        ),
        SizedBox(height: 1.5.h),

        /// ✅ Project Description
        Text(
          project.description,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface
                .withValues(alpha: 0.75), // ✅ Fixed deprecated
            // height: 1.4,
            fontSize: 12.sp, // ✅ Responsive font size
          ),
        ),
      ],
    );
  }
}
