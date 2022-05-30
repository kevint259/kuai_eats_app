
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreCard extends StatelessWidget {
  final String title, image;
  const StoreCard({ Key? key, required this.title, required this.image }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // currently tells me the size of the screen
    final screenSize = MediaQuery.of(context).size;
    log(screenSize.toString());
    return InkWell(
      onTap: () {
        log("CONTAINER PRESSED");
      },
      child: Container(
        width: 165,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TEXT
            Text(title,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500, 
            ),),
    
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(image,
                height: 50,
                width: 70,),
              ],)
          ]),
      ),
    );
  }
}