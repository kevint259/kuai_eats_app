import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/routes.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  String _errorMessage = '';
  final bool errorMessage = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            // yummy delivery title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "FLASH",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  "EATS",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            // Padding
            const SizedBox(
              height: 30.0,
            ),

            // picture
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/delivery.jpg'),
              radius: 120,
            ),
            const SizedBox(height: 40),

            // Welcome back! 
            const Text(welcomeBack,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w400,
                )),

            // Padding
            const SizedBox(
              height: 20,
            ),

            // email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  controller: _email,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: email,
                    contentPadding: EdgeInsets.only(left: 20.0),
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),
            ),

            // Padding
            const SizedBox(
              height: 15,
            ),

            // password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: password,
                    contentPadding: EdgeInsets.only(left: 20.0),
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),
            ),

            // Padding
            const SizedBox(
              height: 10,
            ),

            //Error Message
            Text(
              _errorMessage,
              style: const TextStyle(
                  color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Padding
            const SizedBox(
              height: 40,
            ),

            //sign in button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    final currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          deliveryRoute, (route) => false);
                    }
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      _errorMessage = validate(e.code);
                    });
                    log(e.code);
                  }
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            //Forgot Password?
            TextButton(
              onPressed: () {},
              child: const Text(
                forgotPassword,
              ),
            ),

            // Padding
            const SizedBox(
              height: 50,
            ),

            //Not a member? Register here!
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  dontHaveAccount,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  child: const Text(
                    registerHere,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute, (route) => false);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

String validate(String value) {
  if (value == "invalid-email") {
    return "Please enter valid email address";
  } else if (value == '') {
    return "Fields can't be empty";
  } else if (value == 'wrong-password') {
    return "Password can't be empty";
  } else {
    return "User Not Found";
  }
}
