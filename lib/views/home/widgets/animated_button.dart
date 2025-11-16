import 'package:flutter/material.dart';
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

  const AnimatedHoverButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconSize = 17,
    this.padding,
    this.borderRadius = 5,
    this.width,
    this.height,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final primary = colorScheme.primary;

    final gradientColors = isDark
        ? [
            const Color(0xFF1E3A8A),
            primary.withValues(alpha: (0.9 * 255)),
            primary,
          ]
        : [
            const Color(0xFF3B82F6),
            primary.withValues(alpha: (0.8 * 255)),
            primary,
          ];

    final Color borderColor = isDark
        ? colorScheme.primary.withValues(alpha: (0.25 * 255))
        : Colors.black87;
    final Color textColor = isDark ? Colors.white : Colors.black;

    final double responsiveHeight = height ?? 60;
    final double responsiveWidth = width ?? 230;
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
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: provider.isHovered
                        ? null
                        : Border.all(color: borderColor, width: 0.5),
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
                              gradient: LinearGradient(
                                colors: gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
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
                          //  mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 10),
                            Text(
                              label,
                              style: TextStyle(
                                fontSize: responsiveFontSize,
                              ),
                            ),
                            const SizedBox(width: 10), // ✅ spacing
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
