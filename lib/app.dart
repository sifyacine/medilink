import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:midilink/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:midilink/utils/theme/theme.dart';

import 'features/personalization/controllers/settings_controller.dart';
import 'generated/l10n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.put(SettingsController()); // Initialize controller

    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: settingsController.selectedThemeMode.value,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      locale: Locale(settingsController.selectedLanguageCode.value),  // Dynamic locale
      fallbackLocale: Locale('en', 'US'),  // Default fallback locale
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('ar', 'AR'),
      ],
      home: const OnBoardingScreen(),
    ));
  }
}
