import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformTextStyles {
  static TextStyle? forTitle(BuildContext context) {
    return getNullablePlatformObject(
        forAndroid: Theme.of(context).textTheme.titleLarge,
        forIOS: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)
    );
  }

  static TextStyle? forContent(BuildContext context) {
    return getNullablePlatformObject(
        forAndroid: Theme.of(context).textTheme.bodyText2,
        forIOS: CupertinoTheme.of(context).textTheme.textStyle
    );
  }

  static TextStyle? forFootnote(BuildContext context) {
    return getNullablePlatformObject(
        forAndroid: Theme.of(context).textTheme.caption,
        forIOS: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300)
    );
  }
}