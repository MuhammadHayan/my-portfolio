import 'package:flutter/material.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:provider/provider.dart';

class HoverCard extends StatelessWidget {
  final Widget child;
  final double width;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final int? index; // added for identifying each hoverable card

  const HoverCard({
    super.key,
    required this.child,
    this.width = 260,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 16,
    this.onTap,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hoverState = context.watch<HoverProvider>();
    final hovered = hoverState.isHovered(index ?? 0);

    final borderColor = hovered
        ? colorScheme.primary.withOpacity(0.7)
        : colorScheme.primary.withOpacity(0.25);

    return MouseRegion(
      onEnter: (_) => hoverState.setHover(index ?? 0, true),
      onExit: (_) => hoverState.setHover(index ?? 0, false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        width: width,
        decoration: BoxDecoration(
          color: colorScheme.surface.withOpacity(isDark ? 0.4 : 1.0),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.15),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
