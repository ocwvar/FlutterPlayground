import 'package:flutter/cupertino.dart';

import '../models/currency.dart';

class CurrencySelectionActionSheet extends StatelessWidget {

  final String title;
  final String message;
  final Currency? lastSelected;
  final Function(Currency currency) onCurrencySelected;

  const CurrencySelectionActionSheet({
    Key? key,
    required this.title,
    required this.message,
    required this.lastSelected,
    required this.onCurrencySelected
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(title),
      message: Text(message),
      actions: _getAllActions(),
    );
  }

  List<Widget> _getAllActions() {
    final List<Widget> actions = [];
    for (Currency item in Currency.values) {
      actions.add(CupertinoActionSheetAction(
        onPressed: () => onCurrencySelected.call(item),
        isDefaultAction: item == lastSelected,
        child: Text(item.name.toUpperCase()),
      ));
    }
    return actions;
  }
}