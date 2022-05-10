import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

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
                    style: GoogleFonts.boogaloo(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "EATS",
                    style: GoogleFonts.boogaloo(
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

              // Welcome back! 歡迎回來
              const Text("歡迎回來!",
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
                  child: TextField(
                    controller: _email,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
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
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      contentPadding: EdgeInsets.only(left: 20.0),
                    ),
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                ),
              ),

              //Forgot Password?
              Padding(
                padding: const EdgeInsets.only(left: 200),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                  ),
                ),
              ),

              // Padding
              const SizedBox(
                height: 15,
              ),

              //sign in button
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              //Not a member? Register here!
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Not a member?",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Register here.",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
