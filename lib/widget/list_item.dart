import 'package:flutter/material.dart';

import '../base/select_state_model.dart';

Widget createListItem(BuildContext context, String title, bool enabled, Function()? block) {
  return InkWell(
      onTap: () => block?.call(),
      child: Column(
        children: [
          const Divider(height: 1,thickness: 1,),
          Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  style: TextStyle(
                      color: enabled ?
                      Theme.of(context).textTheme.titleMedium?.color :
                      Theme.of(context).textTheme.titleMedium?.color?.withAlpha(120)
                  ),
                ),
              )
          )
        ],
      ),
    );
}

Widget createRadioListItem<T>(BuildContext context, String title, SelectStateModel<T> stateModel, Function(T selectedItem)? block) {
  return InkWell(
    onTap: () {
      block?.call(stateModel.object);
    },
    child: Row(
      children: [
        Radio(
            value: 1,
            groupValue: stateModel.isSelected ? 1 : 0,
            onChanged: (_) {}
        ),
        Text(title, style: Theme.of(context).textTheme.titleMedium,)
      ],
    ),
  );
}