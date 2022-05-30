
import 'package:flutter/material.dart';

class StorePic extends StatelessWidget {
  final String image;
  const StorePic({ Key? key, required this.image }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 100,
        width: 310/3,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(25),
        child: Image.asset(image),
        decoration: BoxDecoration(
          color: const Color(0xFFD7D7D6),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 5,
              color: Color(0xFFA9A9A9),
            )
          ]
        ),
      ),
    );
  }
}