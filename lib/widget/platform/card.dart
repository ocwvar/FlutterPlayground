import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformCardView extends BasePlatformWidget<Card, Widget> {
  final BorderRadius corner = const BorderRadius.all(Radius.circular(12.0));

  final Color cardColor;
  final EdgeInsetsGeometry padding;
  final Widget child;

  const PlatformCardView({Key? key,
    required this.cardColor,
    required this.padding,
    required this.child
  }) : super(key: key);

  @override
  Card createAndroidObject(BuildContext arg) {
    return Card(
      color: cardColor,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }

  @override
  Widget createIOSObject(BuildContext arg) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: corner,
      child: ColoredBox(
        color: cardColor,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }

}