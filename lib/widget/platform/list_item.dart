import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/base.dart';
import 'package:flutter_playground/widget/platform/styles.dart';

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
          Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  style: PlatformTextStyles.forContent(arg)),
              ),
          ),
          const Divider(height: 1,thickness: 1,),
        ],
      ),
    );
  }

  @override
  Widget createIOSObject(BuildContext arg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            child: Text(title, style: PlatformTextStyles.forContent(arg),),
            onPressed: onPressed,
            padding: const EdgeInsets.all(12),
            alignment: AlignmentDirectional.centerStart,
          ),
        ),
        const Divider(height: 1,thickness: 1,),
      ],
    );
  }

}