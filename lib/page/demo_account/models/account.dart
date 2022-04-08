import 'dart:math';

import 'package:flutter_playground/page/demo_account/models/currency.dart';

class AccountDisplayModel {
  final Account account;
  bool isDuplicated = false;
  bool isInvalidFormat = false;

  AccountDisplayModel(this.account);

  void printInfo() {
    print("### isDuplicated[$isDuplicated] isInvalidFormat[$isInvalidFormat] Account.id[${account.id}] Account.no[${account.accountNo}] Balance.value[${account.balance.value}] Balance.currency[${account.balance.currency}]");
  }
}

class Account {
  final int id;
  final Balance _balance = Balance();
  Account(this.id);

  String _accountNo = "";
  String get accountNo => _accountNo;
  Balance get balance => _balance;

  static Account create() {
    return Account(Random().nextInt(100000));
  }

  void updateAccountNo(String newNo) {
    _accountNo = newNo;
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