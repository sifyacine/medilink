import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  var selectedLanguageCode = 'en_US'.obs; // Default to English
  var selectedThemeMode = ThemeMode.system.obs; // Default to follow system theme

  @override
  void onInit() {
    super.onInit();
    _loadSettings(); // Load settings from storage on initialization
  }

  Future<void> updateLanguage(String languageCode) async {
    selectedLanguageCode.value = languageCode;
    final parts = languageCode.split('_');
    Get.updateLocale(Locale(parts.first, parts.last));
    await _saveSettings(); // Save settings
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    selectedThemeMode.value = mode;
    await _saveSettings(); // Save settings
  }

  Future<void> _loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Load language code
    final languageCode = prefs.getString('languageCode') ?? 'en_US';
    selectedLanguageCode.value = languageCode;
    final parts = languageCode.split('_');
    Get.updateLocale(Locale(parts.first, parts.last));

    // Load theme mode
    final themeIndex = prefs.getInt('themeMode') ?? ThemeMode.system.index;
    selectedThemeMode.value = ThemeMode.values[themeIndex];
  }

  Future<void> _saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save language code
    await prefs.setString('languageCode', selectedLanguageCode.value);

    // Save theme mode
    await prefs.setInt('themeMode', selectedThemeMode.value.index);
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              onTap: () {
                updateLanguage('en_US');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('French'),
              onTap: () {
                updateLanguage('fr_FR');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Arabic'),
              onTap: () {
                updateLanguage('ar_AR');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showThemeModeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Follow System'),
              onTap: () {
                updateThemeMode(ThemeMode.system);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Dark Mode'),
              onTap: () {
                updateThemeMode(ThemeMode.dark);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Light Mode'),
              onTap: () {
                updateThemeMode(ThemeMode.light);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
