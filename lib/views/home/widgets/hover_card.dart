import 'package:flutter/material.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart'; // for responsive sizing

class HoverCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final VoidCallback? onTap;
  final int? index; // for identifying each hoverable card

  const HoverCard({
    super.key,
    required this.child,
    this.width,
    this.padding,
    this.borderRadius,
    this.onTap,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hoverState = context.watch<HoverProvider>();
    final hovered = hoverState.isHovered(index ?? 0);

    // ✅ Fixed deprecated withOpacity → withValues(alpha: ...)
    final borderColor = hovered
        ? colorScheme.primary.withValues(alpha: (0.7 * 255))
        : isDark
            ? colorScheme.primary.withValues(alpha: (0.25 * 255))
            : Colors.black.withValues(alpha: (0.25 * 255));

    final surfaceColor = isDark
        ? colorScheme.surface.withValues(alpha: (0.4 * 255))
        : colorScheme.surface.withValues(alpha: (1.0 * 255));

    // ✅ Responsive defaults using Sizer
    final responsiveWidth = width ?? 20.w; // default: 60% of screen width
    final responsivePadding = padding ?? EdgeInsets.all(1.w);
    final responsiveBorderRadius = borderRadius ?? 15;

    return MouseRegion(
      onEnter: (_) => hoverState.setHover(index ?? 0, true),
      onExit: (_) => hoverState.setHover(index ?? 0, false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        width: responsiveWidth,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(responsiveBorderRadius),
          border: Border.all(color: borderColor, width: hovered ? 1.5 : 0.5),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: (0.15 * 255)),
                    blurRadius: hovered ? 1.5.h : 0,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(responsiveBorderRadius),
          onTap: onTap,
          child: Padding(
            padding: responsivePadding,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
