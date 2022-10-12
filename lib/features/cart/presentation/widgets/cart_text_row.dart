// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/app/utilites/format_price.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../../app/utilites/screen_sizes.dart';

class CartTextRow extends StatelessWidget {
  const CartTextRow({required this.title, this.price = 0});

  final String title;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: blockSizeHorizontal(context) * 5,
            color: lightTextColor,
          ),
        ),
        Text(
          formatPrice(price),
          style: GoogleFonts.poppins(
            fontSize: blockSizeHorizontal(context) * 5,
            color: lightTextColor,
          ),
        ),
      ],
    );
  }
}
