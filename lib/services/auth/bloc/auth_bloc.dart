import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/services/auth/auth_provider.dart';
import 'package:foodapp/services/auth/bloc/auth_event.dart';
import 'package:foodapp/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {

    // Back Button
    on<AuthEventGoBack>((event, emit) {
      emit(const AuthStateLoggedOut(exception: null));
    },);

    // should register button
    on<AuthEventShouldRegister>((event, emit) {
      emit(const AuthStateRegistering(null));
    },);

    // register
    on<AuthEventRegister>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        final name = event.name;
        try {
          await provider.createUser(email: email, password: password);
          await provider.updateDisplayName(name: name);
          await provider.sendEmailVerification();
          final user = provider.currentUser;
          if (user == null) {
            emit(state);
          } else {
            emit(AuthStateLoggedIn(user, user.isEmailVerified));
          }
        } on Exception catch (e) {
          log(e.toString());
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
      } else {
        emit(AuthStateLoggedIn(user, user.isEmailVerified));
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
          emit(AuthStateLoggedIn(user, user.isEmailVerified));
        } on Exception catch (e) {
          log(e.toString());
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
          log(e.toString());
          emit(AuthStateLoggedOut(exception: e));
        }
      },
    );
  }
}
