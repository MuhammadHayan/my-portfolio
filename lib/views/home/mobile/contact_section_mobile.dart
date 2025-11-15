import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/data/contact_model.dart';
import 'package:portfolio/viewmodels/contact_viewmodel.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:portfolio/views/home/widgets/animated_card.dart';
import 'package:portfolio/views/home/widgets/hover_card.dart';
import 'package:portfolio/views/home/widgets/section_tile.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactSectionMobile extends StatelessWidget {
  const ContactSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final contactVM = context.watch<ContactViewModel>();
    final contacts = contactVM.contacts;
    final visible = contactVM.visible;

    return VisibilityDetector(
      key: const Key('contact-section-mobile'),
      onVisibilityChanged: (info) =>
          contactVM.onVisibilityChanged(info.visibleFraction),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SectionTitle(padding: 3.w, title: "Get in Touch"),
            const SizedBox(height: 10),
            Text(
              "I’m open to collaborations, freelance projects, or tech discussions. Reach out through any platform below!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: (0.7 * 255)),
                    fontSize: 14.sp,
                  ),
            ),
            const SizedBox(height: 20),

            /// 🔹 Animated Grid of Contact Cards
            LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  runSpacing: 5,
                  children: List.generate(contacts.length, (i) {
                    final contact = contacts[i];
                    return SizedBox(
                      height: 110,
                      width: 120,
                      child: AnimatedCard(
                        index: i,
                        visible: visible,
                        child: ChangeNotifierProvider(
                          create: (_) => HoverProvider(),
                          child: HoverCard(
                            borderRadius: 10,
                            index: i,
                            onTap: contact.onTap,
                            child: _ContactCardContent(
                              contact: contact,
                              index: i,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            contact.icon,
            size: 33,
            color: hovered ? AppColors.accent : colorScheme.onSurface,
          ),
          const SizedBox(height: 5),
          Text(
            contact.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: hovered ? AppColors.accent : colorScheme.onSurface,
              fontSize: 14.sp,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            contact.subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: (0.7 * 255)),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
