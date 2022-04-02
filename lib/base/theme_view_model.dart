import 'dart:collection';

import 'package:flutter/material.dart';

class ThemeViewModel extends ChangeNotifier {

  final Color _defaultThemeColor;

  DayNightType _currentType = DayNightType.followSystem;
  late MaterialColor _currentThemeColor = _convertColor2MaterialColor(_defaultThemeColor);

  ThemeViewModel(this._defaultThemeColor);

  /// change day-night type
  void changeType(DayNightType type) {
    _currentType = type;
    notifyListeners();
  }

  /// @return [DayNightType] current day-night type
  DayNightType currentType() {
    return _currentType;
  }

  /// @return [ThemeMode] current theme mode
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

  /// change current theme color and notice app theme change
  /// @param [Color] color : color you want to change to
  /// @param [bool] needNotifyListeners: need to update to listener
  void changeThemeColor(Color color, bool needNotifyListeners) {
    _currentThemeColor = _convertColor2MaterialColor(color);
    if (needNotifyListeners) {
      notifyListeners();
    }
  }

  /// get current theme with custom color
  /// @param [bool] whether is Dark theme
  /// @return [ThemeData]
  ThemeData getThemeData(bool isDark) {
    return ThemeData(
      brightness: isDark? Brightness.dark : Brightness.light,
      primaryColor: _currentThemeColor,
      primarySwatch: _currentThemeColor
    );
  }

  /// convert given [Color] into [MaterialColor]
  /// with different level of brightness from 50 to 900
  /// @param [Color]
  /// @return [MaterialColor] can be used as [ThemeData.primaryColor] and [ThemeData.primarySwatch]
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