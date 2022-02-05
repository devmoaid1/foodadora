import 'package:flutter/material.dart';

import 'package:foodadora/ui/utilites/screen_sizes.dart';

class FoodadoraButton extends StatelessWidget {
  const FoodadoraButton({
    this.color,
    @required this.label,
    @required this.onPressed,
  });
  final Color? color;
  final String? label;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: Colors.white, fontSize: (screenWidth(context) / 100) * 5),
        ),
      ),
    );
  }
}
