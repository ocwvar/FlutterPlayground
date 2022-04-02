import 'package:flutter/material.dart';

/// Get AppBar
/// String title : Title text on AppBar
/// bool hasBackAction : whether appBar has a back button which will do [Navigator.pop(context)]
AppBar createAppBar(BuildContext context, String title, bool hasBackAction) {
  return AppBar(
    title: Text(title),
    leading: hasBackAction
        ? IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_sharp))
        : null,
  );
}
