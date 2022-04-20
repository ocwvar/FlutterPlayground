import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformDialog extends BasePlatformWidget<AlertDialog, CupertinoAlertDialog> {

  final String title;
  final Widget content;

  final List<Widget>? androidActions;
  final List<CupertinoDialogAction>? iosActions;

  const PlatformDialog({Key? key,
    required this.title,
    required this.content,
    this.androidActions,
    this.iosActions,
  }) : super(key: key);

  @override
  AlertDialog createAndroidObject(BuildContext arg) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: androidActions,
    );
  }

  @override
  CupertinoAlertDialog createIOSObject(BuildContext arg) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: content,
      actions: iosActions ?? [],
    );
  }
}