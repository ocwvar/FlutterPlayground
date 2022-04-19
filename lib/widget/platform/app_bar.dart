import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformAppBar extends BasePlatformWidget<AppBar, CupertinoNavigationBar> {

  final String title;
  final bool hasBackAction;

  const PlatformAppBar({Key? key, required this.title, required this.hasBackAction}) : super(key: key);

  @override
  AppBar createAndroidWidget(BuildContext context) {
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
  CupertinoNavigationBar createIOSWidget(BuildContext context) {
    return CupertinoNavigationBar(
      middle: Text(title),
      leading: hasBackAction ? CupertinoButton(
        child: const Icon(CupertinoIcons.back),
        onPressed: () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        },
      ) : null,
    );
  }

}