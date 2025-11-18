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
import 'package:sizer/sizer.dart';

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
          const SectionTitle(title: "What I Do"),
          SizedBox(height: 5.h),

          /// Services Grid
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: List.generate(services.length, (i) {
              final service = services[i];
              final visible = serviceVM.visible;

              return AnimatedCard(
                index: i,
                visible: visible,
                child: ChangeNotifierProvider(
                  create: (_) => HoverProvider(),
                  child: HoverCard(
                    width: 20,
                    index: i,
                    onTap: () {},
                    child: _ServiceCardContent(
                      service: service,
                      index: i,
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

class _ServiceCardContent extends StatelessWidget {
  final ServiceModel service;
  final int? index;

  const _ServiceCardContent({required this.service, this.index});

  @override
  Widget build(BuildContext context) {
    final hoverState = context.watch<HoverProvider>();
    final hovered = hoverState.isHovered(index ?? 0);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          service.icon,
          size: 4.w,
          color: hovered ? AppColors.accent : colorScheme.onSurface,
        ),
        SizedBox(height: 2.h),
        Text(
          service.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: hovered ? AppColors.accent : colorScheme.onSurface,
              ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.5.h),
        Text(
          service.description,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12.sp,
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
        ),
      ],
    );
  }
}
