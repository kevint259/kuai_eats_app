import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/routes.dart';
import 'package:foodapp/constants/texts.dart';

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
              "Thanks for Registering!",
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
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text(
                "Verify Email",
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
    final user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    if (user?.emailVerified ?? false) {
      timer.cancel();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(deliveryRoute, (route) => false);
    } 
  }
}
