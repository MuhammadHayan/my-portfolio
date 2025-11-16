import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/data/contact_model.dart';
import 'package:portfolio/viewmodels/contact_viewmodel.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:portfolio/views/home/widgets/animated_card.dart';
import 'package:portfolio/views/home/widgets/hover_card.dart';
import 'package:portfolio/views/home/widgets/section_tile.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:sizer/sizer.dart'; // ✅ For responsive scaling

class ContactWeb extends StatelessWidget {
  const ContactWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final contactVM = context.watch<ContactViewModel>();
    final contacts = contactVM.contacts;
    final visible = contactVM.visible;
    final colorScheme = Theme.of(context).colorScheme;

    return VisibilityDetector(
      key: const Key('contact-section'),
      onVisibilityChanged: (info) =>
          contactVM.onVisibilityChanged(info.visibleFraction),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(title: "Get in Touch"),
          SizedBox(height: 3.h),

          // ✉️ Intro Text
          Text(
            "I’m open to collaborations, freelance projects, or tech discussions.\nReach out through any of the platforms below!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 12.sp,
                  color: colorScheme.onSurface
                      .withValues(alpha: 0.7), // ✅ FIXED: uses withValues
                ),
          ),

          SizedBox(height: 5.h),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: List.generate(contacts.length, (i) {
              final contact = contacts[i];
              return SizedBox(
                height: 28.h,
                width: 12.w,
                child: AnimatedCard(
                  index: i,
                  visible: visible,
                  child: ChangeNotifierProvider(
                    create: (_) => HoverProvider(),
                    child: HoverCard(
                      index: i,
                      onTap: contact.onTap, // ✅ fixed here
                      child: Center(
                        child: _ContactCardContent(contact: contact, index: i),
                      ),
                    ),
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

class _ContactCardContent extends StatelessWidget {
  final ContactModel contact;
  final int? index;
  const _ContactCardContent({required this.contact, this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hoverState = context.watch<HoverProvider>();
    final hovered = hoverState.isHovered(index ?? 0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          contact.icon,
          size: 4.w,
          color: hovered ? AppColors.accent : colorScheme.onSurface,
        ),
        SizedBox(height: 2.h),
        Text(
          contact.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: hovered ? AppColors.accent : colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          contact.subtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 12.sp,
            color: colorScheme.onSurface
                .withValues(alpha: 0.7), // ✅ FIXED: uses withValues
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
