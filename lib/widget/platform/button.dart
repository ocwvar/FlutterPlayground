import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformIconTextButton extends BasePlatformWidget<Widget, CupertinoButton> {

  final Icon icon;
  final String text;
  final EdgeInsetsGeometry padding;
  final double paddingOfIconToText;
  final Function() onPressed;

  final bool isDisable;

  const PlatformIconTextButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.padding,
    required this.paddingOfIconToText,
    required this.onPressed,
    required this.isDisable
  }) : super(key: key);

  @override
  Widget createAndroidObject(BuildContext arg) {
    return InkWell(
      onTap: () {
        if (!isDisable) {
          onPressed.call();
        }
      },
      child: Padding(
        padding: padding,
        child: Opacity(
          opacity: isDisable? 0.4 : 1.0,
          child: Row(
            children: [
              icon,
              SizedBox(width: paddingOfIconToText,),
              Text(text)
            ],
          ),
        ),
      ),
    );
  }

  @override
  CupertinoButton createIOSObject(BuildContext arg) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: isDisable ? null : onPressed,
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              icon,
              SizedBox(width: paddingOfIconToText,),
              Text(text)
            ],
          ),
        )
    );
  }


}

class PlatformIconButton extends BasePlatformWidget<Widget, CupertinoButton> {

  final Icon icon;
  final Function() onPressed;

  const PlatformIconButton({
    Key? key,
    required this.icon,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget createAndroidObject(BuildContext arg) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: icon,
      ),
    );
  }

  @override
  CupertinoButton createIOSObject(BuildContext arg) {
    return CupertinoButton(
      child: icon,
      onPressed: onPressed,
      padding: const EdgeInsets.all(8),
    );
  }

}

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