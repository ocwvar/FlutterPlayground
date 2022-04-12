import 'package:flutter/material.dart';
import 'package:flutter_playground/page/demo_account/account_list/view_model.dart';
import 'package:flutter_playground/page/demo_account/models/account.dart';

class AccountCardView {

  /// create a [Widget] has account info
  static Widget create(
      BuildContext context,
      FocusNode accountNoFocusNode,
      AccountListViewModel viewModel,
      Function() onSelectAccountType,
      int index)
  {
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

            // account type selection
            SizedBox(
              width: double.infinity,
              child: InkWell(
                onTap: onSelectAccountType,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Account Type", style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 6,),
                      Text(getAccountTypeDesc(model.account), style: Theme.of(context).textTheme.caption)
                    ],
                  ),
                ),
              ),
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
          ],
        ),
      ),
    );
  }

  static String getAccountTypeDesc(Account account) {
    final String name = account.type?.typeName ?? "";
    final String desc = account.type?.description ?? "";

    if (desc.isEmpty || name.isEmpty) {
      return "Please select your account type";
    } else {
      return name + " - " + desc;
    }
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
          labelText: "Account number",
          errorText: "This account number is duplicated",
          errorStyle: TextStyle(color: Colors.redAccent)
      );
    }

    // state of empty account number
    if (model.account.accountNo.isEmpty) {
      return const InputDecoration(
        labelText: "Account number",
        suffixText: "example 123456-567890",
        errorText: "Please input account number",
      );
    }

    // state of invalid format of account number
    if (model.isInvalidFormat) {
      return const InputDecoration(
          labelText: "Account number",
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
      return InkWell(
        onTap: () => viewModel.remove(model.account.id),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.highlight_remove),
        ),
      );
    }

    return const SizedBox.shrink();
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

class AddAccountButtonView {

  static Widget create(BuildContext context, bool reachLimit, Function() onClick){
    return InkWell(
      onTap: () => onClick(),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: const [
            Icon(Icons.add_circle_outline),
            SizedBox(width: 20,),
            Text("Add account")
          ],
        ),
      ),
    );
  }

}