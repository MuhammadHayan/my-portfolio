import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HoverCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final int? index;
  final double border;

  const HoverCard({
    super.key,
    required this.child,
    this.width = 22,
    this.height = 280,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.borderRadius = 15,
    this.border = 0.5,
    this.onTap,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hoverState = context.watch<HoverProvider>();
    final hovered = hoverState.isHovered(index ?? 0);

    final borderColor = hovered
        ? (isDark ? AppColors.accent : Theme.of(context).colorScheme.primary)
            .withValues(alpha: 0.7)
        : isDark
            ? AppColors.accent.withValues(alpha: 0.25)
            : Colors.black.withValues(alpha: 0.25);

    final surfaceColor = Theme.of(context).colorScheme.surface;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => hoverState.setHover(index ?? 0, true),
      onExit: (_) => hoverState.setHover(index ?? 0, false),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          width: width.w,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: isDark ? surfaceColor : null, // solid for dark theme
            gradient: isDark
                ? null
                : AppColors.cardlightGradient, // gradient for light theme
            borderRadius: BorderRadius.circular(borderRadius),
            border:
                Border.all(color: borderColor, width: hovered ? 1.5 : border),
            boxShadow: hovered
                ? [
                    BoxShadow(
                      color: isDark
                          ? AppColors.accent.withValues(alpha: 0.4)
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.35),
                      blurRadius: 28,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: child,
        ),
      ),
    );
  }
}
