import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/base/theme_view_model.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformApp extends BasePlatformWidget<MaterialApp, CupertinoApp> {

  // Android items
  final ThemeData androidLightTheme;
  final ThemeData androidDarkTheme;

  // iOS items
  final CupertinoThemeData iOSTheme;

  // General items
  final DayNightType dayNightType;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;
  final Widget home;

  const PlatformApp({Key? key,
    required this.androidLightTheme,
    required this.androidDarkTheme,
    required this.dayNightType,
    required this.iOSTheme,
    required this.localizationsDelegates,
    required this.supportedLocales,
    required this.home
  }) : super(key: key);

  /// @return [ThemeMode] current theme mode
  ThemeMode _androidCurrentMode() {
    switch(dayNightType) {
      case DayNightType.light:
        return ThemeMode.light;

      case DayNightType.night:
        return ThemeMode.dark;

      case DayNightType.followSystem:
        return ThemeMode.system;
    }
  }

  @override
  MaterialApp createAndroidObject(BuildContext arg) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      theme: androidLightTheme,
      darkTheme: androidDarkTheme,
      themeMode: _androidCurrentMode(),
      home: home,
    );
  }

  @override
  CupertinoApp createIOSObject(BuildContext arg) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      theme: iOSTheme,
      home: home
    );
  }

}