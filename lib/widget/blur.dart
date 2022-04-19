import 'dart:ui';

import 'package:flutter/material.dart';

/// a dialog that wrap with [BlurBox]
class BlurDialog extends StatelessWidget {

  final Widget child;
  final double blurValue;
  final Color backgroundColor;
  final Color dialogBackgroundColor;

  final bool canDismissOnTapOutside;
  final bool isBlurBackground;

  final double roundedCorner = 12.0;

  const BlurDialog({Key? key,
    required this.blurValue,
    required this.backgroundColor,
    required this.dialogBackgroundColor,
    required this.canDismissOnTapOutside,
    required this.isBlurBackground,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (canDismissOnTapOutside) {
          Navigator.pop(context);
        }
      },
      child: _getDialog(context),
    );
  }

  Widget _getDialog(BuildContext context) {
    if (isBlurBackground) {
      return BlurBox(
          needAnimated: true,
          padding: const EdgeInsets.all(0),
          blurValue: blurValue,
          backgroundColor: backgroundColor,
          cornerRoundedValue: 0,
          child: Dialog(
            elevation: 0,
            backgroundColor: dialogBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(roundedCorner),
            ),
            child: child,
          )
      );
    }

    return Dialog(
      elevation: 0,
      backgroundColor: dialogBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(roundedCorner),
      ),
      child: BlurBox(
          needAnimated: true,
          padding: const EdgeInsets.all(0),
          blurValue: blurValue,
          backgroundColor: backgroundColor,
          cornerRoundedValue: roundedCorner,
          child: child
      ),
    );
  }

}


/// a widget provided blur background effect
/// also with padding, rounded corner and color background
class BlurBox extends StatelessWidget {

  final bool needAnimated;
  final double cornerRoundedValue;
  final EdgeInsets padding;
  final double blurValue;
  final Color backgroundColor;

  final Widget child;

  const BlurBox({
    Key? key,
    this.needAnimated = false,
    required this.padding,
    required this.blurValue,
    required this.backgroundColor,
    required this.cornerRoundedValue,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (needAnimated) {
      return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: blurValue),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
        builder: (a, double value, b) {
          return _getContentChild(context, value);
        },
      );
    } else {
      return _getContentChild(context, blurValue);
    }
  }

  Widget _getContentChild(BuildContext context, double blurValue) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.all(Radius.circular(cornerRoundedValue)),
      child: ColoredBox(
        color: backgroundColor,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: blurValue, sigmaX: blurValue),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}