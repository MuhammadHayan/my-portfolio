import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/viewmodels/intro_animation_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart'; // Import Sizer

class AnimatedHoverButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon; // ✅ New optional icon
  final double iconSize; // ✅ Icon size for responsiveness
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double fontSize;
  final double? width;
  final double? height;
  final double border;

  const AnimatedHoverButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.icon,
      this.iconSize = 15,
      this.padding,
      this.borderRadius = 5,
      this.width,
      this.height,
      this.fontSize = 14,
      this.border = 0.5});

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;

    final theme = Theme.of(context);
    // final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    // final Color borderColor = isDark
    //     ? colorScheme.primary.withValues(alpha: (0.25 * 255))
    //     : Colors.black87;
    final Color textColor = isDark ? Colors.white : Colors.black;

    final double responsiveHeight = height ?? 10.h;
    final double responsiveWidth = width ?? 18.w;
    final double responsiveFontSize = fontSize.sp;
    final double responsiveIconSize = iconSize.sp;

    return Consumer<IntroAnimationProvider>(
      builder: (context, provider, _) {
        return MouseRegion(
          onEnter: (_) => provider.onHover(true),
          onExit: (_) => provider.onHover(false),
          child: AnimatedBuilder(
            animation: provider.hoverController!,
            builder: (context, _) {
              return Transform.scale(
                scale: provider.scale,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  height: responsiveHeight,
                  width: responsiveWidth,
                  decoration: BoxDecoration(
                    color: isDark ? surfaceColor : null, // solid for dark theme
                    gradient: isDark
                        ? null
                        : AppColors
                            .cardlightGradient, // gradient for light theme,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: null,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: Offset(1, 1),
                      )
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // ✅ Gradient fill background
                      Positioned.fill(
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: provider.fillProgress,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(borderRadius - 1.5),
                                gradient: AppColors.buttonGradient),
                          ),
                        ),
                      ),

                      // ✅ Text + optional icon row
                      TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.transparent),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            provider.isHovered ? Colors.white : textColor,
                          ),
                        ),
                        onPressed: onPressed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 1.w),
                            Text(
                              label,
                              style: TextStyle(
                                fontSize: responsiveFontSize,
                              ),
                            ),
                            SizedBox(width: 1.w), // ✅ spacing
                            if (icon != null) ...[
                              Icon(
                                icon,
                                size: responsiveIconSize,
                                color: provider.isHovered
                                    ? Colors.white
                                    : textColor,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
