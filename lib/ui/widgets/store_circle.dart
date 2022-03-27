import 'package:flutter/material.dart';

import '../../app/utilites/screen_sizes.dart';

class StoreCircle extends StatelessWidget {
  final String imageUrl;
  final void Function() onPressed;

  const StoreCircle({Key? key, required this.imageUrl, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        child: Container(
          color: Colors.white,
          width: screenWidthPercentage(context, percentage: 0.22),
          height: screenWidthPercentage(context, percentage: 0.22),
          padding: EdgeInsets.all(blockSizeHorizontal(context) * 5),
          child: Image(
            image: NetworkImage(imageUrl),
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              'assets/images/foodadora_seller.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        elevation: 2,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
