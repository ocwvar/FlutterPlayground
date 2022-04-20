import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/input_field.dart';
import 'package:flutter_playground/widget/platform/list_item.dart';

import '../../widget/platform/app_bar.dart';
import '../../widget/platform/scaffold.dart';

class KeepStateView extends StatefulWidget {
  const KeepStateView({Key? key}) : super(key: key);

  @override
  State createState() => _KeepStateView();
}

class _KeepStateView extends State<KeepStateView> {

  String _text = "";

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      isiOSLargeStyle: false,
      platformAppBar: PlatformAppBar(
          context: context,
          title: "Page state keeping"
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Try to input some text in InputField and scroll the ListView, and it will keep its state when you change state of this page.\n\n i.e.:screen rotation "),
            const SizedBox(height: 20,),
            Text(_text),
            const SizedBox(height: 20,),
            PlatformInputField(
              iosHint: "Input something here...",
              decoration: const InputDecoration(
                label: Text("Input something here..."),
              ),
              onChanged: (text) {
                setState(() {
                  _text = text;
                });
              },
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return PlatformListItem(title: "Item ${index + 1}", onPressed:(){});
                  },
                itemCount: 150,
              ),
            )
          ],
        )
      ),
    );
  }
}