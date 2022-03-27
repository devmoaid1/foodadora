// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodadora/app/constants/assets.dart';

import '../../app/utilites/screen_sizes.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.white;
  final AppBar? appBar;

  /// you can add more fields that meet your needs

  const BaseAppBar({Key? key, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: SvgPicture.asset(
        Assets.appLogo,
        height: Size.fromHeight(appBar!.preferredSize.height).height -
            screenWidth(context),
      ),
      elevation: 0,
      backgroundColor: backgroundColor,
      actions: [
        SvgPicture.asset(
          Assets.ringicon,
          color: Color(0xff0095DA),
        ),
        SizedBox(
          width: (screenWidth(context) / 100) * 3,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar!.preferredSize.height);
}
