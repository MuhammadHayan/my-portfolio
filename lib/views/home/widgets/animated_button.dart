import 'package:flutter/material.dart';
import 'package:portfolio/viewmodels/intro_animation_provider.dart';
import 'package:provider/provider.dart';

class AnimatedHoverButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double fontSize;

  const AnimatedHoverButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.padding,
    this.borderRadius = 5,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;
    final isDark = brightness == Brightness.dark;
    final primary = colorScheme.primary;

    // Mix blue and current theme accent
    final gradientColors = isDark
        ? [
            const Color(0xFF1E3A8A), // Deep blue (Tailwind blue-800)
            primary.withOpacity(0.9),
            primary,
          ]
        : [
            const Color(0xFF3B82F6), // Bright blue (Tailwind blue-500)
            primary.withOpacity(0.8),
            primary,
          ];

    // Theme-based text and border colors
    final Color borderColor = isDark ? Colors.white : Colors.black;
    final Color textColor = isDark ? Colors.white : Colors.black;

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
                  height: 50,
                  width: 200,
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
                      // Gradient fill layer (slightly inset for visible border)
                      Positioned.fill(
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: provider.fillProgress,
                          child: Container(
                            margin: const EdgeInsets.all(1),
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

                      // Text button
                      TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.transparent),
                          padding: WidgetStateProperty.all(
                            padding ??
                                const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                          ),
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
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Border overlay (stays visible above gradient)
                      IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            border: Border.all(color: borderColor, width: 1),
                          ),
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
