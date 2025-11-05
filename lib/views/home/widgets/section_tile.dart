import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final Color? dividerColor;
  final double fontSize;
  final double thickness;

  const SectionTitle({
    super.key,
    required this.title,
    this.dividerColor,
    this.fontSize = 36,
    this.thickness = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final dividerClr = dividerColor ??
        (theme.brightness == Brightness.dark
            ? colorScheme.primary.withOpacity(0.6)
            : Colors.black.withOpacity(0.4));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              color: dividerClr,
              thickness: thickness,
              endIndent: 25,
            ),
          ),
          Text(
            title,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              color: colorScheme.onSurface,
            ),
          ),
          Expanded(
            child: Divider(
              color: dividerClr,
              thickness: thickness,
              indent: 25,
            ),
          ),
        ],
      ),
    );
  }
}
