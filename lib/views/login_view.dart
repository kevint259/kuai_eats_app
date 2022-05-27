import 'package:flutter/material.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:foodapp/services/auth/auth_exceptions.dart';
import 'package:foodapp/services/auth/bloc/auth_bloc.dart';
import 'package:foodapp/services/auth/bloc/auth_event.dart';
import 'package:foodapp/services/auth/bloc/auth_state.dart';
import 'package:foodapp/utilities/dialogs/error_dialog.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context, "User Not Found");
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, "Wrong Credentials");
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, "Invalid Email");
          } else {
            await showErrorDialog(context, "Login Error");
          }
        }
      },
      child: Scaffold(
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
                    validator: EmailValidator(
                        errorText: "Enter a valid email address"),
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
                    obscureText: true,
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
                    validator: MinLengthValidator(6,
                        errorText: "At least 6 characters"),
                  ),
                ),

                // Padding
                const SizedBox(
                  height: 20,
                ),

                //sign in button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 12.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12),
                    shadowColor: Colors.blue[400],
                    primary: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    context.read<AuthBloc>().add(AuthEventLogIn(
                          email,
                          password,
                        ));
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                        context.read<AuthBloc>().add(const AuthEventShouldRegister());
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
