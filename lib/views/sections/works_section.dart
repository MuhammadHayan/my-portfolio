import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';
import '../home/mobile/works_section_mobile.dart';
import '../home/web/works_section_web.dart';

class WorksSection extends StatelessWidget {
  const WorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
        vertical: Responsive.verticalPadding(context) / 2,
      ),
      color: colorScheme.surface.withValues(alpha: 0.03),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Responsive.isMobile(context)
            ? const WorksSectionMobile()
            : const WorksSectionWeb(),
      ),
    );
  }
}
