import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final getStrorage = GetStorage();
  final storageKey = "isDarkMode";

  ThemeMode getThemeMode() {
    return isSaveDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isSaveDarkMode() {
    return getStrorage.read(storageKey) ?? false;
  }

  void saveThemeMode(bool isDarkMode) {
    getStrorage.write(storageKey, isDarkMode);
  }

  void changeThemeMode() {
    Get.changeThemeMode(isSaveDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isSaveDarkMode());
  }
}
