import 'package:flutter/material.dart';
import 'package:foodapp/constants/routes.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:foodapp/services/auth/auth_exceptions.dart';
import 'package:foodapp/services/auth/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            SizedBox(
              height: 100,
              width: 200,
              child: Image.asset("assets/images/kuai_logo.jpg"),
            ),

             // Padding
            const SizedBox(
              height: 200,
            ),

            // Welcome back!
            const Text(welcomeBack,
                style: TextStyle(
                  fontSize: 45,
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
                  border: Border.all(color: Colors.black),
                ),
                child: TextFormField(
                  controller: _email,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: email,
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
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

            // email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                ),
                child: TextFormField(
                  controller: _password,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: password,
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
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
                    AuthService.firebase()
                        .logIn(email: email, password: password);
                    final currentUser = AuthService.firebase().currentUser;
                    if (currentUser != null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          deliveryRoute, (route) => false);
                    }
                  } on UserNotFoundAuthException {
                    updateErrorMessage("User Not Found");
                  } on WrongPasswordAuthException {
                    updateErrorMessage("Wrong Password");
                  } on InvalidEmailAuthException {
                    updateErrorMessage("Invalid Email");
                  } on GenericAuthException {
                    updateErrorMessage("Authentication Error");
                  }
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            //Forgot Password?
            TextButton(
              onPressed: () {},
              child: Text(
                forgotPassword,
                style: TextStyle(
                  color: Colors.grey[900],
                ),
              ),
            ),

            // Padding
            const SizedBox(
              height: 100,
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

  updateErrorMessage(String error) {
    setState(() {
      _errorMessage = error;
    });
  }
}
