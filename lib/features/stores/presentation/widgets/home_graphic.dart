import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeGraphic extends StatelessWidget {
  final bool isError;
  const HomeGraphic({Key? key, this.isError = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String displayGraphic =
        isError ? Assets.homeErrorGraphic : Assets.homeGraphic;
    String displayText = isError
        ? 'Couldn\'t get your\nlocation'
        : 'Explore nearby\nproducts and stores';
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(displayGraphic),
        Positioned(
          right: 20,
          bottom: 30,
          child: Text(
            displayText,
            style: GoogleFonts.lato(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
