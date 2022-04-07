// ignore_for_file: use_key_in_widget_constructors

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:foodadora/app/utilites/enums.dart';

import '../../app/utilites/screen_sizes.dart';

class SocialButton extends StatelessWidget {
  final void Function() onPressed;
  final SocialTypes type;

  const SocialButton({
    Key? key,
    required this.onPressed,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Color color;
    late String labelType;
    late TextStyle labelStyle;
    late String iconPath;

    switch (type) {
      case SocialTypes.apple:
        color = Colors.black;
        labelType = "Apple";
        iconPath = Assets.appleIcon;
        labelStyle = GoogleFonts.sourceSansPro(
            color: Colors.white, fontSize: (screenWidth(context) / 100) * 6);
        break;

      case SocialTypes.google:
        color = Colors.white;
        labelType = "Google";
        iconPath = Assets.googleIcon;
        labelStyle = GoogleFonts.roboto(
            color: Colors.black54, fontSize: (screenWidth(context) / 100) * 6);
        break;

      case SocialTypes.facebook:
        color = const Color(0xff1877F2);
        labelType = "Facebook";
        iconPath = Assets.facebookIcon;
        labelStyle = GoogleFonts.montserrat(
            color: Colors.white, fontSize: (screenWidth(context) / 100) * 5);
        break;

      default:
        color = Colors.white;
        labelType = "None";
        iconPath = Assets.appLogo;
        GoogleFonts.roboto(color: Colors.black54);
    }

    String label = "Continue with $labelType";

    Widget buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 25,
        ),
        horizontalSpaceRegular,
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: labelStyle,
          ),
        )
      ],
    );

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
        ),
        height: (screenHeight(context) / 100) * 8,
        width: screenWidth(context),
        child: Expanded(
          child: Platform.isIOS
              ? Material(
                  elevation: .2,
                  child: CupertinoButton(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(16),
                      color: color,
                      onPressed: onPressed,
                      child: buttonChild),
                )
              : ElevatedButton(
                  style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      elevation: MaterialStateProperty.all<double>(.2),
                      backgroundColor: MaterialStateProperty.all(color)),
                  onPressed: onPressed,
                  child: buttonChild,
                ),
        ));
  }
}
