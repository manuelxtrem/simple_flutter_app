part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthIdle extends AuthState {}

class AuthLoading extends AuthState {
  final String? message;

  const AuthLoading(this.message);
}

class AuthSignInSuccess extends AuthState {
  final String message;

  const AuthSignInSuccess(this.message);
}

class AuthSignInError extends AuthState {
  final String message;

  const AuthSignInError(this.message);
}

class AuthSignUpSuccess extends AuthState {
  final String message;

  const AuthSignUpSuccess(this.message);
}

class AuthSignUpError extends AuthState {
  final String message;

  const AuthSignUpError(this.message);
}

class AuthVerifyEmailSuccess extends AuthState {
  final String message;

  const AuthVerifyEmailSuccess(this.message);
}

class AuthVerifyEmailError extends AuthState {
  final String message;

  const AuthVerifyEmailError(this.message);
}

class AuthVerifyMsisdnSuccess extends AuthState {
  final String message;

  const AuthVerifyMsisdnSuccess(this.message);
}

class AuthVerifyMsisdnError extends AuthState {
  final String message;

  const AuthVerifyMsisdnError(this.message);
}

class AuthResetPasswordSuccess extends AuthState {
  final String message;

  const AuthResetPasswordSuccess(this.message);
}

class AuthResetPasswordError extends AuthState {
  final String message;

  const AuthResetPasswordError(this.message);
}

class AuthResendEmailVerificationCodeSuccess extends AuthState {
  final String message;

  const AuthResendEmailVerificationCodeSuccess(this.message);
}

class AuthResendEmailVerificationCodeError extends AuthState {
  final String message;

  const AuthResendEmailVerificationCodeError(this.message);
}

class AuthLogoutSuccess extends AuthState {
  final String message;

  const AuthLogoutSuccess(this.message);
}

class AuthLogoutError extends AuthState {
  final String message;

  const AuthLogoutError(this.message);
}

class UserActive extends AuthState {
  final Duration timeRemaining;

  const UserActive(this.timeRemaining);
}

class AuthSignInModeSwitch extends AuthState {
  final SignInType signInType;

  const AuthSignInModeSwitch(this.signInType);

  @override
  List<Object> get props => [signInType];
}
