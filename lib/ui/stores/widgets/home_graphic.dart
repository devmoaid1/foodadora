import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeGraphic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(Assets.homeGraphic),
        Positioned(
          right: 15,
          bottom: 35,
          child: Text(
            'Explore nearby\nproducts and stores',
            style: GoogleFonts.lato(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
