import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/data/service_model.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:portfolio/viewmodels/service_viewmodel.dart';
import 'package:portfolio/views/home/widgets/animated_card.dart';
import 'package:portfolio/views/home/widgets/hover_card.dart';
import 'package:portfolio/views/home/widgets/section_tile.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ServiceSectionWeb extends StatelessWidget {
  const ServiceSectionWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceVM = context.watch<ServiceViewModel>();
    final services = serviceVM.services;

    return VisibilityDetector(
      key: const Key('service-section'),
      onVisibilityChanged: (info) =>
          serviceVM.onVisibilityChanged(info.visibleFraction),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(title: "What i do"),
          const SizedBox(height: 60),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 40,
            runSpacing: 40,
            children: List.generate(services.length, (i) {
              final service = services[i];
              final visible = serviceVM.visible;
              return AnimatedCard(
                index: i,
                visible: visible,
                child: ChangeNotifierProvider(
                  create: (_) => HoverProvider(),
                  child: HoverCard(
                    index: i,
                    onTap: () {},
                    child: _ServiceCardContent(service: service, index: i),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

class _ServiceCardContent extends StatelessWidget {
  final ServiceModel service;
  final int? index;
  const _ServiceCardContent({required this.service, this.index});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hoverState = context.watch<HoverProvider>();
    final hovered = hoverState.isHovered(index ?? 0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(service.icon,
            size: 40,
            color: hovered
                ? AppColors.accent
                : Theme.of(context).colorScheme.onSurface),
        const SizedBox(height: 16),
        Text(
          service.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: hovered ? AppColors.accent : colorScheme.onSurface,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          service.description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
                height: 1.5,
              ),
        ),
      ],
    );
  }
}
