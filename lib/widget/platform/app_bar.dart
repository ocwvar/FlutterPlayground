import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformAppBar implements IPlatformWidgetSelector<AppBar, CupertinoNavigationBar, PreferredSizeWidget> {

  final String title;
  final bool hasBackAction;
  final BuildContext context;

  const PlatformAppBar({Key? key, required this.context, required this.title, this.hasBackAction = true});

  PreferredSizeWidget getAppBar() {
    return getPlatformWidget(context);
  }

  @override
  PreferredSizeWidget getPlatformWidget(BuildContext context) {
    return createIOSWidget(context);
  }

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
        padding: EdgeInsets.zero,
        child: const Icon(CupertinoIcons.chevron_back),
        onPressed: () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        },
      ) : null,
    );
  }

}