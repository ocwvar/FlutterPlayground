import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

import '../../base/platform_control.dart';

class PlatformAppBar implements IPlatformObjectSelector<AppBar, CupertinoNavigationBar, PreferredSizeWidget, BuildContext> {

  final String title;
  final bool hasBackAction;
  final BuildContext context;
  final String iosPreviousTitle;

  const PlatformAppBar({
    Key? key,
    required this.context,
    required this.title,
    this.iosPreviousTitle = "Back",
    this.hasBackAction = true
  });

  PreferredSizeWidget getAppBar() {
    return getPlatformObject(context);
  }

  @override
  PreferredSizeWidget getPlatformObject(BuildContext context) {
    if (PlatformControl.self.isRunningAndroid()) {
      return createAndroidObject(context);
    }

    return createIOSObject(context);
  }

  @override
  AppBar createAndroidObject(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: hasBackAction ? IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_sharp)
      ) : null,
    );
  }

  @override
  CupertinoNavigationBar createIOSObject(BuildContext context) {
    final Widget? backButton;
    if (hasBackAction) {
      backButton = CupertinoNavigationBarBackButton(
        previousPageTitle: iosPreviousTitle,
        onPressed: () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        }
      );
    } else {
      backButton = null;
    }

    return CupertinoNavigationBar(
      middle: Text(title),
      leading: backButton,
    );
  }

}