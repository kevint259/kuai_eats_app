import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:foodapp/services/auth/bloc/auth_bloc.dart';
import 'package:foodapp/services/auth/bloc/auth_event.dart';
import 'package:foodapp/services/auth/firebase_auth_provider.dart';

Future<void> showResetPasswordDialog(
  BuildContext context,
) async {
  final _email = TextEditingController();
  return showDialog(
      context: context,
      builder: (context2) {
        return BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(FirebaseAuthProvider()),
          child: AlertDialog(
            title: const Text(
              "Reset Password",
              textAlign: TextAlign.center,
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text(
                "Please specify your email address to receive instructions for resetting it. If an account exists by that email, you will receieve an email.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  fillColor: Colors.grey[300],
                  filled: true,
                  hintText: email,
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              )
            ]),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<AuthBloc>().add(const AuthEventGoBack());
                      _email.clear();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context
                          .read<AuthBloc>()
                          .add(AuthEventResetPassword(_email.text));
                      _email.clear();
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      });
}
