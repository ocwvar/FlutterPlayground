import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/app_bar.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformScaffold extends BasePlatformWidget<Scaffold, CupertinoPageScaffold>{

  final PlatformAppBar platformAppBar;
  final bool isiOSLargeStyle;
  final Widget body;

  const PlatformScaffold({
    Key? key,
    required this.platformAppBar,
    required this.body,
    this.isiOSLargeStyle = false
  }) : super(key: key);

  @override
  Scaffold createAndroidObject(BuildContext arg) {
    return Scaffold(
      appBar: platformAppBar.createAndroidObject(arg),
      body: body,
    );
  }

  @override
  CupertinoPageScaffold createIOSObject(BuildContext arg) {
    if (isiOSLargeStyle) {
      return CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: Text(platformAppBar.title),
              )
            ];
          },
          body: body,
        ),
      );
    }

    return CupertinoPageScaffold(
      navigationBar: platformAppBar.createIOSObject(arg),
      child: SafeArea(
        child: body,
      ),
    );
  }
}