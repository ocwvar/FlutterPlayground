import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/page/demo_account/account_type/model.dart';
import 'package:flutter_playground/widget/platform/scaffold.dart';
import 'package:flutter_playground/widget/platform/styles.dart';

import '../../../widget/platform/app_bar.dart';
import '../../../widget/platform/card.dart';
import '../models/account_types.dart';

class AccountTypeView extends StatelessWidget {
  final AccountTypeModel _model = AccountTypeModel();

  AccountTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _model.init();

    return PlatformScaffold(
      isiOSLargeStyle: false,
      platformAppBar: PlatformAppBar(context: context, title: "Account Types"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Please select your account type",
              style: PlatformTextStyles.forContent(context),
            ),
          ),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final AccountTypeDetail detail = _model.list[index];

                  return SizedBox(
                    width: double.infinity,
                    child: PlatformCardView(
                        padding: const EdgeInsets.all(12),
                        onPressed: () => onSelectedAccountType(context, detail),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detail.typeName,
                              style: PlatformTextStyles.forTitle(context),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              detail.description,
                              style: PlatformTextStyles.forFootnote(context),
                            )
                          ],
                        )
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                itemCount: _model.list.length),
          )
        ],
      ),
    );
  }

  // pop back to last page with [AccountTypeDetail]
  void onSelectedAccountType(BuildContext context, AccountTypeDetail detail) {
    Navigator.pop(context, detail);
  }
}
