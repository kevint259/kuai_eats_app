import 'package:foodapp/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<void> logOut();

  AuthUser? get currentUser;

  Future<void> sendEmailVerification();

  Future<void> resetPassword({
    required String email,
  });

  Future<void> initialize();

  Future<void> updateDisplayName({
    required String name,
  });
}
