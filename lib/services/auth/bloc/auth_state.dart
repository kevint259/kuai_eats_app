import 'package:flutter/material.dart';
import 'package:foodapp/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized();
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering(this.exception);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateVerifyEmail extends AuthState {
  const AuthStateVerifyEmail();
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  final bool forgotPassword;
  const AuthStateLoggedOut({required this.exception, required this.forgotPassword});

}


