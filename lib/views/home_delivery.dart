import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/constants/routes.dart';
import 'package:foodapp/services/auth/auth_services.dart';
import 'package:foodapp/services/auth/bloc/auth_bloc.dart';
import 'package:foodapp/services/auth/bloc/auth_event.dart';

class DeliveryView extends StatefulWidget {
  const DeliveryView({Key? key}) : super(key: key);

  @override
  State<DeliveryView> createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const Text("YOU LOGGED IN!!"),
          const SizedBox(height: 100),
          TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text("Logout"))
        ],
      ),
    ));
  }
}
