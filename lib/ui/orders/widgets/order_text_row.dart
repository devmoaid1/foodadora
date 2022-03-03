import 'package:flutter/material.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderTextRow extends StatelessWidget {
  final String title;
  final String value;
  const OrderTextRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: blockSizeHorizontal(context) * 5,
            color: const Color(0xffA6A6A6),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: blockSizeHorizontal(context) * 5,
            color: const Color(0xffA6A6A6),
          ),
        ),
      ],
    );
  }
}
