import 'package:flutter/material.dart';
import 'package:flutter_playground/page/demo_account/account_type/model.dart';

import '../../../widget/platform/app_bar.dart';
import '../models/account_types.dart';

class AccountTypeView extends StatelessWidget {
  final AccountTypeModel _model = AccountTypeModel();

  @override
  Widget build(BuildContext context) {
    _model.init();

    return Scaffold(
      appBar:
          PlatformAppBar(context: context, title: "Account Types").getAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Please select your account type",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final AccountTypeDetail detail = _model.list[index];

                  return SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => onSelectedAccountType(context, detail),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                detail.typeName,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                detail.description,
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        )),
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
