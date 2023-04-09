import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';

final themeProvider =
    ChangeNotifierProvider<ThemeManager>((ref) => ThemeManager());

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // ThemeData
  Color get iconColor => isDark ? AppColors().offWhite : AppColors().black;
  Color get labelColor => isDark ? Colors.white70 : AppColors().body;
  Color get bgColor => isDark ? AppColors().black : AppColors().offWhite;
  Color get fgColor => isDark ? AppColors().offWhite : AppColors().body;
}
