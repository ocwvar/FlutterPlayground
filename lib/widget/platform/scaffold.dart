import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/app_bar.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformScaffold extends BasePlatformWidget<Scaffold, CupertinoPageScaffold>{

  final PlatformAppBar platformAppBar;
  final Widget body;

  const PlatformScaffold({Key? key, required this.platformAppBar, required this.body}) : super(key: key);

  @override
  Scaffold createAndroidObject(BuildContext arg) {
    return Scaffold(
      appBar: platformAppBar.createAndroidObject(arg),
      body: body,
    );
  }

  @override
  CupertinoPageScaffold createIOSObject(BuildContext arg) {
    return CupertinoPageScaffold(
      navigationBar: platformAppBar.createIOSObject(arg),
      child: SafeArea(
        child: body,
      ),
    );
  }
}