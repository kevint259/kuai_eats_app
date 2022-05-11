import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                child: Text("Sign up here.",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
              ),
            ),

            // Padding
            const SizedBox(height: 30),

            // First Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "First Name",
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    
                  )
                ),
              ),
            ),

             // Padding
            const SizedBox(height: 15),

            // Last Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Last Name",
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    
                  )
                ),
              ),
            ),


            // Padding
            const SizedBox(height: 15),

            // Email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    
                  )
                ),
              ),
            ),
            // Password

            // Confirm Password
          ],
        ),
      ),
    );
  }
}
