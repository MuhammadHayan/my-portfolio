// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:portfolio/views/home/widgets/animated_button.dart';
import 'package:portfolio/views/home/widgets/profile_card.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/core/utils/download_helper.dart';
import 'package:portfolio/viewmodels/intro_animation_provider.dart';
import 'package:sizer/sizer.dart'; // ✅ Import sizer

class IntroSectionWeb extends StatefulWidget {
  const IntroSectionWeb({super.key});

  @override
  State<IntroSectionWeb> createState() => _IntroSectionWebState();
}

class _IntroSectionWebState extends State<IntroSectionWeb>
    with TickerProviderStateMixin {
  late IntroAnimationProvider introAnimation;

  @override
  void initState() {
    super.initState();
    introAnimation = IntroAnimationProvider();
    introAnimation.initAnimations(this);
  }

  @override
  void dispose() {
    introAnimation.disposeAnimations();
    super.dispose();
  }

  Future<void> _onDownload() async {
    final size = await DownloadHelper.downloadResume();
    final formatted = DownloadHelper.formatFileSize(size);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Resume downloaded ($formatted)"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ChangeNotifierProvider.value(
      value: introAnimation,
      child: Consumer<IntroAnimationProvider>(
        builder: (context, provider, _) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👇 Animated intro text section
              Expanded(
                flex: 7,
                child: SlideTransition(
                  position: provider.slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: provider.handController!,
                            builder: (context, child) {
                              final angle =
                                  0.5 * (provider.handController!.value - 0.5);
                              return Transform.rotate(
                                angle: angle,
                                alignment: Alignment.bottomCenter,
                                child: child,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: Text(
                                "👋 ",
                                style: textTheme.titleLarge?.copyWith(
                                  fontSize: 22.sp,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "Welcome to my space, where ideas meet design and code",
                              style: textTheme.titleLarge?.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 🧑‍💻 Name
                      Text(
                        "I'm Muhammad Hayan,",
                        style: textTheme.headlineMedium?.copyWith(
                          fontSize: 24.sp, // ✅ responsive name
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 1.h),

                      // 💼 Animated title
                      Text(
                        provider.displayedTitle,
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp, // ✅ responsive title
                        ),
                      ),

                      SizedBox(height: 1.h),

                      // 📝 Description
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 45.w),
                        child: Text(
                          "I craft high-quality Flutter applications that combine performance, scalability, and elegant design. "
                          "My focus is on creating seamless user experiences that turn complex ideas into intuitive, engaging digital products.",
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 14
                                .sp, // ✅ slightly larger and more professional
                            height:
                                1.7, // ✅ comfortable line spacing for readability
                          ),
                        ),
                      ),

                      SizedBox(height: 5.h),

                      // 📄 Button
                      AnimatedHoverButton(
                        icon: Icons.download_rounded, // ✅ Optional icon
                        label: "DOWNLOAD CV",
                        onPressed: _onDownload,
                      ),
                    ],
                  ),
                ),
              ),

              // 👇 Profile Card Section
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(top: 13.h),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ProfileCard(),
                      // SizedBox(height: 27.h),
                      // Text(
                      //   "Available for freelance & full-time work",
                      //   textAlign: TextAlign.center,
                      //   style: textTheme.bodySmall?.copyWith(
                      //     fontSize: 12.sp, // ✅ responsive note text
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
