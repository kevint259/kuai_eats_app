import 'package:equatable/equatable.dart';
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
  final bool isEmailVerified;
  final AuthUser user;
  const AuthStateLoggedIn(this.user, this.isEmailVerified);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}


