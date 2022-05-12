import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/routes.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // only for dummy purposes (link isn't real terms and conditions)
  final Uri _url = Uri.parse(termsLink);
  String _errorMessage = '';
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _passwordConfirmation;

  @override
  void initState() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _passwordConfirmation = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _passwordConfirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            // SIGN UP HERE TEXT
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text(
                  signUpHere,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Padding
            const SizedBox(height: 30),

            // First Name
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextFormField(
                    controller: _firstName,
                    decoration: const InputDecoration(
                      hintText: firstName,
                      prefixIcon: Icon(Icons.account_circle_outlined),
                    )),
              ),
            ),

            // Padding
            const SizedBox(height: 15),

            // Last Name
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextFormField(
                    controller: _lastName,
                    decoration: const InputDecoration(
                      hintText: lastName,
                      prefixIcon: Icon(Icons.account_circle_outlined),
                    )),
              ),
            ),

            // Padding
            const SizedBox(height: 15),

            // Email
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      hintText: email,
                      prefixIcon: Icon(Icons.email_outlined),
                    )),
              ),
            ),

            // Padding
            const SizedBox(height: 15),

            // Password
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextFormField(
                    obscureText: true,
                    controller: _password,
                    decoration: const InputDecoration(
                      hintText: password,
                      prefixIcon: Icon(Icons.key_outlined),
                    )),
              ),
            ),

            // Padding
            const SizedBox(height: 15),

            // Confirm Password
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextFormField(
                    obscureText: true,
                    controller: _passwordConfirmation,
                    decoration: const InputDecoration(
                      hintText: confirmPassword,
                      prefixIcon: Icon(Icons.key_outlined),
                    )),
              ),
            ),

            // Padding
            const SizedBox(height: 20),

            //Error Message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                _errorMessage,
                style: const TextStyle(
                    color: Colors.red, 
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),

            // Padding
            const SizedBox(height: 20),

            // Sign Up Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 12.0,
                padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 10),
                shadowColor: Colors.blue[400],
                primary: Colors.blue[700],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () async {
                try {
                  // verify password the same
                  final password = _password.text;
                  final passwordConfirmation = _passwordConfirmation.text;
                  if (validatePassword(password, passwordConfirmation) ==
                      null) {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _email.text, password: _password.text);
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email.text, password: _password.text);
                    Navigator.of(context).pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
                  } else {
                    setState(() {
                      _errorMessage =
                          validatePassword(password, passwordConfirmation)
                              .toString();
                    });
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'invalid-email') {
                    setState(() {
                      _errorMessage = "Invalid Email";
                    });
                  }
                }
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              
            ),

            // Padding
            const SizedBox(
              height: 25,
            ),

            // Terms and conditions
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: "By clicking Sign up you agree to our ",
                    ),
                    TextSpan(
                      text: "Terms and Conditions ",
                      recognizer: TapGestureRecognizer()
                        ..onTap = (() async {
                          if (await canLaunchUrl(_url)) {
                            await launchUrl(_url);
                          } else {
                            throw "Could not launch $_url";
                          }
                        }),
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    const TextSpan(text: "and "),
                    TextSpan(
                      text: "Privacy Policy",
                      recognizer: TapGestureRecognizer()
                        ..onTap = (() async {
                          if (await canLaunchUrl(_url)) {
                            await launchUrl(_url);
                          } else {
                            throw "Could not launch $_url";
                          }
                        }),
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String? validatePassword(String pass1, String pass2) {
  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,20}$');
  if (pass1.isEmpty || pass2.isEmpty) {
    return enterPasswordText;
  } else {
    if (!regex.hasMatch(pass1) && (pass1 == pass2)) {
      return validPasswordText;
    } else {
      return null;
    }
  }
}
