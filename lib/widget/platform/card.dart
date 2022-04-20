import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';
import 'package:flutter_playground/widget/platform/click_effect.dart';

class PlatformCardView extends BasePlatformWidget<Card, Widget> {
  final BorderRadius corner = const BorderRadius.all(Radius.circular(12.0));

  final Color? cardColor;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Function()? onPressed;

  const PlatformCardView({Key? key,
    this.cardColor,
    required this.padding,
    required this.child,
    this.onPressed
  }) : super(key: key);

  @override
  Card createAndroidObject(BuildContext arg) {
    Color? defaultCardColor;
    if (cardColor == null) {
      defaultCardColor = Theme.of(arg).cardColor;
    }

    return Card(
      color: cardColor ?? defaultCardColor,
      clipBehavior: Clip.antiAlias,
      child: _wrapChildWithScenarios(),
    );
  }

  @override
  Widget createIOSObject(BuildContext arg) {
    Color defaultCardColor = CupertinoTheme.of(arg).barBackgroundColor;;

    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: corner,
      child: ColoredBox(
        color: cardColor ?? defaultCardColor,
        child: _wrapChildWithScenarios(),
      ),
    );
  }

  /// wrap child with clickable widget if [onPressed] was set
  /// or just return [child]
  Widget _wrapChildWithScenarios() {
    if (onPressed != null) {
      return wrapClickEffect(
          child: Padding(
            padding: padding,
            child: child,
          ),
          onPressed: onPressed!
      );
    }

    return Padding(
      padding: padding,
      child: child,
    );
  }

}