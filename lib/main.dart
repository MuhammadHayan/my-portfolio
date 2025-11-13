import 'package:flutter/material.dart';
import 'package:portfolio/viewmodels/contact_viewmodel.dart';
import 'package:portfolio/viewmodels/home_provider.dart';
import 'package:portfolio/viewmodels/hover_provider.dart';
import 'package:portfolio/viewmodels/intro_animation_provider.dart';
import 'package:portfolio/viewmodels/work_viewmodel.dart';
import 'package:portfolio/viewmodels/service_viewmodel.dart';
import 'package:portfolio/viewmodels/theme_viewmodels.dart';
import 'package:portfolio/views/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ServiceViewModel()),
        ChangeNotifierProvider(create: (_) => ProjectViewModel()),
        ChangeNotifierProvider(create: (_) => ContactViewModel()),
        ChangeNotifierProvider(create: (_) => IntroAnimationProvider()),
        ChangeNotifierProvider(create: (_) => HoverProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = context.watch<ThemeViewModel>();
    return Sizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Hayan's Portfolio",
        themeMode: themeVM.isDark ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const HomeScreen(),
      );
    });
  }
}
