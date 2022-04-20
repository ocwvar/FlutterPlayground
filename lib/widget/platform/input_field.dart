import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformInputField extends BasePlatformWidget<TextField, CupertinoTextField> {

  final InputDecoration? decoration;
  final Function(String)? onChanged;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  final String iosHint;
  final TextStyle? iosHintTextStyle;

  const PlatformInputField(
    {
      Key? key,
      this.decoration,
      this.onChanged,
      this.maxLength,
      this.maxLines,
      this.textInputAction,
      this.autofocus = false,
      this.focusNode,
      this.controller,
      this.iosHint = "",
      this.iosHintTextStyle
    }) : super(key: key);

  @override
  TextField createAndroidObject(BuildContext arg) {
    return TextField(
      textInputAction: textInputAction,
      controller: controller,
      focusNode: focusNode,
      decoration: decoration,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLines,
      autofocus: autofocus,
    );
  }

  @override
  CupertinoTextField createIOSObject(BuildContext arg) {
    TextStyle? defaultIosTextStyle;
    if (iosHint.isNotEmpty && iosHintTextStyle == null) {
      defaultIosTextStyle = TextStyle(
        fontWeight: FontWeight.w300,
        color: CupertinoTheme.of(arg).textTheme.textStyle.color?.withOpacity(0.4)
      );
    }

    return CupertinoTextField(
      padding: const EdgeInsets.all(8),
      placeholder: iosHint,
      placeholderStyle: iosHintTextStyle ?? defaultIosTextStyle,
      textInputAction: textInputAction,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLines,
      autofocus: autofocus,
    );
  }

}