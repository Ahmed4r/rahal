import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:liquid_glass_widgets/liquid_glass_setup.dart';
import 'package:provider/provider.dart';
import 'package:rahal/core/app_theme.dart';
import 'package:rahal/screens/navigation_bar.dart';
import 'package:rahal/screens/settings/provider/setting_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize liquid glass widgets to prevent white flash
  await LiquidGlassWidgets.initialize();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SettingsProvider())],
      child: LiquidGlassWidgets.wrap(child: Rahal()),
    ),
  );
}

class Rahal extends StatelessWidget {
  const Rahal({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer<SettingsProvider>(
          builder: (context, settingsProvider, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Rahal',

              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: settingsProvider.currentThemeMode,

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

              home: const NavigationBarPage(),
            );
          },
        );
      },
    );
  }
}
