import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/base/platform_control.dart';
import 'package:flutter_playground/widget/blur.dart';
import 'package:flutter_playground/widget/platform/base.dart';
import 'package:flutter_playground/widget/platform/button.dart';
import 'package:flutter_playground/widget/platform/dialog.dart';

import '../../generated/l10n.dart';
import '../../widget/platform/app_bar.dart';
import '../../widget/platform/scaffold.dart';

class BlurDemoView extends StatefulWidget {
  const BlurDemoView({Key? key}) : super(key: key);

  @override
  State createState() => _BlurDemoView();
}

class _BlurDemoView extends State<BlurDemoView> {

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      isiOSLargeStyle: true,
      platformAppBar: PlatformAppBar(
          context: context,
          title: "Blur effect"
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // text content as background
            SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Text(S.of(context).longText,),
            ),

            // blur stack
            Center(
              child: BlurBox(
                padding: const EdgeInsets.all(20),
                backgroundColor: getNotNullablePlatformObject(
                    forAndroid: Theme.of(context).primaryColor,
                    forIOS: CupertinoTheme.of(context).primaryColor
                ).withOpacity(0.3),
                blurValue: 3,
                cornerRoundedValue: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: getDemoButtons(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAndroidAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return PlatformDialog(
              title: "Title display",
              content: const Text("Content text"),
              androidActions: [
                MaterialButton(onPressed: (){}, child: const Text("Action 1"),),
                MaterialButton(onPressed: (){}, child: const Text("Action 2"),)
              ]
          );
        }
    );
  }

  void _showIOSAlertDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return PlatformDialog(
              title: "Title display",
              content: const Text("Content text"),
              iosActions: [
                CupertinoDialogAction(onPressed: (){}, isDestructiveAction: true, child: const Text("Action 1"),),
                CupertinoDialogAction(onPressed: (){}, isDefaultAction: true, child: const Text("Action 2"),),
                CupertinoDialogAction(onPressed: (){}, child: const Text("Action 3"),),
              ]
          );
        }
    );
  }

  List<Widget> getDemoButtons(BuildContext context) {
    if (PlatformControl.self.isRunningAndroid()) {
      return [
        PlatformButton(
            onPressed: () => _showAndroidAlertDialog(context),
            child: const Text("Original alert dialog")
        ),
        PlatformButton(
            onPressed: () => _showBlurBackgroundDialog(context, true),
            child: const Text("Blur background dialog")
        ),
        PlatformButton(
            onPressed: () => _showBlurBackgroundDialog(context, false),
            child: const Text("Blur content dialog")
        )
      ];
    }

    return [
      PlatformButton(
          onPressed: () => _showIOSAlertDialog(context),
          child: const Text("Original alert dialog")
      )
    ];
  }

  void _showBlurBackgroundDialog(BuildContext context, bool isBlurBackground) {
    final Color barrierColor = isBlurBackground ? Colors.transparent : Colors.transparent;
    final Color backgroundColor = isBlurBackground ? Colors.transparent.withOpacity(0.2) : Colors.transparent;
    final Color dialogBackgroundColor = Theme.of(context).dialogBackgroundColor.withOpacity(0.8);

    showDialog(
        context: context,
        barrierColor: barrierColor,
        builder: (context) => BlurDialog(
            blurValue: 4,
            backgroundColor: backgroundColor,
            dialogBackgroundColor: dialogBackgroundColor,
            canDismissOnTapOutside: true,
            isBlurBackground: isBlurBackground,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("I'm dialog content text"),
                  const SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){}, child: const Text("Button here"))
                ],
              ),
            ),
        )
    );
  }
}