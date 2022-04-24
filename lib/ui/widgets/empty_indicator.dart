import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/ui/widgets/pressable.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../app/constants/assets.dart';
import '../../app/constants/services_instances.dart';
import '../../app/utilites/app_colors.dart';
import '../../app/utilites/enums.dart';
import '../../app/utilites/screen_sizes.dart';

class EmptyIndicator extends StatelessWidget {
  final WidgetType widgetType;
  const EmptyIndicator({Key? key, required this.widgetType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.emptyIcon),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: blockSizeVertical(context) * 5,
                horizontal: blockSizeHorizontal(context) * 9),
            child: widgetType == WidgetType.cart
                ? Text(
                    'You have no items in your cart yet.\nCan we take you to Home ?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                        fontSize: blockSizeHorizontal(context) * 4,
                        fontWeight: FontWeight.w600,
                        color: textColor),
                  )
                : Text(
                    'You have no orders yet.\nCan we take you to Home ?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                        fontSize: blockSizeHorizontal(context) * 4,
                        fontWeight: FontWeight.w600,
                        color: textColor),
                  ),
          ),
          Pressable(
            onPressed: () => homeNavigationViewModel.setIndex(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widgetType == WidgetType.cart
                    ? Text(
                        'START SHOPPING',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            decoration: TextDecoration.underline,
                            fontSize: blockSizeHorizontal(context) * 4,
                            color: actionColor),
                      )
                    : Text(
                        'MAKE YOUR FIRST ORDER',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            decoration: TextDecoration.underline,
                            fontSize: blockSizeHorizontal(context) * 4,
                            color: actionColor),
                      ),
                SizedBox(
                  width: blockSizeHorizontal(context),
                ),
                SvgPicture.asset(Assets.arrowRightIcon)
              ],
            ),
          )
        ]);
  }
}
