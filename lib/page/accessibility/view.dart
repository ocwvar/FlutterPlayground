import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_playground/base/platform_control.dart';
import 'package:flutter_playground/widget/platform/button.dart';
import 'package:flutter_playground/widget/platform/styles.dart';

import '../../widget/platform/app_bar.dart';
import '../../widget/platform/scaffold.dart';

class AccessibilityView extends StatefulWidget {
  const AccessibilityView({Key? key}) : super(key: key);

  @override
  State createState() => _AccessibilityView();
}

class _AccessibilityView extends State<AccessibilityView> {

  final String _text = "message text";

  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      isiOSLargeStyle: true,
      platformAppBar: PlatformAppBar(
          context: context,
          title: "Accessibility"
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Regular text", style: PlatformTextStyles.forTitle(context),),
            Text(_text),
            const SizedBox(height: 20,),

            Text("Heading", style: PlatformTextStyles.forTitle(context),),
            Semantics(
              child: Text(_text),
              header: true,
            ),
            const SizedBox(height: 20,),

            Text("Description", style: PlatformTextStyles.forTitle(context),),
            Semantics(
              child: const ColoredBox(
                color: Colors.blueAccent,
                child: SizedBox(height: 50, width: 50,),
              ),value: "This is blue color",
            ),
            const SizedBox(height: 20,),

            Text("Button", style: PlatformTextStyles.forTitle(context),),
            Semantics(
              child: Text(_text),
              button: true,
            ),
            const SizedBox(height: 20,),

            Text("Not focusable", style: PlatformTextStyles.forTitle(context),),
            Semantics(
              child: const Text("You can't read this"),
              hidden: true,
            ),
            const SizedBox(height: 20,),

            Text("Combined views", style: PlatformTextStyles.forTitle(context),),
            Semantics(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Semantics(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Username: Jimmy"),
                        Text("Role: Android developer"),
                      ],
                    ),
                    hidden: true,
                  ),
                ),
              ),
              value: "Jimmy is an Android developer",
            ),
            const SizedBox(height: 20,),

            Text("State views", style: PlatformTextStyles.forTitle(context),),
            createPlatformElementsPanel(),
            const SizedBox(height: 20,),

            Text("Announce manually", style: PlatformTextStyles.forTitle(context),),
            PlatformButton(onPressed: () {
              SemanticsService.announce("Hello there", TextDirection.ltr);
            }, child: const Text("Speck")),
            const SizedBox(height: 20,),

            Text("Focus status", style: PlatformTextStyles.forTitle(context),),
            Semantics(
              child: getTextByFocusStatus(),
              onDidGainAccessibilityFocus: () => setState(() {
                _hasFocus = true;
              }),
              onDidLoseAccessibilityFocus: () => setState(() {
                _hasFocus = false;
              }),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Widget getTextByFocusStatus() {
    TextStyle style;
    String text;
    if (_hasFocus) {
      text = "HAS FOCUS";
      style = const TextStyle(color: Colors.lightGreenAccent);
    } else {
      text = "LOST FOCUS";
      style = const TextStyle(color: Colors.redAccent);
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text, style: style,),
    );
  }

  Widget createPlatformElementsPanel() {
    if (PlatformControl.self.isRunningAndroid()) {
      return Row(
        children: [
          Column(
            children: [
              Checkbox(value: false, onChanged: (value){},),
              Switch(value: false, onChanged: (value){},),
              Radio(value: true, groupValue: false ,onChanged: (value){},),
            ],
          ),
          Column(
            children: [
              Checkbox(value: true, onChanged: (value){},),
              Switch(value: true, onChanged: (value){},),
              Radio(value: false, groupValue: false ,onChanged: (value){},),
            ],
          )
        ],
      );
    }

    return Row(
      children: [
        Column(
          children: [
            CupertinoSwitch(value: false, onChanged: (value){}),
          ],
        ),
        Column(
          children: [
            CupertinoSwitch(value: true, onChanged: (value){}),
          ],
        )
      ],
    );
  }

}