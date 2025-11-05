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

class ContactWeb extends StatelessWidget {
  const ContactWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final contactVM = context.watch<ContactViewModel>();
    final contacts = contactVM.contacts;
    final visible = contactVM.visible;

    return VisibilityDetector(
      key: const Key('contact-section'),
      onVisibilityChanged: (info) =>
          contactVM.onVisibilityChanged(info.visibleFraction),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(title: "Get in Touch"),
          const SizedBox(height: 24),
          Text(
            "I’m open to collaborations, freelance projects, or tech discussions.\nReach out through any of the platforms below!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 50),

          /// 🔹 Contact Cards Grid
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: List.generate(contacts.length, (i) {
                final contact = contacts[i];
                return AnimatedCard(
                  index: i,
                  visible: visible,
                  child: ChangeNotifierProvider(
                    create: (_) => HoverProvider(),
                    child: HoverCard(
                      width: 200,
                      index: i,
                      onTap: () {},
                      child: _ContactCardContent(contact: contact, index: i),
                    ),
                  ),
                );
              }),
            ),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(contact.icon,
            size: 36,
            color: hovered
                ? AppColors.accent
                : Theme.of(context).colorScheme.onSurface),
        const SizedBox(height: 16),
        Text(
          contact.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: hovered ? AppColors.accent : colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          contact.subtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.7),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
