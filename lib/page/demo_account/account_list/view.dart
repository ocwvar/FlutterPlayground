import 'package:flutter/material.dart';
import 'package:flutter_playground/page/demo_account/account_list/view_model.dart';
import 'package:flutter_playground/page/demo_account/models/account.dart';
import 'package:provider/provider.dart';

import '../../../widget/app_bar.dart';

class AccountListView extends StatefulWidget {
  const AccountListView({Key? key}) : super(key: key);
  @override
  State createState() => _AccountListView();
}

class _AccountListView extends State<AccountListView> {

  final Map<int, FocusNode> _nodes = {};

  @override
  void dispose() {
    for (var element in _nodes.entries) {
      element.value.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context, "Account management", true),
      body: ChangeNotifierProvider(
        create: (context) => AccountListViewModel(),
        child: Consumer<AccountListViewModel>(
          builder: (context, viewModel, child) {

            if (viewModel.displayList.isEmpty) {
              for(int i = 0; i < 12; i++) {
                final Account account = Account.create();
                _nodes[account.id] = FocusNode();
                viewModel.update(account, false);
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 8,),
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final AccountDisplayModel model = viewModel.displayList[index];
                        final FocusNode? node = _nodes[model.account.id];
                        if (node == null) {
                          return const SizedBox();
                        }

                        return AccountCardView.create(context, node, viewModel, index);
                      },
                      itemCount: viewModel.displayList.length,
                    )
                )
              ],
            );
          },
        ),
      ),
    );
  }

}

class AccountCardView {

  static Widget create(BuildContext context, FocusNode accountNoFocusNode, AccountListViewModel viewModel, int index) {
    final AccountDisplayModel model = viewModel.displayList[index];

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // column 1 -- account number and delete button
            Row(
              children: [
                Text("Account ${index + 1}", style: Theme.of(context).textTheme.headline4,),
                const Spacer(),
                deleteButtonVisibilityOf(viewModel, model)
              ],
            ),

            // account no input field
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  decoration: getAccountNoInputDecorationOf(model),
                  textInputAction: TextInputAction.next,
                  maxLength: 13,
                  focusNode: accountNoFocusNode,
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    model.account.updateAccountNo(text);
                    viewModel.update(model.account, true);
                  },
                  controller: getAccountNoControlOf(model.account, accountNoFocusNode)
                ),
              ),
            ),

            // account balance input field
            SizedBox(
              width: double.infinity,
              child: TextField(
                decoration: getAccountBalanceInputDecorationOf(model.account.balance),
                textInputAction: TextInputAction.done,
                maxLength: 20,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  model.account.balance.updateValueWithString(text);
                  viewModel.update(model.account, false);
                },
                controller: TextEditingController.fromValue(
                    TextEditingValue(
                        text: model.account.balance.getDisplayString()
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// get [InputDecoration] by state of given [AccountDisplayModel]
  /// there will have 3 state:
  /// 1. no account number
  /// 2. account number already existed
  /// 3. normal state without any error
  /// 4. account number format is invalid
  static InputDecoration getAccountNoInputDecorationOf(AccountDisplayModel model) {
    // state of duplicated
    if (model.isDuplicated) {
      return const InputDecoration(
          errorText: "This account number is duplicated",
          errorStyle: TextStyle(color: Colors.redAccent)
      );
    }

    // state of empty account number
    if (model.account.accountNo.isEmpty) {
      return const InputDecoration(
        suffixText: "example 123456-567890",
        errorText: "Please input account number",
      );
    }

    // state of invalid format of account number
    if (model.isInvalidFormat) {
      return const InputDecoration(
          errorText: "Account number format is invalid",
          suffixText: "example 123456-567890",
          errorStyle: TextStyle(color: Colors.deepOrangeAccent)
      );
    }

    //  normal state
    return const InputDecoration(
        labelText: "Account number",
        enabledBorder: InputBorder.none
    );
  }

  /// get delete button if source list in [AccountListViewModel] has more then 1 item
  /// @return [Widget]
  static Widget deleteButtonVisibilityOf(AccountListViewModel viewModel, AccountDisplayModel model) {
    if (viewModel.displayList.length > 1) {
      return IconButton(
          onPressed: () => viewModel.remove(model.account.id),
          icon: const Icon(Icons.highlight_remove)
      );
    }

    return const SizedBox();
  }

  /// get [InputDecoration] by state of given [Balance]
  /// there will have 3 state:
  /// 1. balance below 0
  /// 2. normal state without any error
  static InputDecoration getAccountBalanceInputDecorationOf(Balance balance) {
    if (balance.value < 0.0) {
      return const InputDecoration(
          errorText: "Your balance should always bigger then zero",
          errorStyle: TextStyle(color: Colors.redAccent)
      );
    }

    return const InputDecoration(
        labelText: "Account balance",
        enabledBorder: InputBorder.none
    );
  }

  /// get [TextEditingController] by current state of [FocusNode]
  /// we should *NOT* pass [TextEditingController] when [FocusNode.hasFocus] is True
  /// or cursor will have conflict setting text while value being update
  static TextEditingController? getAccountNoControlOf(Account account, FocusNode focusNode) {
    if (focusNode.hasFocus) {
      return null;
    }
     return TextEditingController.fromValue(
         TextEditingValue(
             text: account.accountNo
         )
     );
  }

}

