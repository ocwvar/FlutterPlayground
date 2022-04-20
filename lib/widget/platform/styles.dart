import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformTextStyles {
  static TextStyle? forBigTitle(BuildContext context) {
    return getNullablePlatformObject(
        forAndroid: Theme.of(context).textTheme.headline4,
        forIOS: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.w300)
    );
  }

  static TextStyle? forTitle(BuildContext context) {
    return getNullablePlatformObject(
        forAndroid: Theme.of(context).textTheme.titleLarge,
        forIOS: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)
    );
  }

  static TextStyle? forContent(BuildContext context) {
    return getNullablePlatformObject(
        forAndroid: Theme.of(context).textTheme.bodyText2,
        forIOS: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400)
    );
  }

  static TextStyle? forFootnote(BuildContext context) {
    return getNullablePlatformObject(
        forAndroid: Theme.of(context).textTheme.caption,
        forIOS: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400)
    );
  }
}