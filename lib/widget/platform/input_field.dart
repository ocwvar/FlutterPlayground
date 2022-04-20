import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformInputField extends BasePlatformWidget<TextField, Widget> {

  final InputDecoration? decoration;
  final Function(String)? onChanged;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

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
      this.keyboardType
    }) : super(key: key);

  @override
  TextField createAndroidObject(BuildContext arg) {
    return TextField(
      textInputAction: textInputAction,
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      decoration: decoration,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLines,
      autofocus: autofocus,
    );
  }

  @override
  Widget createIOSObject(BuildContext arg) {
    TextStyle? defaultIosHintTextStyle;
    final String? hint = decoration?.hintText;
    if (hint != null) {
      defaultIosHintTextStyle = TextStyle(
        fontWeight: FontWeight.w300,
        color: CupertinoTheme.of(arg).textTheme.textStyle.color?.withOpacity(0.4)
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label
        _getIOSHeader(arg),
        CupertinoTextField(
          padding: const EdgeInsets.all(8),
          placeholder: hint,
          placeholderStyle: defaultIosHintTextStyle,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          maxLength: maxLength,
          maxLines: maxLines,
          autofocus: autofocus,
        )
      ],
    );
  }

  Widget _getIOSHeader(BuildContext context) {
    // label
    final Widget? labelWidget = decoration?.label;
    final String? labelText = decoration?.labelText;

    // error
    final String? errorText = decoration?.errorText;
    final TextStyle? errorTextStyle = decoration?.errorStyle;

    final Widget headerWidget;

    // check error first
    if (errorText != null) {
      headerWidget = Text(errorText, style: TextStyle(fontSize: 14, color: errorTextStyle?.color ?? Colors.red),);
    } else if (labelWidget != null) {
      headerWidget = labelWidget;
    } else if (labelText != null) {
      headerWidget = Text(labelText, style: const TextStyle(fontSize: 14),);
    } else {
      headerWidget = const SizedBox.shrink();
    }

    return headerWidget;
  }

}