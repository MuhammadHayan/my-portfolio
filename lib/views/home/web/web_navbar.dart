import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/viewmodels/navbar_viewmodel.dart';
import 'package:portfolio/viewmodels/theme_viewmodels.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NavBar extends StatelessWidget {
  final NavBarViewModel navBarVM;
  final VoidCallback? onHome;
  final VoidCallback? onIntro;
  final VoidCallback? onServices;
  final VoidCallback? onWorks;
  final VoidCallback? onContact;

  const NavBar({
    required this.navBarVM,
    this.onHome,
    this.onIntro,
    this.onServices,
    this.onWorks,
    this.onContact,
    super.key,
  });

  Widget _navButton(BuildContext context, String title, VoidCallback? onPressed,
      bool isSelected) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Start manual selection to prevent scroll feedback flicker
          navBarVM.startManualSelect();
          navBarVM.setCurrentIndex(
            ["Home", "Services", "Projects", "Contact"].indexOf(title),
          );

          // Trigger the scroll/navigation
          onPressed?.call();

          // Re-enable automatic updates shortly after (tune delay as needed)
          Future.delayed(const Duration(milliseconds: 600), () {
            navBarVM.endManualSelect();
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 0.4.h),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 0.3.h,
              width: isSelected ? 4.w : 0, // change width here
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: !isDark && isSelected ? Colors.black : null,
                gradient:
                    isDark && isSelected ? AppColors.accentGradient : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final double logoFontSize = isTablet ? 22 : 24;
    final double spacing = isTablet ? 24 : 50;

    // We rely on the provided navBarVM for animation and index state
    return ChangeNotifierProvider.value(
      value: navBarVM,
      child: Consumer2<NavBarViewModel, ThemeViewModel>(
        builder: (context, model, themeVM, _) {
          return SlideTransition(
            position: model.slideAnimation,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.horizontalPadding(context),
                vertical: 1.6.h,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surface
                    .withValues(alpha: 0.85),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(18),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final availableWidth = constraints.maxWidth;
                  final double logoSpacing = availableWidth > 1100
                      ? 400
                      : availableWidth > 900
                          ? 200
                          : 100;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: onHome,
                        child: Text(
                          "< Hayan />",
                          style: GoogleFonts.sacramento(
                            fontSize: logoFontSize,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      SizedBox(width: logoSpacing),
                      Flexible(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: spacing,
                          children: [
                            _navButton(context, "Home", onIntro,
                                model.currentIndex == 0),
                            _navButton(context, "Services", onServices,
                                model.currentIndex == 1),
                            _navButton(context, "Projects", onWorks,
                                model.currentIndex == 2),
                            _navButton(context, "Contact", onContact,
                                model.currentIndex == 3),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: themeVM.toggle,
                                child: Icon(
                                  themeVM.isDark
                                      ? Icons.light_mode_outlined
                                      : Icons.dark_mode_outlined,
                                  size: 28,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
