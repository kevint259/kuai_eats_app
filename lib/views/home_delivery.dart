import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/services/auth/auth_exceptions.dart';
import 'package:foodapp/services/auth/auth_services.dart';
import 'package:foodapp/services/auth/bloc/auth_bloc.dart';
import 'package:foodapp/services/auth/bloc/auth_event.dart';
import 'package:foodapp/services/auth/bloc/auth_state.dart';
import 'package:foodapp/utilities/dialogs/error_dialog.dart';
import 'package:foodapp/utilities/dialogs/verify_email_dialog.dart';

class DeliveryView extends StatefulWidget {
  const DeliveryView({Key? key}) : super(key: key);

  @override
  State<DeliveryView> createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  final name = AuthService.firebase().currentUser?.displayName;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedIn) {
          if (!state.isEmailVerified) {
            await showEmailVerificationDialog(
                context, "Remember to verify email!");
          }
        } else if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotLoggedInAuthException) {
            await showErrorDialog(context, "User Not Logged in");
          }
        }
      },
      child: Scaffold(
          body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // padding
              const SizedBox(height: 100),
              // logged in
              Text(
                "Welcome $name!!",
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/albert.jpg'),
                radius: 100,
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                  child: const Text("Logout"),
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))))
            ],
          ),
        ),
      )),
    );
  }
}
