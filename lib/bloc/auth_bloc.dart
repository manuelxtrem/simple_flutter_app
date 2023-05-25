import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_flutter_app/res/constants.dart';
import 'package:simple_flutter_app/res/enums.dart';
import 'package:simple_flutter_app/res/user_settings.dart';
import 'package:simple_flutter_app/res/utils.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserCache userSettings;
  SignInType _signInType = SignInType.email;
  SignInType get signInType => _signInType;

  AuthBloc(this.userSettings) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is SignInAuthEvent) {
        await _signIn(emit, event);
      } else if (event is SignUpAuthEvent) {
        await _signUp(emit, event);
      } else if (event is VerifyEmailAuthEvent) {
        await _verifyEmail(emit, event);
      } else if (event is ResetPasswordAuthEvent) {
        await _resetPassword(emit, event);
      } else if (event is VerifyMsisdnAuthEvent) {
        await _verifyMsisdn(emit, event);
      } else if (event is ResendCodeAuthEvent) {
        await _resendEmailVerificationCode(emit, event);
      } else if (event is ChangeLoginModeAuthEvent) {
        await _changeSignInMode(emit);
      }
    });
  }

  // Retrieve the login status
  bool isLoggedIn() {
    return userSettings.isLoggedIn();
  }

  // submit login credentials
  Future _signIn(Emitter<AuthState> emit, SignInAuthEvent event) async {
    emit(const AuthLoading('signing in to your account'));

    Map<String, String> requestBody = {};

    requestBody = {
      event.signInType.toStringShort(): event.identifier,
      'pswdDoubleInputCheckedMD5': Utils.generateMD5(event.password),
      'uniqueGlobalIdentifier': Utils.generateRandomChar(8),
    };

    try {
      const url = '${Constants.mainUrl}/signin';
      final dio = Dio();
      final response = await dio.post(url, data: requestBody);
      final responseBody = response.data;

      if (response.statusCode == 200 && responseBody['status'] == '0000') {
        userSettings.setLoggedIn(true, responseBody['userId']);
        // refresh states
        emit(const AuthSignInSuccess('Sign in succesful'));
      } else {
        // refresh states
        emit(const AuthSignInError('Sign in failed'));
      }
    } catch (e) {
      // Handle exceptions
      Utils.log('Error: $e');
      emit(AuthSignInError('Sign in failed: ${Utils.detectExceptionMessage(e)}'));
    }
  }

  // sign up user
  Future _signUp(Emitter<AuthState> emit, SignUpAuthEvent event) async {
    emit(const AuthLoading('setting up your account'));

    Map<String, String> requestBody = {};

    requestBody = {
      'email': event.email,
      'fnm': event.firstName,
      'lnm': event.lastName,
      'msisdn': event.msisdn,
      'countryCode': event.countryCode,
      'pswdDoubleInputCheckedMD5': Utils.generateMD5(event.password),
      'uniqueGlobalIdentifier': Utils.generateRandomChar(8),
    };

    try {
      const url = '${Constants.mainUrl}/signup';
      final dio = Dio();
      final response = await dio.post(url, data: requestBody);
      final responseBody = response.data;

      if (response.statusCode == 200 && responseBody['status'] == '0000') {
        // refresh states
        emit(const AuthSignUpSuccess('Sign up succesful'));
      } else {
        // refresh states
        emit(const AuthSignUpError('Sign up failed'));
      }
    } catch (e) {
      // Handle exceptions
      Utils.log('Error: $e');
      emit(AuthSignUpError('Sign up failed: ${Utils.detectExceptionMessage(e)}'));
    }
  }

  // verify email
  Future _verifyEmail(Emitter<AuthState> emit, VerifyEmailAuthEvent event) async {
    emit(const AuthLoading('verifying your email'));

    Map<String, String> requestBody = {};

    requestBody = {
      'userId': Utils.getSha1Hash(event.userId),
      'code': event.verificationCode,
      'uniqueGlobalIdentifier': Utils.generateRandomChar(8),
    };

    try {
      const url = '${Constants.mainUrl}/verifyemail';
      final dio = Dio();
      final response = await dio.post(url, data: requestBody);
      final responseBody = response.data;

      if (response.statusCode == 200 && responseBody['status'] == '0000') {
        // refresh states
        emit(const AuthVerifyEmailSuccess('Email verification succesful'));
      } else {
        // refresh states
        emit(const AuthVerifyEmailError('Email verification failed'));
      }
    } catch (e) {
      // Handle exceptions
      Utils.log('Error: $e');
      emit(AuthVerifyEmailError('Email verification failed: ${Utils.detectExceptionMessage(e)}'));
    }
  }

  // verify phone
  Future _verifyMsisdn(Emitter<AuthState> emit, VerifyMsisdnAuthEvent event) async {
    emit(const AuthLoading('verifying your phone number'));

    Map<String, String> requestBody = {};

    requestBody = {
      'userId': Utils.getSha1Hash(event.userId),
      'code': event.verificationCode,
      'uniqueGlobalIdentifier': Utils.generateRandomChar(8),
    };

    try {
      const url = '${Constants.mainUrl}/verifymsisdn';
      final dio = Dio();
      final response = await dio.post(url, data: requestBody);
      final responseBody = response.data;

      if (response.statusCode == 200 && responseBody['status'] == '0000') {
        // refresh states
        emit(const AuthVerifyMsisdnSuccess('Phone verification succesful'));
      } else {
        // refresh states
        emit(const AuthVerifyMsisdnError('Phone verification failed'));
      }
    } catch (e) {
      // Handle exceptions
      Utils.log('Error: $e');
      emit(AuthVerifyMsisdnError('Phone verification failed: ${Utils.detectExceptionMessage(e)}'));
    }
  }

  // reset password
  Future _resetPassword(Emitter<AuthState> emit, ResetPasswordAuthEvent event) async {
    emit(const AuthLoading('resetting your password'));

    Map<String, String> requestBody = {};

    requestBody = {
      'userId': Utils.getSha1Hash(event.userId),
      'email': event.email,
      'msisdn': event.msisdn,
      'countryCode': event.countryCode,
      'pswdDoubleInputCheckedMD5': Utils.generateMD5(event.password),
      'uniqueGlobalIdentifier': Utils.generateRandomChar(8),
    };

    try {
      const url = '${Constants.mainUrl}/verifymsisdn';
      final dio = Dio();
      final response = await dio.post(url, data: requestBody);
      final responseBody = response.data;

      if (response.statusCode == 200 && responseBody['status'] == '0000') {
        // refresh states
        emit(const AuthResetPasswordSuccess('Password reset succesful'));
      } else {
        // refresh states
        emit(const AuthResetPasswordError('Password reset failed'));
      }
    } catch (e) {
      // Handle exceptions
      Utils.log('Error: $e');
      emit(AuthResetPasswordError('Password reset failed: ${Utils.detectExceptionMessage(e)}'));
    }
  }

  // verify email
  Future _resendEmailVerificationCode(Emitter<AuthState> emit, ResendCodeAuthEvent event) async {
    emit(const AuthLoading('verifying your email'));

    Map<String, String> requestBody = {};

    requestBody = {
      'userId': Utils.getSha1Hash(event.userId),
      'uniqueGlobalIdentifier': Utils.generateRandomChar(8),
    };

    try {
      const url = '${Constants.mainUrl}/resendemailverificationcode';
      final dio = Dio();
      final response = await dio.post(url, data: requestBody);
      final responseBody = response.data;

      if (response.statusCode == 200 && responseBody['status'] == '0000') {
        // refresh states
        emit(const AuthResendEmailVerificationCodeSuccess(
            'Email verification code has been resent'));
      } else {
        // refresh states
        emit(const AuthResendEmailVerificationCodeError('Email verification code resend failed'));
      }
    } catch (e) {
      // Handle exceptions
      Utils.log('Error: $e');
      emit(AuthResendEmailVerificationCodeError(
          'Email verification code resend failed: ${Utils.detectExceptionMessage(e)}'));
    }
  }

  // logout
  Future logout(Emitter<AuthState> emit) async {
    emit(const AuthLoading('closing your session'));

    Map<String, String> requestBody = {};

    requestBody = {
      'uniqueGlobalIdentifier': Utils.generateRandomChar(8),
    };

    try {
      const url = '${Constants.mainUrl}/logout';
      final dio = Dio();
      final response = await dio.post(url, data: requestBody);
      final responseBody = response.data;

      if (response.statusCode == 200 && responseBody['status'] == '0000') {
        // refresh states
        emit(const AuthLogoutSuccess('Logged out succesfully'));
      } else {
        // refresh states
        emit(const AuthLogoutError('Failed to log you out'));
      }
    } catch (e) {
      // Handle exceptions
      Utils.log('Error: $e');
      emit(AuthLogoutError('Failed to log you out: ${Utils.detectExceptionMessage(e)}'));
    }
  }

  Future _changeSignInMode(Emitter<AuthState> emit) async {
    _signInType = (_signInType == SignInType.email) ? SignInType.msisdn : SignInType.email;
    emit(AuthSignInModeSwitch(_signInType));
  }
}
