import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/views/home/mobile/service_section_mobile.dart';
import 'package:portfolio/views/home/web/service_section_web.dart';
import '../../core/utils/responsive.dart';

class ServiceSection extends StatelessWidget {
  const ServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: isDark ? null : AppColors.containerlightGradient,
        color: isDark ? colorScheme.surface : null,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(1, 1),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.horizontalPadding(context),
          vertical: Responsive.verticalPadding(context),
        ),
        child: Responsive.isMobile(context)
            ? const ServiceSectionMobile()
            : const ServiceSectionWeb(),
      ),
    );
  }
}
