import 'package:flutter/material.dart';
import 'package:foodapp/utilities/cards/store_pic.dart';
import 'package:foodapp/utilities/cards/store_text.dart';
import 'package:foodapp/utilities/cards/stores.dart';

class Body extends StatelessWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Row(
            children: const [
              StoreCard(image: 'assets/images/restaurant.jpg', title: 'Restaurant',),
              StoreCard(image: 'assets/images/drinks.jpg', title: 'Drinks',)
            ],),
        ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Row(
              children: const [
                StorePic(image: "assets/images/grocery_bag.jpg",),
                StorePic(image: "assets/images/pharmacy.jpg",),
                StorePic(image: "assets/images/take_out.jpg",),
              ],),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Row(
              children: const [
                StoreText(title: "Grocery"),
                StoreText(title: "Pharmacy"),
                StoreText(title: "Take Out"),
              ],),
          )
      ],
    );
  }
}