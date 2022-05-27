import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:foodapp/services/auth/auth_services.dart';
import 'package:foodapp/services/auth/bloc/auth_bloc.dart';
import 'package:foodapp/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          // padding
          const SizedBox(
            height: 200,
          ),

          // Text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 65),
            child: Text(
              registerText,
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // padding
          const SizedBox(
            height: 50,
          ),

          // Text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              verifyEmailText,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

          // padding
          const SizedBox(
            height: 50,
          ),

          ElevatedButton(
              onPressed: ()  {
                context.read<AuthBloc>().add(const AuthEventSendEmailVerification());
              },
              child: const Text(
                verifyEmail,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[700],
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                shadowColor: Colors.blue[300],
              )),
        ],
      )),
    );
  }

}
