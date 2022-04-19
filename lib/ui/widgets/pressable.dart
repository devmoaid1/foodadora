import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

// Adaptive Pressable Widget

class Pressable extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final BorderRadius? borderRadius;
  const Pressable({
    Key? key,
    required this.child,
    required this.onPressed,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? TouchableOpacity(
            child: child,
            onTap: onPressed,
          )
        : InkWell(
            child: child,
            onTap: onPressed,
            borderRadius: borderRadius,
          );
  }
}
