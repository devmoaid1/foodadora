import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/assets.dart';

class StoresView extends StatelessWidget {
  const StoresView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Assets.homeGraphic),
      ],
    );
  }
}
