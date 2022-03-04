import 'package:flutter/material.dart';
import 'package:foodadora/ui/utilites/size_config.dart';

class HomeRow extends StatelessWidget {
  final String titleLabel;
  final String buttonLabel;
  final void Function() buttonOnPressed;

  const HomeRow({
    required this.titleLabel,
    required this.buttonLabel,
    required this.buttonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleLabel,
          style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * 6,
          ),
        ),
        TextButton(
            onPressed: buttonOnPressed,
            child: Text(
              buttonLabel,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4.5,
              ),
            )),
      ],
    );
  }
}
