import 'package:foodapp/services/auth/auth_provider.dart';
import 'package:foodapp/services/auth/auth_user.dart';
import 'package:foodapp/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final FirebaseAuthProvider provider;
  AuthService(this.provider);

  // create a factory
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider(),);
  

  @override
  Future<AuthUser> createUser({required String email, required String password}) => provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> logIn({required String email, required String password}) => provider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> updateDisplayName({required String name}) => provider.updateDisplayName(name: name);
  
}
