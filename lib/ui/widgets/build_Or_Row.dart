import 'package:flutter/material.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';

Padding _buildOrRow(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: (screenWidth(context) / 100) * 10,
        vertical: (screenHeight(context) / 100) * 2),
    child: Row(children: <Widget>[
      const Expanded(
        child: Divider(color: Colors.black),
      ),
      Text(
        "  OR  ",
        style: TextStyle(
          color: Colors.black,
          fontSize: (screenWidth(context) / 100) * 4,
        ),
      ),
      const Expanded(
          child: Divider(
        color: Colors.black,
      )),
    ]),
  );
}
