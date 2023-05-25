part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInAuthEvent extends AuthEvent {
  final SignInType signInType;
  final String identifier;
  final String password;

  const SignInAuthEvent(this.signInType, this.identifier, this.password);
}

class SignUpAuthEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String msisdn;
  final String countryCode;
  final String password;

  const SignUpAuthEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.msisdn,
    required this.countryCode,
    required this.password,
  });
}

class VerifyEmailAuthEvent extends AuthEvent {
  final String userId;
  final String verificationCode;

  const VerifyEmailAuthEvent({
    required this.userId,
    required this.verificationCode,
  });
}

class ResetPasswordAuthEvent extends AuthEvent {
  final String userId;
  final String email;
  final String msisdn;
  final String countryCode;
  final String password;

  const ResetPasswordAuthEvent({
    required this.userId,
    required this.email,
    required this.msisdn,
    required this.countryCode,
    required this.password,
  });
}

class VerifyMsisdnAuthEvent extends AuthEvent {
  final String userId;
  final String verificationCode;

  const VerifyMsisdnAuthEvent({
    required this.userId,
    required this.verificationCode,
  });
}

class ResendCodeAuthEvent extends AuthEvent {
  final String userId;

  const ResendCodeAuthEvent({
    required this.userId,
  });
}

class LogoutAuthEvent extends AuthEvent {}

class ChangeLoginModeAuthEvent extends AuthEvent {}
