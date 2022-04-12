import 'dart:math';

import 'package:flutter_playground/page/demo_account/models/account_types.dart';

class AccountDisplayModel {
  final Account account;
  bool isDuplicated = false;
  bool isInvalidFormat = false;

  AccountDisplayModel(this.account);
}

class Account {
  final int id;
  AccountTypeDetail? _typeDetail;
  Account(this.id);

  String _accountNo = "";
  String get accountNo => _accountNo;
  AccountTypeDetail? get type => _typeDetail;

  static Account create() {
    return Account(Random().nextInt(100000));
  }

  void updateAccountNo(String newNo) {
    _accountNo = newNo;
  }

  void updateAccountType(AccountTypeDetail typeDetail) {
    _typeDetail = typeDetail;
  }

}