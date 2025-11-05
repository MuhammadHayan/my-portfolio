import 'package:flutter/material.dart';
import 'package:portfolio/data/contact_model.dart';
import 'package:portfolio/viewmodels/contact_viewmodel.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:portfolio/views/home/widgets/animated_card.dart';
import 'package:portfolio/views/home/widgets/hover_card.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactSectionMobile extends StatelessWidget {
  const ContactSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final contactVM = context.watch<ContactViewModel>();
    final contacts = contactVM.contacts;
    final visible = contactVM.visible;
    final size = MediaQuery.of(context).size;

    // Responsive layout: 2 per row (or 1 per row for very small screens)
    final isNarrow = size.width < 380;
    final crossAxisCount = isNarrow ? 1 : 2;
    final cardWidth = (size.width / crossAxisCount) - 100;

    return VisibilityDetector(
      key: const Key('contact-section-mobile'),
      onVisibilityChanged: (info) =>
          contactVM.onVisibilityChanged(info.visibleFraction),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Get in Touch",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "I’m open to collaborations, freelance projects, or tech discussions.\nReach out through any platform below!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 36),

            /// 🔹 Animated Grid of Contact Cards (2 per row)
            LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(contacts.length, (i) {
                    final contact = contacts[i];
                    return AnimatedCard(
                      index: i,
                      visible: visible,
                      child: ChangeNotifierProvider(
                        create: (_) => HoverProvider(),
                        child: HoverCard(
                          width: cardWidth,
                          index: i,
                          onTap: contact.onTap,
                          child: _ContactCardContent(contact: contact),
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
  const _ContactCardContent({required this.contact});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
        horizontal: size.width * 0.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(contact.icon, size: 25, color: colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            contact.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
                fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            contact.subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7), fontSize: 12
                //  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}
