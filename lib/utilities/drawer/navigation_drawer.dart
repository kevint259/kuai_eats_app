import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/services/auth/bloc/auth_bloc.dart';
import 'package:foodapp/services/auth/bloc/auth_event.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        width: 275,
        child: ListView(
          children: [
            ListTile(
              onTap: () {},
              hoverColor: Colors.grey,
              leading: CircleAvatar(
                radius: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: Image.asset('assets/images/profile_pic.jpg'),
                ),
              ),
              title: const Text(
                "Albert Lee",
                style: TextStyle(fontSize: 18),
              ),
              subtitle: const Text(
                "View Account",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: Colors.grey[600], thickness: 0.5),
            // MENU ITEMS 
            ListTile(
                leading: const Icon(Icons.verified, color: Colors.blueAccent),
                title: const Text(
                  "Subscription",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                subtitle: const Text(
                  "Save Money on Kuai Pro",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                hoverColor: Colors.grey,
                onTap: () {},
                horizontalTitleGap: 0,
                minLeadingWidth: 50,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 16)),

            ListTile(
                leading:
                    const Icon(Icons.receipt_rounded, color: Colors.blueAccent),
                title: const Text(
                  "Orders",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                hoverColor: Colors.grey,
                onTap: () {},
                horizontalTitleGap: 0,
                minLeadingWidth: 50,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 16)),
            
            ListTile(
                leading: const Icon(Icons.sell, color: Colors.blueAccent),
                title: const Text(
                  "Promotions",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                hoverColor: Colors.grey,
                onTap: () {},
                horizontalTitleGap: 0,
                minLeadingWidth: 50,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 16)),

            ListTile(
                leading: const Icon(Icons.question_mark, color: Colors.blueAccent),
                title: const Text(
                  "Customer Support",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                hoverColor: Colors.grey,
                onTap: () {},
                horizontalTitleGap: 0,
                minLeadingWidth: 50,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 16)),
            
            ListTile(
                leading: const Icon(Icons.handshake, color: Colors.blueAccent),
                title: const Text(
                  "Invite Friends",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                hoverColor: Colors.grey,
                onTap: () {},
                horizontalTitleGap: 0,
                minLeadingWidth: 50,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 16)),

            ListTile(
                leading: const Icon(Icons.credit_card, color: Colors.blueAccent),
                title: const Text(
                  "Wallet",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                hoverColor: Colors.grey,
                onTap: () {},
                horizontalTitleGap: 0,
                minLeadingWidth: 50,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 16)),
            
            ListTile(
                leading: const Icon(Icons.shield_moon, color: Colors.blueAccent),
                title: const Text(
                  "COVID-19 Safety",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                hoverColor: Colors.grey,
                onTap: () {},
                horizontalTitleGap: 0,
                minLeadingWidth: 50,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 16)),
            
            ListTile(
                leading: const Icon(Icons.motorcycle, color: Colors.blueAccent),
                title: const Text(
                  "Join Us",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                hoverColor: Colors.grey,
                onTap: () {},
                horizontalTitleGap: 0,
                minLeadingWidth: 50,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 16)),
            
            ListTile(
                leading: const Icon(Icons.logout, color: Colors.blueAccent),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                hoverColor: Colors.grey,
                onTap: () {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                },
                horizontalTitleGap: 0,
                minLeadingWidth: 50,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 16)),
          ],
        ),
      ),
    );
  }
}
