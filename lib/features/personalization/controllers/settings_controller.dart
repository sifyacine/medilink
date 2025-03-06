import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  var selectedLanguageCode = 'en_US'.obs;  // Default to English
  var selectedThemeMode = ThemeMode.system.obs; // Default to follow system theme

  @override
  void onInit() {
    super.onInit();
    _loadSettings(); // Load settings from storage on initialization
  }

  void updateLanguage(String languageCode) async {
    selectedLanguageCode.value = languageCode;
    Get.updateLocale(Locale(languageCode.split('_').first, languageCode.split('_').last));
    _saveSettings(); // Save settings
  }

  void updateThemeMode(ThemeMode mode) async {
    selectedThemeMode.value = mode;
    _saveSettings(); // Save settings
  }

  Future<void> _loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Load language code
    final languageCode = prefs.getString('languageCode') ?? 'en_US';
    selectedLanguageCode.value = languageCode;
    Get.updateLocale(Locale(languageCode.split('_').first, languageCode.split('_').last));

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
}
