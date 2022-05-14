import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;
  final String? displayName;

  const AuthUser(this.isEmailVerified, this.displayName);

  factory AuthUser.fromFirebase(User user) => AuthUser(
        user.emailVerified,
        user.displayName,
      );
      
}
