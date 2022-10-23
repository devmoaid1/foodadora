import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/utilites/app_colors.dart';
import '../../../../app/utilites/screen_sizes.dart';

class OrRow extends StatelessWidget {
  const OrRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: (screenWidth(context) / 100) * 10,
          vertical: (screenHeight(context) / 100) * 2),
      child: Row(children: <Widget>[
        const Expanded(
          child: Divider(color: textColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "OR",
            style: GoogleFonts.raleway(
              color: textColor,
              fontSize: (screenWidth(context) / 100) * 4,
            ),
          ),
        ),
        const Expanded(
            child: Divider(
          color: Colors.black,
        )),
      ]),
    );
  }
}
