import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;
  final String? displayName;
  final Future<void> reload;

  const AuthUser(this.isEmailVerified, this.displayName, this.reload);

  factory AuthUser.fromFirebase(User user) => AuthUser(
        user.emailVerified,
        user.displayName,
        user.reload(),
      );
}
