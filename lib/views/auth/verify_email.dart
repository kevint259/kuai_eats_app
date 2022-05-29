import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/services/auth/bloc/auth_bloc.dart';
import 'package:foodapp/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      context.read<AuthBloc>().add(const AuthEventVerifyEmail());
    },);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEventGoBack());
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
            child: Column(
        children: [
            const SizedBox(height: 100),
            Image.asset('assets/images/email.jpg', 
            width: 100,
            height: 100,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "We've sent you an email!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 200),
            ElevatedButton(onPressed: () {
              
            }, child: const Text("Didn't Get it? Resend Email"),
            style: ElevatedButton.styleFrom(
              elevation: 10,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
            ),)
        ],
      ),
          )),
    );
  }
}
