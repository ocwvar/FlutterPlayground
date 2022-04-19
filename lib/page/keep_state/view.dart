import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/list_item.dart';

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
      isiOSLargeStyle: true,
      platformAppBar: PlatformAppBar(
          context: context,
          title: "Page state keeping"
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Text(_text),
            const SizedBox(height: 20,),
            TextField(
              decoration: const InputDecoration(
                label: Text("Content"),
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
                    return createListItem(context, "Item ${index + 1}", true, null);
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