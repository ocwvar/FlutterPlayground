import 'package:flutter/material.dart';

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