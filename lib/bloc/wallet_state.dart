part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {}

class WalletIdle extends WalletState {}

class WalletLoading extends WalletState {
  final String? message;

  const WalletLoading(this.message);
}

class WalletTransactionsInitial extends WalletState {}

class WalletTransactionsLoading extends WalletState {
  final String message;

  const WalletTransactionsLoading(this.message);

  @override
  List<Object> get props => [message];
}

class WalletCreditSuccess extends WalletState {
  final String message;

  const WalletCreditSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WalletCreditError extends WalletState {
  final String error;

  const WalletCreditError(this.error);

  @override
  List<Object> get props => [error];
}

class WalletWithdrawSuccess extends WalletState {
  final String message;

  const WalletWithdrawSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WalletWithdrawError extends WalletState {
  final String error;

  const WalletWithdrawError(this.error);

  @override
  List<Object> get props => [error];
}

class WalletTransferSuccess extends WalletState {
  final String message;

  const WalletTransferSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WalletTransferError extends WalletState {
  final String error;

  const WalletTransferError(this.error);

  @override
  List<Object> get props => [error];
}

class WalletRequestReversalSuccess extends WalletState {
  final String message;

  const WalletRequestReversalSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WalletRequestReversalError extends WalletState {
  final String error;

  const WalletRequestReversalError(this.error);

  @override
  List<Object> get props => [error];
}

class WalletTransactionsSuccess extends WalletState {
  final String message;

  const WalletTransactionsSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WalletTransactionsError extends WalletState {
  final String message;

  const WalletTransactionsError(this.message);

  @override
  List<Object> get props => [message];
}
