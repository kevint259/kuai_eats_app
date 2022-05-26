import 'package:flutter/material.dart';
import 'package:foodapp/constants/routes.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:foodapp/services/auth/auth_exceptions.dart';
import 'package:foodapp/services/auth/auth_services.dart';
import 'package:foodapp/utilities/error_message.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
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
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            children: [
              // Logo
              SizedBox(
                height: 100,
                width: 200,
                child: Image.asset(kuaiLogo),
              ),

              // Padding
              const SizedBox(
                height: 150,
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
                child: TextFormField(
                  controller: _email,
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: emailLogin,
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    contentPadding: const EdgeInsets.only(left: 20.0),
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: EmailValidator(errorText: "Enter a valid email address"),
                ),
              ),

              // Padding
              const SizedBox(
                height: 15,
              ),

              // password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: _password,
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: passwordLogin,
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    contentPadding: const EdgeInsets.only(left: 20.0),
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: MinLengthValidator(6, errorText: "At least 6 characters"),
                ),
              ),

              // Padding
              const SizedBox(
                height: 50,
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
                      throw UserNotFoundAuthException();
                    } on WrongPasswordAuthException {
                      throw WrongPasswordAuthException();
                    } on InvalidEmailAuthException {
                      throw InvalidEmailAuthException();
                    } on GenericAuthException {
                      throw GenericAuthException();
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
      ),
    );
  }

}
