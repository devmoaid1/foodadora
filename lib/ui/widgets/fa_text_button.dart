import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class FATextButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Color color;
  const FATextButton({
    this.color = actionColor,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: onPressed,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                  color: color, fontWeight: FontWeight.bold, fontSize: 12),
            ))
        : TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => color.withOpacity(.1)),
            ),
            onPressed: onPressed,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                  color: color, fontWeight: FontWeight.bold, fontSize: 12),
            ));
  }
}
