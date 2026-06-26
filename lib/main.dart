import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
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
          theme: ThemeData(
            splashFactory: InkSplash.splashFactory,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          home: child,
        );
      },
      child: NavigationBarPage(),
    );
  }
}
