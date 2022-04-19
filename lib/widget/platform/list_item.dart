import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';

class PlatformListItem extends BasePlatformWidget<Widget, Widget> {

  final String title;
  final Function() onPressed;

  const PlatformListItem({
    Key? key,
    required this.title,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget createAndroidObject(BuildContext arg) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          const Divider(height: 1,thickness: 1,),
          Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  style: TextStyle(color: Theme.of(arg).textTheme.titleMedium?.color),
                ),
              )
          )
        ],
      ),
    );
  }

  @override
  Widget createIOSObject(BuildContext arg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1,thickness: 1,),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            child: Text(title, style: CupertinoTheme.of(arg).textTheme.textStyle,),
            onPressed: onPressed,
            padding: const EdgeInsets.all(12),
            alignment: AlignmentDirectional.centerStart,
          ),
        )
      ],
    );
  }

}