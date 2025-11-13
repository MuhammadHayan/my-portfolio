import 'package:flutter/material.dart';
import 'package:portfolio/views/home/mobile/mobile_navbar.dart';
import 'package:portfolio/views/sections/contact_section.dart';
import 'package:portfolio/views/sections/intro_section.dart';
import 'package:portfolio/views/sections/service_section.dart';
import 'package:portfolio/views/sections/works_section.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/theme/app_theme.dart';
import '../../../viewmodels/home_provider.dart';
import '../../../viewmodels/navbar_viewmodel.dart';
import 'web/web_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final NavBarViewModel navBarVM;

  @override
  void initState() {
    super.initState();
    navBarVM = NavBarViewModel();
    navBarVM.init(this); // safe: this is a TickerProvider
  }

  @override
  void dispose() {
    navBarVM.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final size = MediaQuery.of(context).size;
    final isMobile = Responsive.isMobile(context);

    final paddingX = Responsive.horizontalPadding(context);
    final sectionSpacing = size.height * 0.12;
    final footerSpacing = size.height * 0.02;

    final darkGradient =
        Theme.of(context).extension<DarkGradientTheme>()?.backgroundGradient;

    return ChangeNotifierProvider.value(
      value: navBarVM,
      child: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(context).brightness == Brightness.dark
              ? darkGradient
              : null,
          color: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).scaffoldBackgroundColor
              : null,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,

          // Mobile: AppBar
          appBar: isMobile
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: MobileNavBar(
                    onHome: homeProvider.scrollToTop,
                    onIntro: () => homeProvider.scrollToSection(0),
                    onServices: () => homeProvider.scrollToSection(1),
                    onWorks: () => homeProvider.scrollToSection(2),
                    onContact: () => homeProvider.scrollToSection(3),
                  ),
                )
              : null,

          drawer: isMobile
              ? MobileDrawer(
                  onHome: homeProvider.scrollToTop,
                  onIntro: () => homeProvider.scrollToSection(0),
                  onServices: () => homeProvider.scrollToSection(1),
                  onWorks: () => homeProvider.scrollToSection(2),
                  onContact: () => homeProvider.scrollToSection(3),
                )
              : null,

          body: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    // Desktop/Tablet NavBar (pass navBarVM so it's shared)
                    if (!isMobile)
                      NavBar(
                        navBarVM: navBarVM,
                        onHome: homeProvider.scrollToTop,
                        onIntro: () => homeProvider.scrollToSection(0),
                        onServices: () => homeProvider.scrollToSection(1),
                        onWorks: () => homeProvider.scrollToSection(2),
                        onContact: () => homeProvider.scrollToSection(3),
                      ),

                    // Scrollable content
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          // pass the shared navBarVM so it can check isManuallySelecting
                          homeProvider.updateCurrentSection(navBarVM);
                          return false;
                        },
                        child: SingleChildScrollView(
                          controller: homeProvider.scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: paddingX / 2.5),
                            child: Column(
                              children: [
                                IntroSection(key: homeProvider.sectionKeys[0]),
                                SizedBox(height: sectionSpacing),
                                ServiceSection(
                                    key: homeProvider.sectionKeys[1]),
                                SizedBox(height: sectionSpacing),
                                WorksSection(key: homeProvider.sectionKeys[2]),
                                SizedBox(height: sectionSpacing),
                                ContactSection(
                                    key: homeProvider.sectionKeys[3]),
                                SizedBox(height: footerSpacing),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: footerSpacing),
                                  child: Center(
                                    child: Text(
                                      "© All rights reserved — Hayan Muhammad",
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Floating scroll buttons
              Positioned(
                right: 5,
                bottom: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ScrollButton(
                      icon: Icons.keyboard_arrow_up_rounded,
                      onPressed: homeProvider.scrollToPrevious,
                      enabled: homeProvider.currentSection > 0,
                    ),
                    const SizedBox(height: 8),
                    _ScrollButton(
                      icon: Icons.keyboard_arrow_down_rounded,
                      onPressed: homeProvider.scrollToNext,
                      enabled: homeProvider.currentSection <
                          homeProvider.sectionKeys.length - 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScrollButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool enabled;

  const _ScrollButton({
    required this.icon,
    required this.onPressed,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black;

    // ✅ Updated: use withValues(alpha: …)
    final borderColor = iconColor.withValues(alpha: 0.5);
    final bgColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.05);

    return AnimatedOpacity(
      opacity: enabled ? 1 : 0.3,
      duration: const Duration(milliseconds: 250),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
            border: Border.all(color: borderColor),
          ),
          child: Icon(icon, color: iconColor, size: 26),
        ),
      ),
    );
  }
}
