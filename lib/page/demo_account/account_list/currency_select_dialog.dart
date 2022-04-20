import 'package:flutter/material.dart';
import 'package:flutter_playground/page/demo_account/models/currency.dart';

import '../../../base/select_state_model.dart';
import '../../../widget/list_item.dart';

/// this view is use in a dialog
/// for user to select currency type
class CurrencySelectionDialogView extends StatefulWidget {
  final String title;
  final Currency? lastSelected;
  final Function(Currency currency) onCurrencySelected;

  const CurrencySelectionDialogView({
    Key? key,
    required this.title,
    required this.lastSelected,
    required this.onCurrencySelected
  }) : super(key: key);


  @override
  State createState() => _CurrencySelectionDialogView();
}

class _CurrencySelectionDialogView extends State<CurrencySelectionDialogView> {
  final List<Currency> values = Currency.values;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ListView.separated(
              padding: const EdgeInsets.only(top: 12),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final SelectStateModel<Currency> model = SelectStateModel(values[index]);
                model.updateSelectState(values[index] == widget.lastSelected);

                return createRadioListItem(
                  context,
                  values[index].name.toUpperCase(),
                  model,
                  (Currency selectedCurrency) => widget.onCurrencySelected.call(selectedCurrency)
                );
              },
              separatorBuilder: (context, index) => const SizedBox.shrink(),
              itemCount: values.length)
        ],
      ),
    );
  }
}
