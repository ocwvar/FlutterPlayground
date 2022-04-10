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
  final int id;
  final Balance _balance = Balance();
  AccountTypeDetail? _typeDetail;
  Account(this.id);

  String _accountNo = "";
  String get accountNo => _accountNo;
  Balance get balance => _balance;
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

class Balance {
  double _value = 100.0;
  double get value => _value;

  Currency _currency = Currency.hkd;
  Currency get currency => _currency;

  void updateValueWithString(String newValue) {
    _value = double.tryParse(newValue) ?? 0.0;
  }

  void updateValue(double newValue) {
    _value = newValue;
  }

  void updateCurrency(Currency newCurrency) {
    _currency = newCurrency;
  }

  String getDisplayStringWithCurrency() {
    return "${value.toStringAsFixed(3)} ${currency.name.toUpperCase()}";
  }

  String getDisplayString() {
    return value.toStringAsFixed(3);
  }
}