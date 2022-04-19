import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeViewModel extends ChangeNotifier {

  final Color _defaultThemeColor;

  DayNightType _currentType = DayNightType.followSystem;
  DayNightType get currentType => _currentType;

  late MaterialColor _currentAThemeColor = _convertColor2MaterialColor(_defaultThemeColor);
  late CupertinoDynamicColor _currentIThemeColor = _convertColor2CupertinoColor(_defaultThemeColor);

  ThemeViewModel(this._defaultThemeColor);

  /// change day-night type
  void changeType(DayNightType type) {
    _currentType = type;
    notifyListeners();
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
    _currentAThemeColor = _convertColor2MaterialColor(color);
    _currentIThemeColor = _convertColor2CupertinoColor(color);
    if (needNotifyListeners) {
      notifyListeners();
    }
  }

  /// get current [CupertinoThemeData] with custom color
  /// @param [bool] whether is Dark theme
  /// @return [CupertinoThemeData] for iOS platform
  CupertinoThemeData getCupertinoThemeData(bool isDark) {
    return CupertinoThemeData(
      brightness: isDark? Brightness.dark : Brightness.light,
      primaryColor: _currentIThemeColor,
      // reference: _CupertinoThemeDefaults@line: 19
      primaryContrastingColor: CupertinoColors.systemBackground
    );
  }

  /// get current [ThemeData] with custom color
  /// @param [bool] whether is Dark theme
  /// @return [ThemeData] for Android platform
  ThemeData getMaterialThemeData(bool isDark) {
    return ThemeData(
      brightness: isDark? Brightness.dark : Brightness.light,
      primaryColor: _currentAThemeColor,
      primarySwatch: _currentAThemeColor
    );
  }

  /// change color's brightness
  /// @param [Color]
  /// @param [value] brightness value. positive number means brighter, negative number means darker
  Color _changeBrightness(Color color, double value) {
    final HSLColor hslColor = HSLColor.fromColor(color);
    final double finalBrightnessValue = (hslColor.lightness + value > 1.0) ? 1.0 : (hslColor.lightness + value);
    final HSLColor resultColor = hslColor.withLightness(finalBrightnessValue);
    return resultColor.toColor();
  }

  /// convert given [Color] into [CupertinoDynamicColor]
  CupertinoDynamicColor _convertColor2CupertinoColor(Color color) {
    final Color light = _changeBrightness(color, 0.0);
    final Color dark = _changeBrightness(color, -0.1);
    return CupertinoDynamicColor(
        color: light,
        darkColor: dark,
        highContrastColor: light,
        darkHighContrastColor: dark,
        elevatedColor: light,
        darkElevatedColor: dark,
        highContrastElevatedColor: light,
        darkHighContrastElevatedColor: dark,
    );
  }

  /// convert given [Color] into [MaterialColor]
  /// with different level of brightness from 50 to 900
  /// @param [Color]
  /// @return [MaterialColor] can be used as [ThemeData.primaryColor] and [ThemeData.primarySwatch]
  MaterialColor _convertColor2MaterialColor(Color color) {
    final LinkedHashMap<int, Color> colorMap = LinkedHashMap();
    const List<int> levels = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
    const double brightnessLevel = 0.1;
    double changeValue = 0.5;

    for(int i in levels) {
      colorMap[i] = _changeBrightness(color, changeValue);
      changeValue -= brightnessLevel;
    }

    return MaterialColor(color.value, colorMap);
  }

}

enum DayNightType { light, night, followSystem }