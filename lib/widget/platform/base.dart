import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_playground/base/platform_control.dart';

abstract class IPlatformObjectSelector<ANDROID, IOS, TYPE, ARG> {

  /// get a [Object] that has matched style to current platform
  TYPE getPlatformObject(ARG arg);

  /// create a [Object] for Android platform
  /// return Android platform [Object]
  ANDROID createAndroidObject(ARG arg);

  /// create a [Object] for iOS platform
  /// return iOS platform [Object]
  IOS createIOSObject(ARG arg);

}

abstract class BasePlatformWidget<ANDROID extends Widget, IOS extends Widget>
    extends StatelessWidget
    implements IPlatformObjectSelector<ANDROID, IOS, Widget, BuildContext>
{

  bool get isRunningAndroid => Platform.isAndroid;
  const BasePlatformWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlatformObject(context);
  }

  /// get a [Widget] that has matched style to current platform
  @override
  Widget getPlatformObject(BuildContext context) {
     if (PlatformControl.self.isRunningAndroid()) {
       return createAndroidObject(context);
     }

    return createIOSObject(context);
  }

}

T? getNullablePlatformObject<T>({required T? forAndroid, required T? forIOS}) {
  if (PlatformControl.self.isRunningAndroid()) {
    return forAndroid;
  }

  return forIOS;
}

T getNotNullablePlatformObject<T>({required T forAndroid, required T forIOS}) {
  if (PlatformControl.self.isRunningAndroid()) {
    return forAndroid;
  }

  return forIOS;
}