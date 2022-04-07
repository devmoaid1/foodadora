import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/app/utilites/screen_sizes.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsRow extends StatelessWidget {
  final String iconPath;
  final Function() onPressed;
  final String title;
  final String? subTitle;
  final String actionTitle;

  const SettingsRow({
    Key? key,
    required this.iconPath,
    required this.onPressed,
    required this.title,
    this.subTitle,
    required this.actionTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 20,
                  color: textColor,
                ),
                horizontalSpaceRegular,
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: textColor,
                  ),
                ),
                if (subTitle != null) horizontalSpaceLarge,
                if (subTitle != null)
                  Text(
                    subTitle!,
                    style: GoogleFonts.poppins(
                      color: lightTextColor,
                    ),
                  ),
              ],
            ),
          ),
          _ActionButton(
            title: actionTitle.toUpperCase(),
            onPressed: onPressed,
          )
        ]),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  const _ActionButton({
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                  color: actionColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ))
        : TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => actionColor.withOpacity(.1)),
            ),
            onPressed: onPressed,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                  color: actionColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ));
  }
}
