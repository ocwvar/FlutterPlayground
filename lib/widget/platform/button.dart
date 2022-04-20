import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformButton extends BasePlatformWidget<ElevatedButton, Widget> {

  final Widget child;
  final Function() onPressed;
  final ButtonStyle? androidButtonStyle;

  final Color? iosButtonColor;
  final EdgeInsets? iosButtonPadding;

  final bool isDisable;
  final EdgeInsets _defaultIosButtonPadding = const EdgeInsets.all(12);

  const PlatformButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.androidButtonStyle,
    this.iosButtonColor,
    this.iosButtonPadding,
    this.isDisable = false,
  }) : super(key: key);

  @override
  ElevatedButton createAndroidObject(BuildContext arg) {
    return ElevatedButton(
      onPressed: isDisable ? null : onPressed,
      child: child,
      style: androidButtonStyle,
    );
  }

  @override
  Widget createIOSObject(BuildContext arg) {
    if (iosButtonColor == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: CupertinoButton.filled(
            onPressed: isDisable ? null : onPressed,
            child: child,
            padding: iosButtonPadding ?? _defaultIosButtonPadding
        ),
      );
    }

    return CupertinoButton(
        color: iosButtonColor,
        onPressed: isDisable ? null : onPressed,
        child: child,
        padding: iosButtonPadding ?? _defaultIosButtonPadding
    );
  }

}