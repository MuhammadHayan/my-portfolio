import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/viewmodels/theme_viewmodels.dart';
import 'package:provider/provider.dart';

class MobileNavBar extends StatelessWidget {
  final VoidCallback? onHome;
  final VoidCallback? onIntro;
  final VoidCallback? onServices;
  final VoidCallback? onWorks;
  final VoidCallback? onContact;

  const MobileNavBar({
    this.onHome,
    this.onIntro,
    this.onServices,
    this.onWorks,
    this.onContact,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isCompact = size.width < 360; // small phone like iPhone SE

    return AppBar(
      centerTitle: true,
      elevation: 4,
      backgroundColor:
          Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
      title: Text(
        "< Hayan />",
        style: GoogleFonts.sacramento(
          fontSize: isCompact ? 20 : 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class MobileDrawer extends StatelessWidget {
  final VoidCallback? onHome;
  final VoidCallback? onIntro;
  final VoidCallback? onServices;
  final VoidCallback? onWorks;
  final VoidCallback? onContact;

  const MobileDrawer({
    this.onHome,
    this.onIntro,
    this.onServices,
    this.onWorks,
    this.onContact,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    // Responsive scaling
    final paddingH = size.width * 0.05;
    final iconSize = size.width * 0.08;
    final fontSize = size.width * 0.045;

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.03,
          horizontal: paddingH,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Header / Logo
            Text(
              "< Hayan />",
              style: GoogleFonts.sacramento(
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const Divider(height: 30),

            // 🔹 Navigation Items with Icons
            _drawerItem(
              context,
              icon: Icons.home_outlined,
              title: "Home",
              onTap: onIntro,
              iconSize: iconSize,
              fontSize: fontSize,
            ),
            _drawerItem(
              context,
              icon: Icons.design_services_outlined,
              title: "Services",
              onTap: onServices,
              iconSize: iconSize,
              fontSize: fontSize,
            ),
            _drawerItem(
              context,
              icon: Icons.work_outline_rounded,
              title: "Projects",
              onTap: onWorks,
              iconSize: iconSize,
              fontSize: fontSize,
            ),
            _drawerItem(
              context,
              icon: Icons.mail_outline_rounded,
              title: "Contact",
              onTap: onContact,
              iconSize: iconSize,
              fontSize: fontSize,
            ),

            const Spacer(),

            // 🔹 iPhone-style theme toggle
            Consumer<ThemeViewModel>(
              builder: (context, themeVM, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          themeVM.isDark
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
                          color: colorScheme.onSurface,
                          size: iconSize,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          themeVM.isDark ? "Dark Mode" : "Light Mode",
                          style: TextStyle(
                            fontSize: fontSize,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: size.width < 380 ? 0.8 : 1.0,
                      child: CupertinoSwitch(
                        value: themeVM.isDark,
                        activeTrackColor: AppColors.accent,
                        inactiveTrackColor: Colors.grey.shade400,
                        onChanged: (_) {
                          Navigator.pop(context);
                          themeVM.toggle();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required double iconSize,
    required double fontSize,
    VoidCallback? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(icon, color: colorScheme.onSurface, size: iconSize),
      title: Text(
        title,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontSize: fontSize,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap?.call();
      },
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 10,
    );
  }
}
