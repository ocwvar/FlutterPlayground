import 'package:flutter/material.dart';
import 'package:flutter_playground/page/demo_account/models/account.dart';

class AccountListViewModel extends ChangeNotifier {
  final RegExp _regExRule = RegExp("^[\\d]{6}-[\\d]{6}\$");
  final List<Account> _accounts = List.empty(growable: true);

  final List<AccountDisplayModel> _displayList = List.empty(growable: true);
  List<AccountDisplayModel> get displayList => _displayList;

  void update(Account account, bool needRefresh) {
    /// try to get from source list first
    final Account item = _getAccountById(account.id) ?? account;
    item.updateAccountNo(account.accountNo);
    _addOrUpdate(item, needRefresh);
  }

  void remove(int id) {
    int index = -1;
    bool shouldReCheckDuplicateState = false;
    String accountNo = "";
    for(int i = 0; i < _accounts.length; i++) {
      if(_accounts[i].id == id) {
        shouldReCheckDuplicateState = _displayList[i].isDuplicated;
        if (shouldReCheckDuplicateState) {
          accountNo = _accounts[i].accountNo;
        }
        index = i;
        break;
      }
    }

    if (index == -1) return;

    // remove from all source list
    _accounts.removeAt(index);
    _displayList.removeAt(index);

    // if flag [shouldReCheckDuplicateState] is true means this item was duplicated
    // with other object, and we should check theme again
    if (shouldReCheckDuplicateState) {
      for (AccountDisplayModel item in _displayList) {
        if (item.isDuplicated && item.account.accountNo == accountNo) {
          item.isDuplicated = _isAccountNoDuplicated(accountNo);
        }
      }
    }

    _refreshView();
  }

  /// check if given [accountNo] is already existed
  bool _isAccountNoDuplicated(String accountNo) {
    bool foundOne = false;
    for (Account item in _accounts) {
      if (accountNo.isNotEmpty && item.accountNo.isNotEmpty && item.accountNo == accountNo) {
        if (foundOne) {
          return true;
        }
        foundOne = true;
      }
    }

    return false;
  }

  /// add or update [Account] to [_accounts] list
  /// @param [Account] item need to add or update
  void _addOrUpdate(Account account, bool needRefresh) {
    int index = -1;
    for(int i = 0; i < _accounts.length; i++) {
      if (_accounts[i].id == account.id) {
        index = i;
        break;
      }
    }

    /// create new display model first
    final AccountDisplayModel displayModel = AccountDisplayModel(account);
    displayModel.isDuplicated = true; // we set it to True first, and we will check it again later
    displayModel.isInvalidFormat = !_regExRule.hasMatch(account.accountNo);

    // not found, we add it to the end
    if (index == -1) {
      _accounts.add(account);
      _displayList.add(displayModel);
    } else {
      // or we just replace the one already existed
      _accounts[index] = account;
      _displayList[index] = displayModel;
    }

    // update item's state
    for (AccountDisplayModel item in _displayList) {
      // for duplicate checking we may update other model
      // so we should check 2 kinds of model
      // 1. has same account number as update model
      // 2. [item.isDuplicated] is true
      if (
        item.account.accountNo == displayModel.account.accountNo ||
        item.isDuplicated
      ) {
        item.isDuplicated = _isAccountNoDuplicated(item.account.accountNo);
      }
    }

    if (needRefresh) _refreshView();
  }

  /// get [Account] by given id
  /// @param [int] account item id
  Account? _getAccountById(int id) {
    for(Account item in _accounts) {
      if (item.id == id) {
        return item;
      }
    }

    return null;
  }

  /// refresh view
  void _refreshView() {
    notifyListeners();
  }

}