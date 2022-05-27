import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/services/auth/auth_provider.dart';
import 'package:foodapp/services/auth/bloc/auth_event.dart';
import 'package:foodapp/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {
    // send email verification
    on<AuthEventSendEmailVerification>(
      (event, emit) async {
        await provider.sendEmailVerification();
        final user = provider.currentUser;
        if (user == null) {
          emit(const AuthStateLoggedOut(exception: null));
        } else if (user.isEmailVerified) {
          emit(AuthStateLoggedIn(user));
        } else {
          emit(state);
        }
      },
    );

    // register
    on<AuthEventRegister>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        final name = event.name;
        try {
          await provider.createUser(email: email, password: password);
          await provider.updateDisplayName(name: name);
          emit(const AuthStateNeedsVerification());
        } on Exception catch (e) {
          emit(AuthStateRegistering(e));
        }
      },
    );

    // initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(exception: null));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });
    // logging in
    on<AuthEventLogIn>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        try {
          final user = await provider.logIn(
            email: email,
            password: password,
          );
          if (!user.isEmailVerified) {
            emit(AuthStateLoggedIn(user));
          } else {
            emit(const AuthStateNeedsVerification());
          }
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(exception: e));
        }
      },
    );
    // logging out
    on<AuthEventLogOut>(
      (event, emit) async {
        try {
          await provider.logOut();
          emit(const AuthStateLoggedOut(exception: null));
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(exception: e));
        }
      },
    );
  }
}
