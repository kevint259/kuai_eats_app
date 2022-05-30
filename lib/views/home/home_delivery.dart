import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/services/auth/auth_exceptions.dart';
import 'package:foodapp/services/auth/auth_services.dart';
import 'package:foodapp/services/auth/bloc/auth_bloc.dart';
import 'package:foodapp/services/auth/bloc/auth_state.dart';
import 'package:foodapp/utilities/dialogs/error_dialog.dart';
import 'package:foodapp/utilities/drawer/navigation_drawer.dart';
import 'package:foodapp/views/home/body.dart';

class DeliveryView extends StatefulWidget {
  const DeliveryView({Key? key}) : super(key: key);

  @override
  State<DeliveryView> createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  final name = AuthService.firebase().currentUser?.displayName;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotLoggedInAuthException) {
            await showErrorDialog(context, "User Not Logged in");
          }
        }
      },
      child: Scaffold(
          drawer: const NavigationDrawerWidget(),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.grey[300],
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Food, groceries, drinks, etc",
                    filled: true,
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
            centerTitle: true,
            title: Column(
              children: [
                Text(
                  "Home".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "新北市工建路98號",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                )
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  iconSize: 20),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag),
                iconSize: 20,
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              children: const [
                Body()
              ],
            ),
          )),
    );
  }
}
