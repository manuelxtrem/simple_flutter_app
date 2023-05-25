import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_flutter_app/res/constants.dart';
import 'package:simple_flutter_app/res/user_settings.dart';
import 'package:simple_flutter_app/res/utils.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final UserCache userSettings;
  final transactionList = [];

  WalletBloc(this.userSettings) : super(WalletInitial()) {
    on<WalletEvent>((event, emit) async {
      if (event is TransactionsWalletEvent) {
        await _getWalletTransactions(emit, event);
      } else if (event is CreditWalletEvent) {
        await _walletCredit(emit, event);
      } else if (event is WithdrawWalletEvent) {
        await _walletWithdraw(emit, event);
      } else if (event is TransferWalletEvent) {
        await _walletTransfer(emit, event);
      } else if (event is RequestReversalWalletEvent) {
        await _walletRequestReversal(emit, event);
      }
    });
  }

  Future _getWalletTransactions(Emitter<WalletState> emit, TransactionsWalletEvent event) async {
    emit(const WalletLoading('fetching wallet transactions'));

    Map<String, dynamic> requestBody = {
      'userId': userSettings.getUserId(),
      'pswdDoubleInputCheckedMD5': '',
      'uniqueGlobalIdentifier': Utils.generateRandomChar(8),
    };

    try {
      const url = '${Constants.mainUrl}/dashboard/getwalletinfo';
      final dio = Dio();
      final response = await dio.post(url, data: requestBody);
      final responseBody = response.data;

      if (response.statusCode == 200 && responseBody['status'] == '0000') {
        final walletTransactions = responseBody['wallet'];

        // Refresh states
        emit(WalletTransactionsSuccess(walletTransactions));
      } else {
        // Refresh states
        emit(const WalletTransactionsError('Failed to fetch wallet transactions'));
      }
    } catch (e) {
      // Handle exceptions
      Utils.log('Error: $e');
      emit(WalletTransactionsError(
          'Failed to fetch wallet transactions: ${Utils.detectExceptionMessage(e)}'));
    }
  }

  Future _walletCredit(Emitter<WalletState> emit, CreditWalletEvent event) async {
    emit(const WalletLoading('processing wallet credit'));

    Map<String, dynamic> requestBody = {
      'userId': userSettings.getUserId(),
      'accountType': event.accountType,
      'countryCode': event.countryCode,
      'amount': {
        'currency': event.currency,
        'amount': event.amount,
      },
      'accountDetails': event.accountDetails,
    };

    try {
      const url = '${Constants.mainUrl}/tx/walletcredit';
      final dio = Dio();
      final response = await dio.post(url, data: requestBody);
      final responseBody = response.data;

      if (response.statusCode == 200 && responseBody['status'] == '0000') {
        // Refresh states
        emit(const WalletCreditSuccess('Wallet credited successfully'));
      } else {
        // Refresh states
        emit(const WalletCreditError('Failed to credit wallet'));
      }
    } catch (e) {
      // Handle exceptions
      Utils.log('Error: $e');
      emit(WalletCreditError('Failed to credit wallet: ${Utils.detectExceptionMessage(e)}'));
    }
  }

  Future _walletWithdraw(Emitter<WalletState> emit, WithdrawWalletEvent event) async {
    emit(const WalletLoading('processing wallet withdrawal'));

    Map<String, dynamic> requestBody = {
      'userId': userSettings.getUserId(),
      'accountType': event.accountType,
      'countryCode': event.countryCode,
      'amount': {
        'currency': event.currency,
        'amount': event.amount,
      },
      'accountDetails': event.accountDetails,
    };

    try {
      const url = '${Constants.mainUrl}/tx/walletwithdraw';
      final dio = Dio();
      final response = await dio.post(url, data: requestBody);
      final responseBody = response.data;

      if (response.statusCode == 200 && responseBody['status'] == '0000') {
        // Refresh states
        emit(const WalletWithdrawSuccess('Wallet withdrawal successful'));
      } else {
        // Refresh states
        emit(const WalletWithdrawError('Failed to withdraw from wallet'));
      }
    } catch (e) {
      // Handle exceptions
      Utils.log('Error: $e');
      emit(WalletWithdrawError(
          'Failed to withdraw from wallet: ${Utils.detectExceptionMessage(e)}'));
    }
  }

  Future _walletTransfer(Emitter<WalletState> emit, TransferWalletEvent event) async {
    emit(const WalletLoading('processing wallet transfer'));

    Map<String, dynamic> requestBody = {
      'userId': userSettings.getUserId(),
      'accountType': event.accountType,
      'countryCode': event.countryCode,
      'amount': {
        'currency': event.currency,
        'amount': event.amount,
      },
      'accountDetails': event.accountDetails,
    };

    try {
      const url = '${Constants.mainUrl}/tx/wallettransfer';
      final dio = Dio();
      final response = await dio.post(url, data: requestBody);
      final responseBody = response.data;

      if (response.statusCode == 200 && responseBody['status'] == '0000') {
        // Refresh states
        emit(const WalletTransferSuccess('Wallet transfer successful'));
      } else {
        // Refresh states
        emit(const WalletTransferError('Failed to transfer from wallet'));
      }
    } catch (e) {
      // Handle exceptions
      Utils.log('Error: $e');
      emit(WalletTransferError(
          'Failed to transfer from wallet: ${Utils.detectExceptionMessage(e)}'));
    }
  }

  Future _walletRequestReversal(Emitter<WalletState> emit, RequestReversalWalletEvent event) async {
    emit(const WalletLoading('processing wallet reversal'));

    Map<String, dynamic> requestBody = {
      'userId': userSettings.getUserId(),
      'accountType': event.accountType,
      'countryCode': event.countryCode,
      'amount': {
        'currency': event.currency,
        'amount': event.amount,
      },
      'accountDetails': event.accountDetails,
    };

    try {
      const url = '${Constants.mainUrl}/cs/walletrequestreversal';
      final dio = Dio();
      final response = await dio.post(url, data: requestBody);
      final responseBody = response.data;

      if (response.statusCode == 200 && responseBody['status'] == '0000') {
        // Refresh states
        emit(const WalletRequestReversalSuccess('Wallet reversal request successful'));
      } else {
        // Refresh states
        emit(const WalletRequestReversalError('Failed to request wallet reversal'));
      }
    } catch (e) {
      // Handle exceptions
      Utils.log('Error: $e');
      emit(WalletRequestReversalError(
          'Failed to request wallet reversal: ${Utils.detectExceptionMessage(e)}'));
    }
  }
}
