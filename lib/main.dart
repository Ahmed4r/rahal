import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:rahal/core/app_theme.dart';
import 'package:rahal/screens/navigation_bar.dart';

void main() {
  runApp(const Rahal());
}

class Rahal extends StatelessWidget {
  const Rahal({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rahal',

          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,

          scrollBehavior: const MaterialScrollBehavior().copyWith(
            overscroll: false,
          ),

          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1)),
              child: child!,
            );
          },

          home: child,
        );
      },
      child: const NavigationBarPage(),
    );
  }
}
