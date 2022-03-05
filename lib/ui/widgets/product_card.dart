import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';

import 'package:foodadora/ui/utilites/screen_sizes.dart';

import 'package:line_icons/line_icons.dart';

class ProductCard extends StatelessWidget {
  final String? productImageUrl;
  final String? storeImageUrl;
  final String? productName;
  final double? productPrice;
  final double? originalPrice;
  final int? expiryWeeks;
  final Function()? onTapped;
  final Function()? onButtonPressed;
  const ProductCard(
      {@required this.productImageUrl,
      @required this.storeImageUrl,
      @required this.productName,
      @required this.productPrice,
      @required this.originalPrice,
      @required this.expiryWeeks,
      @required this.onTapped,
      @required this.onButtonPressed});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTapped,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context) * 3,
                vertical: blockSizeVertical(context) * 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300] as Color, width: 2),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth(context),
                  height: screenHeightPercentage(context, percentage: 0.16),
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(productImageUrl.toString()),
                  ),
                ),
                SizedBox(height: blockSizeVertical(context)),
                Container(
                  height: blockSizeVertical(context) * 4,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xffFBF4E0),
                    borderRadius: BorderRadius.circular(
                      blockSizeHorizontal(context) * 2,
                    ),
                  ),
                  child: Image.network(
                    storeImageUrl.toString(),
                    width: screenWidth(context) / 7,
                  ),
                ),
                SizedBox(height: blockSizeVertical(context)),
                Container(
                  width: screenWidth(context),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      productName.toString(),
                      style: TextStyle(
                          fontSize: blockSizeHorizontal(context) * 5,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: blockSizeVertical(context),
                ),
                SizedBox(
                  width: screenWidth(context),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'RM ${productPrice!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: blockSizeHorizontal(context) * 7,
                            color: const Color(0xffFF0000),
                          ),
                        ),
                        SizedBox(width: blockSizeHorizontal(context) * 5),
                        Text(
                          'RM ${originalPrice!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: blockSizeHorizontal(context) * 4,
                            decoration: TextDecoration.lineThrough,
                            color: const Color(0xffAEAEAE),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: blockSizeVertical(context) * 2),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffF46317),
                      borderRadius: BorderRadius.circular(
                        20,
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(blockSizeHorizontal(context) * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Assets.expiryicon),
                        SizedBox(width: blockSizeHorizontal(context)),
                        Container(
                          width: screenWidth(context) / 3 -
                              blockSizeHorizontal(context) * 13,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'Expires in $expiryWeeks weeks',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: RawMaterialButton(
            onPressed: onButtonPressed,
            elevation: 0,
            fillColor: Color(0xff08A5D2),
            child: Padding(
              padding: EdgeInsets.all(blockSizeHorizontal(context) * 2),
              child: Icon(
                LineIcons.addToShoppingCart,
                color: Colors.white,
                size: blockSizeHorizontal(context) * 8,
              ),
            ),
            shape: CircleBorder(),
          ),
        ),
      ],
    );
  }
}
