part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class TransactionsWalletEvent extends WalletEvent {
  final List list;

  const TransactionsWalletEvent(this.list);

  @override
  List<Object> get props => [list];
}

class CreditWalletEvent extends WalletEvent {
  final String accountType;
  final String countryCode;
  final String currency;
  final double amount;
  final Map<String, dynamic> accountDetails;

  const CreditWalletEvent({
    required this.accountType,
    required this.countryCode,
    required this.currency,
    required this.amount,
    required this.accountDetails,
  });

  @override
  List<Object> get props => [accountType, countryCode, currency, amount, accountDetails];
}

class WithdrawWalletEvent extends WalletEvent {
  final String accountType;
  final String countryCode;
  final String currency;
  final double amount;
  final Map<String, dynamic> accountDetails;

  const WithdrawWalletEvent({
    required this.accountType,
    required this.countryCode,
    required this.currency,
    required this.amount,
    required this.accountDetails,
  });

  @override
  List<Object> get props => [accountType, countryCode, currency, amount, accountDetails];
}

class TransferWalletEvent extends WalletEvent {
  final String accountType;
  final String countryCode;
  final String currency;
  final double amount;
  final Map<String, dynamic> accountDetails;

  const TransferWalletEvent({
    required this.accountType,
    required this.countryCode,
    required this.currency,
    required this.amount,
    required this.accountDetails,
  });

  @override
  List<Object> get props => [accountType, countryCode, currency, amount, accountDetails];
}

class RequestReversalWalletEvent extends WalletEvent {
  final String accountType;
  final String countryCode;
  final String currency;
  final double amount;
  final Map<String, dynamic> accountDetails;

  const RequestReversalWalletEvent({
    required this.accountType,
    required this.countryCode,
    required this.currency,
    required this.amount,
    required this.accountDetails,
  });

  @override
  List<Object> get props => [accountType, countryCode, currency, amount, accountDetails];
}
