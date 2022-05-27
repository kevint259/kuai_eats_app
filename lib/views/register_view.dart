import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/constants/routes.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:foodapp/services/auth/auth_exceptions.dart';
import 'package:foodapp/services/auth/auth_services.dart';
import 'package:foodapp/services/auth/bloc/auth_bloc.dart';
import 'package:foodapp/services/auth/bloc/auth_event.dart';
import 'package:foodapp/services/auth/bloc/auth_state.dart';
import 'package:foodapp/utilities/dialogs/error_dialog.dart';
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
  late final TextEditingController _displayName;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _displayName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _displayName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, "Weak Password");
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, "Email Already in Use");
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, "Invalid Email");
          } else {
            await showErrorDialog(context, "Register Error");
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: const Text(
            "Register",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.white,
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

              // Display Name
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
                      controller: _displayName,
                      decoration: const InputDecoration(
                        hintText: displayName,
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
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
                        hintText: emailRegister,
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
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
                        hintText: passwordRegister,
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(Icons.key_outlined),
                      )),
                ),
              ),

              // Padding
              const SizedBox(height: 15),

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 140, vertical: 10),
                  shadowColor: Colors.blue[400],
                  primary: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  final name = _displayName.text;
                  context.read<AuthBloc>().add(AuthEventRegister(
                        email,
                        password,
                        name,
                      ));
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
                              throw "Could not launch ";
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
      ),
    );
  }

  updateErrorMessage(String error) {
    setState(() {
      _errorMessage = error;
    });
  }
}
