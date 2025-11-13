import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final double? padding;

  const SectionTitle({super.key, required this.title, this.padding});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // ✅ Divider color with modern API
    final dividerColor = theme.brightness == Brightness.dark
        ? colorScheme.primary.withValues(alpha: (0.6 * 255))
        : Colors.black.withValues(alpha: (0.4 * 255));

    // ✅ Responsive sizing
    final double fontSize = 18.sp;
    final double horizontalPadding = padding ?? 8.6.w;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              color: dividerColor,
              thickness: 0.5,
              endIndent: 3.w,
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
              color: dividerColor,
              thickness: 0.5,
              indent: 3.w,
            ),
          ),
        ],
      ),
    );
  }
}
