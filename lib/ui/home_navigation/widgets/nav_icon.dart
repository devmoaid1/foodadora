import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/utilites/app_colors.dart';

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

class CartIcon extends NavIcon {
  final int itemsCount;
  const CartIcon({
    Key? key,
    required this.itemsCount,
    required int itemIndex,
    required int activeIndex,
  }) : super(
          key: key,
          iconPath: Assets.cartIcon,
          itemIndex: itemIndex,
          activeIndex: activeIndex,
        );

  @override
  Widget build(BuildContext context) {
    return Badge(
      showBadge: itemsCount > 0,
      badgeContent: Text(
        itemsCount.toString(),
        style: GoogleFonts.lato(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
      badgeColor: const Color(0xffF46317),
      child: super.build(context),
    );
  }
}
