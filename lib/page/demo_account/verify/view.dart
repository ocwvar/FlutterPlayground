import 'package:flutter/material.dart';
import 'package:flutter_playground/page/demo_account/models/account.dart';
import 'package:flutter_playground/widget/platform/card.dart';
import 'package:flutter_playground/widget/platform/scaffold.dart';
import 'package:flutter_playground/widget/platform/styles.dart';

import '../../../widget/platform/app_bar.dart';

class VerifyPageView extends StatelessWidget {

  final List<Account> _accounts;

  /// should pass [_accounts] from [account_list.view]
  const VerifyPageView(this._accounts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      platformAppBar: PlatformAppBar(
          context: context,
          title: "Verify"
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final Account account = _accounts[index];
            return StatelessAccountCardWidget(account);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8,),
          itemCount: _accounts.length
      ),
    );
  }
}

class StatelessAccountCardWidget extends StatelessWidget {

  final Account _account;
  const StatelessAccountCardWidget(this._account, {Key? key}) : super(key: key);

  String getAccountTypeString() {
    final String name = _account.type?.typeName ?? "";
    final String desc = _account.type?.description ?? "";
    return name + " - " + desc;
  }

  @override
  Widget build(BuildContext context) {
    return PlatformCardView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // account number
          Text(_account.accountNo, style: PlatformTextStyles.forBigTitle(context),),

          // account type
          const SizedBox(height: 20,),
          Text("Account Type", style: PlatformTextStyles.forTitle(context)),
          const SizedBox(height: 6,),
          Text(getAccountTypeString(), style: PlatformTextStyles.forContent(context)),

          // currency
          const SizedBox(height: 20,),
          Text("Balance currency type", style: PlatformTextStyles.forTitle(context)),
          const SizedBox(height: 6,),
          Text(_account.currency?.name.toUpperCase() ?? "", style: PlatformTextStyles.forContent(context))
        ],
      ),
    );
  }
}