import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';

import 'package:foodadora/ui/utilites/screen_sizes.dart';

import 'package:line_icons/line_icons.dart';

class ProductItem extends StatelessWidget {
  final String? productImageUrl;
  final String? storeImageUrl;
  final String? productName;
  final double? productPrice;
  final double? originalPrice;
  final int? expiryWeeks;
  final Function()? onTapped;
  final Function()? onButtonPressed;
  const ProductItem(
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
          child: Card(
            child: Container(
              width: blockSizeHorizontal(context) * 50,
              child: Padding(
                padding: EdgeInsets.all(blockSizeHorizontal(context) * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        productImageUrl.toString(),
                        height: blockSizeVertical(context) * 15,
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
                    Text(
                      productName.toString(),
                      style: TextStyle(
                        fontSize: blockSizeHorizontal(context) * 5,
                      ),
                    ),
                    Container(
                      width: screenWidth(context) / 2 -
                          blockSizeHorizontal(context) * 5,
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
                                color: Color(0xffAEAEAE),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: blockSizeVertical(context)),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffF46317),
                          borderRadius: BorderRadius.circular(
                            20,
                          )),
                      child: Padding(
                        padding:
                            EdgeInsets.all(blockSizeHorizontal(context) * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.expiryicon),
                            SizedBox(width: blockSizeHorizontal(context)),
                            Container(
                              width: screenWidth(context) / 3 -
                                  blockSizeHorizontal(context) * 5,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Expires in $expiryWeeks weeks',
                                  style: TextStyle(
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
          ),
        ),
        Positioned(
          right: -blockSizeHorizontal(context) * 8,
          top: -blockSizeVertical(context) * 2,
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
