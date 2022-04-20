import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/page/demo_account/account_list/view_model.dart';
import 'package:flutter_playground/page/demo_account/models/account.dart';
import 'package:flutter_playground/widget/platform/base.dart';
import 'package:flutter_playground/widget/platform/card.dart';
import 'package:flutter_playground/widget/platform/input_field.dart';
import 'package:flutter_playground/widget/platform/styles.dart';

import '../../../widget/platform/button.dart';
import '../../../widget/platform/click_effect.dart';

class AccountCardView extends StatelessWidget {

  final int index;
  final AccountListViewModel accountViewModel;
  final FocusNode accountInputFocusNode;
  final Function() onUnFocusCurrentActiveFocusNode;
  final Function() onSelectAccountType;
  final Function() onSelectCurrencyType;

  const AccountCardView({
      Key? key,
      required this.index,
      required this.accountViewModel,
      required this.accountInputFocusNode,
      required this.onUnFocusCurrentActiveFocusNode,
      required this.onSelectAccountType,
      required this.onSelectCurrencyType,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountDisplayModel model = accountViewModel.displayList[index];

    return PlatformCardView(
      padding: const EdgeInsets.all(12),
      cardColor: getNotNullablePlatformObject(
          forAndroid: Theme.of(context).cardColor,
          forIOS: CupertinoTheme.of(context).barBackgroundColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // column 1 -- account number and delete button
          Row(
            children: [
              Text("Account ${index + 1}", style: PlatformTextStyles.forBigTitle(context),),
              const Spacer(),
              _deleteButtonVisibilityOf(accountViewModel, model)
            ],
          ),

          // account type selection
          SizedBox(
            width: double.infinity,
            child: wrapClickEffect(
              onPressed: () {
                onUnFocusCurrentActiveFocusNode.call();
                onSelectAccountType.call();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Account Type", style: PlatformTextStyles.forTitle(context)),
                    const SizedBox(height: 6,),
                    Text(_getAccountTypeDesc(model.account), style: PlatformTextStyles.forContent(context))
                  ],
                ),
              ),
            ),
          ),

          // account balance currency type
          SizedBox(
            width: double.infinity,
            child: wrapClickEffect(
              onPressed: () {
                onUnFocusCurrentActiveFocusNode.call();
                onSelectCurrencyType.call();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Balance currency type", style: PlatformTextStyles.forTitle(context)),
                    const SizedBox(height: 6,),
                    Text(_getAccountCurrencyDesc(model.account), style: PlatformTextStyles.forContent(context))
                  ],
                ),
              ),
            ),
          ),

          // account no input field
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: double.infinity,
              child: PlatformInputField(
                  decoration: _getAccountNoInputDecorationOf(model),
                  textInputAction: TextInputAction.done,
                  maxLength: 13,
                  autofocus: false,
                  focusNode: accountInputFocusNode,
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    model.account.updateAccountNo(text);
                    accountViewModel.update(model.account, true);
                  },
                  controller: _getAccountNoControlOf(model.account, accountInputFocusNode)
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// get account type description by [Account.typeName] and [Account.description]
  /// return [String] text of account type or hint
  String _getAccountTypeDesc(Account account) {
    final String name = account.type?.typeName ?? "";
    final String desc = account.type?.description ?? "";

    if (desc.isEmpty || name.isEmpty) {
      return "Please select your account type";
    } else {
      return name + " - " + desc;
    }
  }

  /// get account currency description by [Account.currency]
  /// return [String] text of Currency name or hint
  String _getAccountCurrencyDesc(Account account) {
    final String currencyName = account.currency?.name.toUpperCase() ?? "";

    if (currencyName.isEmpty) {
      return "Please select your balance currency";
    } else {
      return currencyName;
    }
  }

  /// get [InputDecoration] by state of given [AccountDisplayModel]
  /// there will have 3 state:
  /// 1. no account number
  /// 2. account number already existed
  /// 3. normal state without any error
  /// 4. account number format is invalid
  InputDecoration _getAccountNoInputDecorationOf(AccountDisplayModel model) {
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
        hintText: "example 123456-567890",
        errorText: "Please input account number",
      );
    }

    // state of invalid format of account number
    if (model.isInvalidFormat) {
      return const InputDecoration(
          labelText: "Account number",
          errorText: "Account number format is invalid",
          hintText: "example 123456-567890",
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
  Widget _deleteButtonVisibilityOf(AccountListViewModel viewModel, AccountDisplayModel model) {
    if (viewModel.displayList.length > 1) {
      return PlatformIconButton(
        onPressed: () => viewModel.remove(model.account.id),
        icon: getNotNullablePlatformObject(
            forAndroid: const Icon(Icons.highlight_remove),
            forIOS: const Icon(CupertinoIcons.clear_circled)
        ),
      );
    }

    return const SizedBox.shrink();
  }

  /// get [TextEditingController] by current state of [FocusNode]
  /// we should *NOT* pass [TextEditingController] when [FocusNode.hasFocus] is True
  /// or cursor will have conflict setting text while value being update
  TextEditingController? _getAccountNoControlOf(Account account, FocusNode focusNode) {
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

class AddAccountButtonView extends StatelessWidget {

  final bool _reachLimit;
  final Function() _onClick;

  const AddAccountButtonView(this._reachLimit, this._onClick, {Key? key}) : super(key: key);

  double getOpacityValuesByState() {
    if (_reachLimit) {
      return 0.3;
    }

    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return PlatformIconTextButton(
      icon: getNotNullablePlatformObject(
          forAndroid: const Icon(Icons.add_circle_outline),
          forIOS: const Icon(CupertinoIcons.add_circled)
      ),
      text: "Add account",
      padding: const EdgeInsets.all(12),
      paddingOfIconToText: 20,
      onPressed: _onClick,
      isDisable: _reachLimit,
    );
  }

}

class SubmitButton extends StatelessWidget {

  final String title;
  final Function() onPressed;
  final bool isEnable;

  const SubmitButton({
    Key? key,
    required this.title,
    required this.isEnable,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SimpleClickEffect(
        child: ColoredBox(
          color: getStatusColor(context),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
        onPressed: () {
          if (isEnable) {
            onPressed.call();
          }
        },
      ),
    );
  }

  Color getStatusColor(BuildContext context) {
    final Color statusColor;
    if (isEnable) {
      statusColor = getNotNullablePlatformObject(
          forAndroid: Theme.of(context).primaryColor,
          forIOS: CupertinoTheme.of(context).primaryColor
      );
    } else {
      statusColor = Colors.black12;
    }

    return statusColor;
  }

}