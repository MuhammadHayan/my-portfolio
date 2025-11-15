// lib/views/shared/profile_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart'; // for responsive sizing
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/viewmodels/profile_animation_provider.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => ProfileCardState();
}

class ProfileCardState extends State<ProfileCard>
    with SingleTickerProviderStateMixin {
  late ProfileAnimationProvider animationProvider;

  @override
  void initState() {
    super.initState();
    animationProvider = ProfileAnimationProvider();
    animationProvider.init(this);
  }

  @override
  void dispose() {
    animationProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Use Sizer instead of manual MediaQuery
    // Profile image takes up 35% of screen width on small, 22% on medium, 18% on large screens
    double targetSize = 0;
    if (100.w < 60.h) {
      targetSize = 45.w; // small screens
    } else if (100.w < 100.h) {
      targetSize = 45.w; // medium screens
    } else {
      targetSize = 18.w; // large screens
    }

    return ChangeNotifierProvider.value(
      value: animationProvider,
      child: Consumer<ProfileAnimationProvider>(
        builder: (context, provider, _) {
          final controller = provider.controller;
          if (controller == null) return const SizedBox();

          return AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final radius = provider.radius?.value ?? 1.0;
              final opacity = provider.opacity?.value ?? 1.0;
              final borderWidth = provider.borderWidth?.value ?? 2.0;

              return Stack(
                alignment: Alignment.center,
                children: [
                  // 🌈 Animated Glow Ring
                  Transform.scale(
                    scale: radius,
                    child: Opacity(
                      opacity: opacity,
                      child: Container(
                        width: targetSize,
                        height: targetSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              // ✅ Replace deprecated withOpacity → withValues
                              AppColors.accent.withValues(alpha: (0.9 * 255)),
                              AppColors.accent.withValues(alpha: (0.4 * 255)),
                              AppColors.accent.withValues(alpha: (0.9 * 255)),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                          border: Border.all(
                            width: borderWidth,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 👤 Profile Image
                  ClipOval(
                    child: Image.asset(
                      'assets/images/profile.jpg',
                      width: targetSize,
                      height: targetSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
