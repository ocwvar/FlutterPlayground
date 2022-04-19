import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformAppBar implements IPlatformObjectSelector<AppBar, CupertinoNavigationBar, PreferredSizeWidget, BuildContext> {

  final String title;
  final bool hasBackAction;
  final BuildContext context;

  const PlatformAppBar({Key? key, required this.context, required this.title, this.hasBackAction = true});

  PreferredSizeWidget getAppBar() {
    return getPlatformObject(context);
  }

  @override
  PreferredSizeWidget getPlatformObject(BuildContext context) {
    // if (Platform.isAndroid) {
    //   return createAndroidObject(context);
    // }

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
    return CupertinoNavigationBar(
      middle: Text(title),
      leading: hasBackAction ? CupertinoButton(
        padding: EdgeInsets.zero,
        child: const Icon(CupertinoIcons.chevron_back),
        onPressed: () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        },
      ) : null,
    );
  }

}