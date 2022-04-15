import 'package:flutter/material.dart';
import 'package:flutter_playground/page/demo_account/account_list/view_model.dart';
import 'package:flutter_playground/page/demo_account/models/account.dart';

class AccountCardView extends StatelessWidget {

  final FocusNode _accountNoFocusNode;
  final FocusNode? _currentActiveFocusNode;
  final AccountListViewModel _viewModel;
  final Function() _onSelectAccountType;
  final Function() _onSelectCurrencyType;
  final int _index;

  const AccountCardView(this._accountNoFocusNode, this._currentActiveFocusNode, this._viewModel, this._onSelectAccountType, this._onSelectCurrencyType, this._index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountDisplayModel model = _viewModel.displayList[_index];

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
                Text("Account ${_index + 1}", style: Theme.of(context).textTheme.headline4,),
                const Spacer(),
                _deleteButtonVisibilityOf(_viewModel, model)
              ],
            ),

            // account type selection
            SizedBox(
              width: double.infinity,
              child: InkWell(
                highlightColor: Colors.transparent,
                onTap: () {
                  _currentActiveFocusNode?.unfocus();
                  _onSelectAccountType.call();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Account Type", style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 6,),
                      Text(_getAccountTypeDesc(model.account), style: Theme.of(context).textTheme.caption)
                    ],
                  ),
                ),
              ),
            ),

            // account balance currency type
            SizedBox(
              width: double.infinity,
              child: InkWell(
                highlightColor: Colors.transparent,
                onTap: () {
                  _currentActiveFocusNode?.unfocus();
                  _onSelectCurrencyType.call();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Balance currency type", style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 6,),
                      Text(_getAccountCurrencyDesc(model.account), style: Theme.of(context).textTheme.caption)
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
                    decoration: _getAccountNoInputDecorationOf(model),
                    textInputAction: TextInputAction.done,
                    maxLength: 13,
                    autofocus: false,
                    focusNode: _accountNoFocusNode,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      model.account.updateAccountNo(text);
                      _viewModel.update(model.account, true);
                    },
                    controller: _getAccountNoControlOf(model.account, _accountNoFocusNode)
                ),
              ),
            ),
          ],
        ),
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
  Widget _deleteButtonVisibilityOf(AccountListViewModel viewModel, AccountDisplayModel model) {
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
    return InkWell(
      onTap: () {
        if (!_reachLimit) {
          _onClick.call();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Opacity(
          opacity: getOpacityValuesByState(),
          child: Row(
            children: const [
              Icon(Icons.add_circle_outline),
              SizedBox(width: 20,),
              Text("Add account")
            ],
          ),
        ),
      ),
    );
  }

}

class SubmitButton extends StatelessWidget {

  final String _title;
  final Function() _onClick;
  final bool enable;

  const SubmitButton(this._title, this.enable, this._onClick, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ColoredBox(
        color: getStatusColor(context),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(_title, style: const TextStyle(color: Colors.white, fontSize: 18)),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.white.withOpacity(0.3),
                  onTap: (){
                    if (enable) {
                      _onClick.call();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getStatusColor(BuildContext context) {
    final Color statusColor;
    if (enable) {
      statusColor = Theme.of(context).primaryColor;
    } else {
      statusColor = Colors.black12;
    }

    return statusColor;
  }

}