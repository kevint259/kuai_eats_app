import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/services/auth/auth_provider.dart';
import 'package:foodapp/services/auth/bloc/auth_event.dart';
import 'package:foodapp/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {

    // Back Button
    on<AuthEventGoBack>((event, emit) {
      emit(const AuthStateLoggedOut(exception: null, forgotPassword: false));
    },);

    // should register button
    on<AuthEventShouldRegister>((event, emit) {
      emit(const AuthStateRegistering(null));
    },);

    // verify email
    on<AuthEventVerifyEmail>((event, emit) async {
      final user = provider.currentUser;
      await user?.reload;
      if (user != null) {
        if (user.isEmailVerified) {
          emit(AuthStateLoggedIn(user));
        } else {
          emit(state);
        }
      } else {
        emit(const AuthStateLoggedOut(exception: null, forgotPassword: false));
      }
    },);

    // reset password
    on<AuthEventResetPassword>((event, emit) async {
      try {
        await provider.resetPassword(email: event.email);
        emit(const AuthStateLoggedOut(exception: null, forgotPassword: false));
      } on Exception catch (e) {
        log(e.toString());
        emit(AuthStateLoggedOut(exception: e, forgotPassword: false));
      }
    },);

    // forgot password
    on<AuthEventForgotPassword>((event, emit) {
      emit(const AuthStateLoggedOut(exception: null, forgotPassword: true));
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
            emit(const AuthStateVerifyEmail());
          } else {
            if (user.isEmailVerified) {
              emit(AuthStateLoggedIn(user));
            } else {
              emit(const AuthStateVerifyEmail());
            }
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
        emit(const AuthStateLoggedOut(exception: null, forgotPassword: false));
      } else {
        if (user.isEmailVerified) {
          emit(AuthStateLoggedIn(user));
        } else {
          emit(const AuthStateVerifyEmail());
        }
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
          if (user.isEmailVerified) {
            emit(AuthStateLoggedIn(user));
          } else {
            emit(const AuthStateVerifyEmail());
          }
        } on Exception catch (e) {
          log(e.toString());
          emit(AuthStateLoggedOut(exception: e, forgotPassword: false));
        }
      },
    );
    // logging out
    on<AuthEventLogOut>(
      (event, emit) async {
        try {
          await provider.logOut();
          emit(const AuthStateLoggedOut(exception: null, forgotPassword: false));
        } on Exception catch (e) {
          log(e.toString());
          emit(AuthStateLoggedOut(exception: e, forgotPassword: false));
        }
      },
    );
  }
}
