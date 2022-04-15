import 'package:flutter/material.dart';
import 'package:flutter_playground/page/demo_account/account_list/currency_select_dialog.dart';
import 'package:flutter_playground/page/demo_account/account_list/view_model.dart';
import 'package:flutter_playground/page/demo_account/account_list/widgets.dart';
import 'package:flutter_playground/page/demo_account/account_type/view.dart';
import 'package:flutter_playground/page/demo_account/models/account.dart';
import 'package:flutter_playground/page/demo_account/models/account_types.dart';
import 'package:flutter_playground/page/demo_account/models/currency.dart';
import 'package:flutter_playground/page/demo_account/verify/view.dart';
import 'package:provider/provider.dart';

import '../../../widget/app_bar.dart';

class AccountListView extends StatefulWidget {
  const AccountListView({Key? key}) : super(key: key);
  @override
  State createState() => _AccountListView();
}

class _AccountListView extends State<AccountListView> {

  final int _maxAccountCardNumber = 5;

  // first focus node is for "Account number" input field
  // second focus node is for "Account balance" input field
  final Map<int, FocusNode> _itemInputFocusNodes = {};

  /// Scroll controller for content list
  /// use this to achieve scroll down to bottom
  /// when added a new item into content list
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    for (var element in _itemInputFocusNodes.entries) {
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
            // we init the account card list with one item
            // and we should keep there at less one card in list
            if (viewModel.displayList.isEmpty) {
              _addNewAccountCard(viewModel, false);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      separatorBuilder: (context, index) => const SizedBox(height: 8,),
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        // for the last one, should be "add account" button
                        if (index == viewModel.displayList.length) {
                          final bool reachLimit = viewModel.displayList.length == _maxAccountCardNumber;
                          return AddAccountButtonView(reachLimit, () {
                            _getCurrentActiveFocus()?.unfocus();
                            _addNewAccountCard(viewModel, true);
                          });
                        }

                        final AccountDisplayModel model = viewModel.displayList[index];
                        final FocusNode? accountNoFocusNode = _itemInputFocusNodes[model.account.id];
                        if (accountNoFocusNode == null) {
                          // if we cant get focus, then we just ignore it
                          return const SizedBox.shrink();
                        }

                        return AccountCardView(
                            accountNoFocusNode,
                            _getCurrentActiveFocus(),
                            viewModel,
                            () => _onSelectAccountType(context, viewModel, model.account),
                            () => _onSelectCurrencyType(context, viewModel, model.account),
                            index
                        );
                      },
                      // the last one should be "add account" button
                      itemCount: viewModel.displayList.length + 1,
                    )
                ),
                SubmitButton(
                    "Submit",
                    viewModel.canSubmit,
                    () => _submit(viewModel)
                )
              ],
            );
          },
        ),
      ),
    );
  }

  /// submit all account
  void _submit(AccountListViewModel viewModel) {
    _getCurrentActiveFocus()?.unfocus();
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => VerifyPageView((viewModel.readOnlyAccountList)))
    );
  }

  FocusNode? _getCurrentActiveFocus() {
    for (FocusNode item in _itemInputFocusNodes.values) {
      if (item.hasFocus || item.hasPrimaryFocus) {
        return item;
      }
    }

    return null;
  }

  /// add new account card to view
  void _addNewAccountCard(AccountListViewModel viewModel, bool needUpdate) {
    final Account account = Account.create();
    _itemInputFocusNodes[account.id] = FocusNode();
    viewModel.update(account, needUpdate);
    _scrollDown2Bottom();
  }

  /// scroll content list down to bottom
  void _scrollDown2Bottom() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut
      );
    });
  }

  /// call when user clicked "Account Type"
  /// jump to page [AccountTypeView] to let use choose their account type
  /// @param [index] which item has been clicked
  void _onSelectAccountType(BuildContext context, AccountListViewModel viewModel, Account account) async {
    final AccountTypeDetail? result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AccountTypeView()));
    if (result == null) {
      // when user click back button will return NULL result
      return;
    }

    // update account model and request update to viewModel
    account.updateAccountType(result);
    viewModel.update(account, true);
  }

  /// open a dialog to let user to select currency type
  void _onSelectCurrencyType(BuildContext context, AccountListViewModel viewModel, Account account) {
    showDialog(
        context: context,
        builder: (dialogContext) => Dialog(
          child: CurrencySelectionDialogView(
              "Select currency",
              account.currency,
              // callback when user clicked currency item
              (Currency selectedCurrency) {
                if (selectedCurrency == account.currency) {
                  // ignored if clicked one is we already have
                  return;
                }

                // update viewModel
                account.updateCurrencyType(selectedCurrency);
                viewModel.update(account, true);
                Navigator.pop(dialogContext);
              }
          ),
        )
    );
  }

}