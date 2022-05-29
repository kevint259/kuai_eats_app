import 'package:flutter/material.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogIn(this.email, this.password);
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  final String name;
  const AuthEventRegister(this.email, this.password, this.name);
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

class AuthEventGoBack extends AuthEvent {
  const AuthEventGoBack();
}

class AuthEventVerifyEmail extends AuthEvent {
  const AuthEventVerifyEmail();
}

class AuthEventResetPassword extends AuthEvent {
  final String email;
  const AuthEventResetPassword(this.email);
}

class AuthEventForgotPassword extends AuthEvent {
  const AuthEventForgotPassword();
}


