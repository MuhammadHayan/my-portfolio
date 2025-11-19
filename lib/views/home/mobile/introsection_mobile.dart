// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/download_helper.dart';
import 'package:portfolio/viewmodels/intro_animation_provider.dart';
import 'package:portfolio/views/home/widgets/animated_button.dart';
import 'package:portfolio/views/home/widgets/profile_card.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class IntroSectionMobile extends StatefulWidget {
  const IntroSectionMobile({super.key});

  @override
  State<IntroSectionMobile> createState() => _IntroSectionMobileState();
}

class _IntroSectionMobileState extends State<IntroSectionMobile>
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

    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: ChangeNotifierProvider.value(
        value: introAnimation,
        child: Consumer<IntroAnimationProvider>(
          builder: (context, provider, _) {
            return SlideTransition(
              position: provider.slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileCard(),
                  SizedBox(height: 4.h),
                  Text(
                    "I'm Muhammad Hayan",
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 21.sp,
                    ),
                  ),
                  SizedBox(height: 1.2.h),
                  Text(
                    provider.displayedTitle,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 19.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "I craft high-quality Flutter applications that combine performance, scalability, and elegant design. "
                    "My focus is on creating seamless user experiences that turn complex ideas into intuitive, engaging digital products.",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      //  height: 1.6,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  AnimatedHoverButton(
                    borderRadius: 10,
                    border: 1,
                    iconSize: 5.w,
                    icon: Icons.download_rounded,
                    width: 48.w,
                    height: 6.h,
                    label: "DOWNLOAD CV",
                    onPressed: _onDownload,
                    fontSize: 16,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Available for freelance & full-time work",
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(fontSize: 15.sp),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
