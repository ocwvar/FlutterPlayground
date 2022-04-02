import 'dart:collection';

import 'package:flutter/material.dart';

class ThemeViewModel extends ChangeNotifier {

  DayNightType _currentType = DayNightType.followSystem;
  late MaterialColor _currentThemeColor;

  void changeType(DayNightType type) {
    _currentType = type;
    notifyListeners();
  }

  DayNightType currentType() {
    return _currentType;
  }

  ThemeMode currentMode() {
    switch(_currentType) {
      case DayNightType.light:
        return ThemeMode.light;

      case DayNightType.night:
        return ThemeMode.dark;

      case DayNightType.followSystem:
        return ThemeMode.system;
    }
  }

  MaterialColor currentThemeColor() {
    return _currentThemeColor;
  }

  void changeThemeColor(Color color, bool needNotifyListeners) {
    _currentThemeColor = _convertColor2MaterialColor(color);
    if (needNotifyListeners) {
      notifyListeners();
    }
  }

  MaterialColor _convertColor2MaterialColor(Color color) {
    Color changeBrightness(Color color, double value) {
      final HSLColor hslColor = HSLColor.fromColor(color);
      final double finalBrightnessValue = (hslColor.lightness + value > 1.0) ? 1.0 : (hslColor.lightness + value);
      final HSLColor resultColor = hslColor.withLightness(finalBrightnessValue);
      return resultColor.toColor();
    }

    final LinkedHashMap<int, Color> colorMap = LinkedHashMap();
    const List<int> levels = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
    const double brightnessLevel = 0.1;
    double changeValue = 0.5;

    for(int i in levels) {
      colorMap[i] = changeBrightness(color, changeValue);
      changeValue -= brightnessLevel;
    }

    return MaterialColor(color.value, colorMap);
  }

}

enum DayNightType { light, night, followSystem }