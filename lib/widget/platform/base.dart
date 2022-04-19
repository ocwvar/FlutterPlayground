import 'dart:io';

import 'package:flutter/widgets.dart';

abstract class BasePlatformWidget<ANDROID extends Widget, IOS extends Widget> extends StatelessWidget {

  const BasePlatformWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlatformWidget(context);
  }

  /// get a [Widget] that has matched style to current platform
  Widget getPlatformWidget(BuildContext context) {
    if (Platform.isAndroid) {
      return createAndroidWidget(context);
    }

    return createIOSWidget(context);
  }

  /// create a [Widget] for Android platform
  /// return Android platform [Widget]
  ANDROID createAndroidWidget(BuildContext context);

  /// create a [Widget] for iOS platform
  /// return iOS platform [Widget]
  IOS createIOSWidget(BuildContext context);

}