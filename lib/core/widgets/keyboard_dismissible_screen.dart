import 'package:flutter/material.dart';

class KeyboardDismissibleScreen extends StatelessWidget {
  final Widget screen;
  const KeyboardDismissibleScreen({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: screen,
    );
  }
}
