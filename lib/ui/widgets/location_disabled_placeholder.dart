import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/app/utilites/screen_sizes.dart';
import 'package:foodadora/ui/widgets/pressable.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationDisabledPlaceholder extends StatelessWidget {
  final Function()? openLocationSettings;
  const LocationDisabledPlaceholder({Key? key, this.openLocationSettings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Please enable location services to see stores near you',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: blockSizeVertical(context) * 2,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        verticalSpaceMedium,
        Center(
          child: Pressable(
            onPressed: openLocationSettings,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.pinLocationIcon,
                  color: actionColor,
                ),
                horizontalSpaceSmall,
                Text(
                  'Enable Location',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: actionColor,
                    fontSize: blockSizeVertical(context) * 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
