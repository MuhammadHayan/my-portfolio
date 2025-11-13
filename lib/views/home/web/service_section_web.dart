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
import 'package:sizer/sizer.dart'; // ✅ Added Sizer import

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

          /// 🔹 Services Grid
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 1.w, // ✅ Responsive spacing
            runSpacing: 1.w,
            children: List.generate(services.length, (i) {
              final service = services[i];
              final visible = serviceVM.visible;

              return SizedBox(
                height: 265,
                width: 20.w,
                child: AnimatedCard(
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
    final colorScheme = Theme.of(context).colorScheme;
    final hoverState = context.watch<HoverProvider>();
    final hovered = hoverState.isHovered(index ?? 0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            service.icon,
            size: 4.w, // ✅ Responsive icon size
            color: hovered ? AppColors.accent : colorScheme.onSurface,
          ),
          SizedBox(height: 2.h),

          // 🧩 Title
          Text(
            service.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 13.sp, // ✅ Responsive title text
                  fontWeight: FontWeight.w600,
                  color: hovered ? AppColors.accent : colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 1.5.h),

          // 📝 Description
          Text(
            service.description,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12.sp, // ✅ Responsive body text
                  color: colorScheme.onSurface
                      .withValues(alpha: 0.7), // ✅ fixed deprecated
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}
