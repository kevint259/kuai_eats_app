import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/routes.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:foodapp/services/auth/auth_services.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late final Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
              onPressed: () async {
                // verifies user's email
                AuthService.firebase().sendEmailVerification();
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

  Future<void> checkEmailVerified() async {
    final user = AuthService.firebase().currentUser;
    user?.reload;
    if (user?.isEmailVerified ?? false) {
      timer.cancel();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(deliveryRoute, (route) => false);
    }
  }
}
