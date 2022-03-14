import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/services/cart_Service.dart';
import 'package:foodadora/ui/utilites/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class NavIcon extends StatelessWidget {
  final String iconPath;
  final int itemIndex;
  final int activeIndex;
  const NavIcon(
      {Key? key,
      required this.iconPath,
      required this.itemIndex,
      required this.activeIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (iconPath == Assets.cartIcon) {

    //   return Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 8.0),
    //     child: Badge(
    //       padding: const EdgeInsets.all(6),
    //       badgeContent: Text(cartItemsLenght.toString(),
    //           style: GoogleFonts.poppins(
    //             color: Colors.white,
    //           )),
    //       child: SvgPicture.asset(
    //         iconPath,
    //         height: 20,
    //         color: itemIndex == activeIndex ? activeColor : textColor,
    //       ),
    //     ),
    //   );
    // }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SvgPicture.asset(
        iconPath,
        height: 20,
        color: itemIndex == activeIndex ? activeColor : textColor,
      ),
    );
  }
}
