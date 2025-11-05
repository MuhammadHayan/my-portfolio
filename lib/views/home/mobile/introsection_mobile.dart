import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/download_helper_stub.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/viewmodels/intro_animation_provider.dart';
import 'package:portfolio/views/home/widgets/animated_button.dart';
import 'package:portfolio/views/home/widgets/profile_card.dart';
import 'package:provider/provider.dart';

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
    await downloadAsset('assets/files/hayan_cv.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final paddingX = Responsive.horizontalPadding(context);
    final paddingY = Responsive.verticalPadding(context);
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingX, vertical: paddingY),
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
                  SizedBox(height: paddingY * 0.7),
                  Text(
                    "I'm Hayan Muhammad",
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: paddingY * 0.2),
                  Text(
                    provider.displayedTitle,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: paddingY * 0.4),
                  Text(
                    "I build clean, maintainable Flutter apps with a focus on performance and UX. "
                    "I enjoy turning complex ideas into delightful mobile experiences.",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(height: 1.6),
                  ),
                  SizedBox(height: paddingY * 0.6),
                  AnimatedHoverButton(
                    label: "Download CV",
                    onPressed: _onDownload,
                    fontSize: size.width * 0.025,
                  ),
                  SizedBox(height: paddingY * 2),
                  Text(
                    "Available for freelance & full-time work.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
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
