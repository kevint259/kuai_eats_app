import 'package:foodapp/services/auth/auth_provider.dart';
import 'package:foodapp/services/auth/auth_user.dart';
import 'package:foodapp/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {

  @override
  Future<AuthUser> createUser({required String email, required String password}) => FirebaseAuthProvider().createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => FirebaseAuthProvider().currentUser;

  @override
  Future<void> initialize() => FirebaseAuthProvider().initialize();

  @override
  Future<AuthUser> logIn({required String email, required String password}) => FirebaseAuthProvider().logIn(email: email, password: password);

  @override
  Future<void> logOut() => FirebaseAuthProvider().logOut();

  @override
  Future<void> sendEmailVerification() => FirebaseAuthProvider().sendEmailVerification();
  
}
