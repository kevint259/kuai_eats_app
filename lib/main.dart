import 'package:flutter/material.dart';
import 'package:foodapp/constants/routes.dart';
import 'package:foodapp/services/auth/auth_services.dart';
import 'package:foodapp/views/home_delivery.dart';
import 'package:foodapp/views/login_view.dart';
import 'package:foodapp/views/register_view.dart';
import 'package:foodapp/views/verify_email.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(MaterialApp(
    title: "Kuai Eats App",
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      deliveryRoute: (context) => const DeliveryView(),
      registerRoute: (context) => const RegisterView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            try {
              user?.reload;
            if (user != null) {
              if (user.isEmailVerified) {
                return const DeliveryView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
            } catch (e) {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
