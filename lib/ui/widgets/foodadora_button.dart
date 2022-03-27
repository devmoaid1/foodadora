// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../../app/utilites/screen_sizes.dart';

class FoodadoraButton extends StatelessWidget {
  const FoodadoraButton({
    this.color,
    this.borderColor,
    this.labelColor,
    @required this.label,
    @required this.onPressed,
  });
  final Color? color;
  final String? label;
  final void Function()? onPressed;
  final Color? borderColor;
  final Color? labelColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: borderColor ?? Colors.white,
            width: 2,
          )),
      height: (screenHeight(context) / 100) * 8,
      width: (screenWidth(context) / 100) * 90,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              color ?? Theme.of(context).primaryColor),
        ),
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
