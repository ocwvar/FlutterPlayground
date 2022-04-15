import 'package:flutter_playground/page/demo_account/models/account_types.dart';

class AccountTypeModel {
  final List<AccountTypeDetail> _source = [];
  List<AccountTypeDetail> get list => _source;

  void init() {
    _source.clear();
    _source.add(
      AccountTypeDetail(
          AccountTypes.checkingAccount,
          "Checking account",
          "You want unlimited access to your money and you’re not concerned with earning interest."
      )
    );

    _source.add(
        AccountTypeDetail(
            AccountTypes.savingsAccount,
            "Savings account",
            "You don’t need constant access to this money and can afford to leave it in a secure account where it will earn nominal interest."
        )
    );

    _source.add(
        AccountTypeDetail(
            AccountTypes.moneyMarketAccount,
            "Money market account",
            "You want a blend between a checking and savings account and only need limited access to this money each month."
        )
    );

    _source.add(
        AccountTypeDetail(
            AccountTypes.cd,
            "Certificate of deposit (CD)",
            "You want a secure way to invest your money for a set period of time."
        )
    );

    _source.add(
        AccountTypeDetail(
            AccountTypes.ira,
            "Individual retirement arrangement (IRA)",
            "You want a tax-deductible or tax-deferred way to invest your money for retirement."
        )
    );

    _source.add(
        AccountTypeDetail(
            AccountTypes.brokerageAccount,
            "Brokerage account",
            "You want to invest your money but don’t want to be penalized for taking your money out before the age of 59½."
        )
    );
  }

}