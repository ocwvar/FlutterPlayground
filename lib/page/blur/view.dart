import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/blur.dart';

import '../../generated/l10n.dart';
import '../../widget/platform/app_bar.dart';

class BlurDemoView extends StatefulWidget {
  const BlurDemoView({Key? key}) : super(key: key);

  @override
  State createState() => _BlurDemoView();
}

class _BlurDemoView extends State<BlurDemoView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformAppBar(
          context: context,
          title: "Blur effect"
      ).getAppBar(),
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

            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
            ),

            // blur stack
            Center(
              child: BlurBox(
                padding: const EdgeInsets.all(20),
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
                blurValue: 3,
                cornerRoundedValue: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: () => _showBlurBackgroundDialog(context, true),
                        child: const Text("Show blur background dialog")
                    ),
                    ElevatedButton(
                        onPressed: () => _showBlurBackgroundDialog(context, false),
                        child: const Text("Show blur content dialog")
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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