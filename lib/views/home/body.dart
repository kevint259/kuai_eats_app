import 'package:flutter/material.dart';
import 'package:foodapp/utilities/cards/stores.dart';

class Body extends StatelessWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:10, vertical: 15),
          child: Row(
            children: const [
              StoreCard(image: 'assets/images/restaurant.jpg', title: 'Restaurant',),
              StoreCard(image: 'assets/images/drinks.jpg', title: 'Drinks',)
            ],),
        ),
      ],
    );
  }
}