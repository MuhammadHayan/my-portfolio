import 'package:flutter/material.dart';
import 'package:portfolio/views/home/widgets/animated_button.dart';
import 'package:portfolio/views/home/widgets/profile_card.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/core/utils/download_helper_web.dart';
import 'package:portfolio/viewmodels/intro_animation_provider.dart';
import '../../../core/utils/responsive.dart';

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
    await downloadAsset('assets/files/hayan_cv.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final paddingY = Responsive.verticalPadding(context);

    return ChangeNotifierProvider.value(
      value: introAnimation,
      child: Consumer<IntroAnimationProvider>(
        builder: (context, provider, _) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 👇 SlideTransition ONLY for the text column
                  Expanded(
                    flex: 7,
                    child: SlideTransition(
                      position: provider.slideAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Hi there, welcome to my space ",
                                  style: textTheme.titleLarge?.copyWith(
                                    fontSize: size.width * 0.02,
                                    fontWeight: FontWeight.normal, // unbolded
                                  ),
                                ),
                              ),
                              AnimatedBuilder(
                                animation: provider.handController!,
                                builder: (context, child) {
                                  final angle = 0.5 *
                                      (provider.handController!.value - 0.5);
                                  return Transform.rotate(
                                    angle: angle,
                                    alignment: Alignment.bottomCenter,
                                    child: child,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    " 👋",
                                    style: textTheme.titleLarge?.copyWith(
                                      fontSize: size.width * 0.03,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "I'm Hayan Muhammad,",
                            style: textTheme.headlineMedium?.copyWith(
                              fontSize: size.width * 0.040,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: paddingY * 0.1),
                          Text(
                            provider.displayedTitle,
                            style: textTheme.titleLarge?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.03,
                            ),
                          ),
                          SizedBox(height: paddingY * 0.3),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: size.width * 0.44),
                            child: Text(
                              "I build clean, maintainable Flutter apps with a focus on performance and UX. "
                              "I enjoy turning complex ideas into delightful mobile experiences.",
                              style: textTheme.bodyLarge?.copyWith(
                                  fontSize: size.width * 0.014, height: 1.6),
                            ),
                          ),
                          SizedBox(height: paddingY * 0.5),
                          AnimatedHoverButton(
                            label: "Download CV",
                            onPressed: _onDownload,
                            fontSize: size.width * 0.013,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 👇 Static Profile Card (no animation)
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const ProfileCard(),
                          SizedBox(height: paddingY * 2.1),
                          Text(
                            "Available for freelance & full-time work",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
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
