import 'package:flutter/material.dart';

import 'package:foodadora/ui/utilites/screen_sizes.dart';

class StoreCircle extends StatelessWidget {
  final String? imageUrl;
  final Function()? onPressed;
  const StoreCircle({
    @required this.imageUrl,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        child: Container(
          width: screenWidthPercentage(context, percentage: 0.22),
          height: screenWidthPercentage(context, percentage: 0.22),
          padding: EdgeInsets.all(blockSizeHorizontal(context) * 5),
          child: Image.asset(
            imageUrl.toString(),
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              'assets/images/foodadora_seller.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        elevation: 2,
        shape: CircleBorder(),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
