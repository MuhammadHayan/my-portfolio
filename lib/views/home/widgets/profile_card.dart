// lib/views/shared/profile_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final size = MediaQuery.of(context).size;
    final base = size.width;

    // Responsive profile image size (10–20% of width)
    final targetSize = base < 600
        ? base * 0.35
        : base < 1024
            ? base * 0.22
            : base * 0.18;

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
                              AppColors.accent.withOpacity(0.9),
                              AppColors.accent.withOpacity(0.4),
                              AppColors.accent.withOpacity(0.9),
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
