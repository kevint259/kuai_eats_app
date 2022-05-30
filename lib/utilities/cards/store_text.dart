
import 'package:flutter/material.dart';

class StoreText extends StatelessWidget {
  final String title;
  const StoreText({ Key? key, required this.title }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 310/3,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500
      ),),
    );
  }
}