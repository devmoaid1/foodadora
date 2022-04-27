import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/constants/assets.dart';
import '../../app/utilites/app_colors.dart';
import '../../app/utilites/screen_sizes.dart';
import 'foodadora_button.dart';

class EmptyStoresPlaceholder extends StatelessWidget {
  final void Function()? function;
  const EmptyStoresPlaceholder({Key? key, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.emptyStores),
        verticalSpaceRegular,
        Text(
          'No stores nearby, please check again later.',
          textAlign: TextAlign.center,
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
          'Our team is working to list more stores soon. Stay tuned!',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: blockSizeVertical(context) * 2,
            fontWeight: FontWeight.w300,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: blockSizeHorizontal(context) * 15,
              vertical: blockSizeVertical(context) * 5),
          child: FoodadoraButton(
              label: "Notify Me".toUpperCase(),
              color: actionColor,
              onPressed: function ?? () {}),
        )
      ],
    );
  }
}
