// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/app.router.dart';
import '../../app/constants/assets.dart';
import '../../app/constants/services_instances.dart';
import '../../app/utilites/app_colors.dart';
import '../../app/utilites/screen_sizes.dart';

class OrdersNotLoggedIndicator extends StatelessWidget {
  const OrdersNotLoggedIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: blockSizeHorizontal(context) * 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.emptyOrderIcon),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: blockSizeVertical(context) * 3,
            ),
            child: Text(
              'Great people always kept \n record for their orders ',
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                  fontSize: blockSizeHorizontal(context) * 4,
                  fontWeight: FontWeight.w600,
                  color: textColor),
            ),
          ),
          GestureDetector(
            onTap: () {
              navigationService.replaceWith(Routes.loginView);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: blockSizeHorizontal(context) * 6,
                  vertical: blockSizeVertical(context) * 1.5),
              decoration: BoxDecoration(
                  color: lightBlueColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  'Login/SignUp',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: blockSizeHorizontal(context) * 4),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
