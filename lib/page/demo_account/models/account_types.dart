class AccountTypeDetail {
  final AccountTypes types;
  final String typeName;
  final String description;

  AccountTypeDetail(this.types, this.typeName, this.description);
}

enum AccountTypes {
  checkingAccount,
  savingsAccount,
  moneyMarketAccount,
  cd,
  ira,
  brokerageAccount
}