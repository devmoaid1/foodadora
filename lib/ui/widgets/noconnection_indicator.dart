import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/constants/assets.dart';
import '../../app/utilites/app_colors.dart';
import '../../app/utilites/screen_sizes.dart';
import 'foodadora_button.dart';

class NoConnection extends StatelessWidget {
  final void Function()? handleRetry;
  const NoConnection({Key? key, this.handleRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: SvgPicture.asset(Assets.noWifi)),
        SizedBox(
          height: blockSizeHorizontal(context) * 2,
        ),
        Text(
          'connect to the internet',
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: blockSizeVertical(context) * 2.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: blockSizeHorizontal(context) * 2,
        ),
        Text(
          'You’re offilne. Check yout connection.',
          style: GoogleFonts.poppins(
            color: lightTextColor,
            fontSize: blockSizeVertical(context) * 2,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: blockSizeHorizontal(context) * 15,
              vertical: blockSizeVertical(context) * 5),
          child: FoodadoraButton(
              label: "TAP TO RETRY",
              color: actionColor,
              onPressed: handleRetry ?? () {}),
        )
      ],
    );
  }
}
