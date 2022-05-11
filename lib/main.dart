
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/routes.dart';
import 'package:foodapp/views/home_delivery.dart';
import 'package:foodapp/views/login_view.dart';
import 'package:foodapp/views/register_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(
    MaterialApp(
      title: "Yummy Eats App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        deliveryRoute:(context) => const DeliveryView(),
        registerRoute: (context) => const RegisterView(),
      },
    )
  );
}

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done: 
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              return const LoginView();
            } else {
              return const LoginView();
            }
          default: 
            return const CircularProgressIndicator();
        } 
      },
  
    );
  }
}