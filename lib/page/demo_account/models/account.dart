import 'dart:math';

import 'package:flutter_playground/page/demo_account/models/account_types.dart';
import 'package:flutter_playground/page/demo_account/models/currency.dart';

class AccountDisplayModel {
  final Account account;
  bool isDuplicated = false;
  bool isInvalidFormat = false;

  AccountDisplayModel(this.account);
}

class Account {
  Account(this.id);
  final int id;

  AccountTypeDetail? _typeDetail;
  AccountTypeDetail? get type => _typeDetail;

  Currency? _currency;
  Currency? get currency => _currency;

  String _accountNo = "";
  String get accountNo => _accountNo;


  static Account create() {
    return Account(Random().nextInt(100000));
  }

  void updateAccountNo(String newNo) {
    _accountNo = newNo;
  }

  void updateAccountType(AccountTypeDetail typeDetail) {
    _typeDetail = typeDetail;
  }

  void updateCurrencyType(Currency currency) {
    _currency = currency;
  }

}