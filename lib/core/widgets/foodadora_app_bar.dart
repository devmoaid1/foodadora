import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/app/utilites/screen_sizes.dart';
import 'package:line_icons/line_icons.dart';

import 'package:foodadora/app/constants/assets.dart';

AppBar foodadoraAppBar(BuildContext context, {bool withBack = false}) {
  Icon _icon = Icon(
    LineIcons.angleLeft,
    color: Theme.of(context).primaryColor,
    size: blockSizeHorizontal(context) * 6,
  );

  void _onPressed() => Navigator.pop(context);

  return AppBar(
    automaticallyImplyLeading: false,
    leading: withBack
        ? Platform.isIOS
            ? CupertinoButton(child: _icon, onPressed: _onPressed)
            : IconButton(
                splashRadius: blockSizeHorizontal(context) * 5,
                icon: _icon,
                onPressed: _onPressed,
              )
        : null,
    centerTitle: true,
    backgroundColor: scaffoldColor,
    elevation: 0,
    title: SvgPicture.asset(
      Assets.appLogo,
    ),
  );
}
