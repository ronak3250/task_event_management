import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ThemeController extends GetxController {
  // Observable theme mode
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  // Toggle between light and dark themes
  void toggleTheme(bool isDarkMode) {
    themeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    update(); // Notify listeners
  }

  // Check if the current theme is dark
  bool get isDarkMode => themeMode.value == ThemeMode.dark;
}