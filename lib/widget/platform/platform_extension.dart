import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/base/platform_control.dart';

extension PlatformNavigator on Navigator {

  /// will use [MaterialPageRoute] for aOS and [CupertinoPageRoute] for iOS
  static Future pushByPlatform(BuildContext context, Widget newPage) {
    final PageRoute route;
    if (PlatformControl.self.isRunningAndroid()) {
      route = MaterialPageRoute(builder: (context) => newPage);
    } else {
      route = CupertinoPageRoute(builder: (context) => newPage);
    }

    return Navigator.push(context, route);
  }
}