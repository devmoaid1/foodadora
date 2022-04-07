// ignore_for_file: use_key_in_widget_constructors

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/utilites/screen_sizes.dart';

class FoodadoraButton extends StatelessWidget {
  const FoodadoraButton({
    this.iconPath,
    this.color,
    this.borderColor,
    this.labelColor,
    required this.label,
    required this.onPressed,
  });

  final Color? color;
  final String label;
  final void Function() onPressed;
  final Color? borderColor;
  final Color? labelColor;
  final String? iconPath;
  @override
  Widget build(BuildContext context) {
    return iconPath != null
        ? GestureDetector(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                  color: color ?? lightBlueColor,
                  borderRadius: BorderRadius.circular(8)),
              height: screenHeightPercentage(context, percentage: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label.toString(),
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: blockSizeHorizontal(context) * 5),
                  ),
                  SizedBox(
                    width: blockSizeHorizontal(context) * 2,
                  ),
                  iconPath != null
                      ? SvgPicture.asset(
                          iconPath.toString(),
                          color: Colors.white,
                        )
                      : Container()
                ],
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
            ),
            height: (screenHeight(context) / 100) * 8,
            width: screenWidth(context),
            child: Platform.isIOS
                ? CupertinoButton(
                    color: color ?? Theme.of(context).primaryColor,
                    onPressed: onPressed,
                    child: Text(
                      label.toString(),
                      style: GoogleFonts.raleway(
                          color: labelColor ?? Colors.white,
                          fontSize: (screenWidth(context) / 100) * 5),
                    ),
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0.2),
                        backgroundColor: MaterialStateProperty.all(
                            color ?? Theme.of(context).primaryColor)),
                    onPressed: onPressed,
                    child: Text(
                      label.toString(),
                      style: TextStyle(
                          color: labelColor ?? Colors.white,
                          fontSize: (screenWidth(context) / 100) * 5),
                    ),
                  ),
          );
  }
}
