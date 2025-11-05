import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/views/home/mobile/contact_section_mobile.dart';
import 'package:portfolio/views/home/web/contact_section_web.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
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
