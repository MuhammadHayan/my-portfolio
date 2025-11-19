import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/views/home/mobile/contact_section_mobile.dart';
import 'package:portfolio/views/home/web/contact_section_web.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? null : AppColors.containerlightGradient,
        color: isDark ? Theme.of(context).colorScheme.surface : null,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(1, 1),
          )
        ],
      ),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.horizontalPadding(context),
          vertical: Responsive.verticalPadding(context) / 2,
        ),
        child: Responsive.isMobile(context)
            ? const ContactSectionMobile()
            : const ContactWeb(),
      ),
    );
  }
}
