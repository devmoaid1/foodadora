import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/ui/utilites/size_config.dart';
import 'package:line_icons/line_icons.dart';

class ProductItem extends StatelessWidget {
  final String productImageUrl;
  final String storeImageUrl;
  final String productName;
  final double productPrice;
  final double originalPrice;
  final int expiryWeeks;
  final void Function() onTapped;
  final void Function() onButtonPressed;
  const ProductItem(
      {Key? key,
      required this.productImageUrl,
      required this.storeImageUrl,
      required this.productName,
      required this.productPrice,
      required this.originalPrice,
      required this.expiryWeeks,
      required this.onTapped,
      required this.onButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTapped,
          child: Card(
            child: SizedBox(
              width: SizeConfig.blockSizeHorizontal * 50,
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        productImageUrl,
                        height: SizeConfig.blockSizeVertical * 15,
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical),
                    Container(
                      height: SizeConfig.blockSizeVertical * 4,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xffFBF4E0),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeHorizontal * 2,
                        ),
                      ),
                      child: Image.network(
                        storeImageUrl,
                        width: SizeConfig.screenWidth / 7,
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical),
                    Text(
                      productName,
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 5,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth / 2 -
                          SizeConfig.blockSizeHorizontal * 5,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'RM ${productPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 7,
                                color: const Color(0xffFF0000),
                              ),
                            ),
                            SizedBox(width: SizeConfig.blockSizeHorizontal * 5),
                            Text(
                              'RM ${originalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 4,
                                decoration: TextDecoration.lineThrough,
                                color: const Color(0xffAEAEAE),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffF46317),
                          borderRadius: BorderRadius.circular(
                            20,
                          )),
                      child: Padding(
                        padding:
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.expiryicon),
                            SizedBox(width: SizeConfig.blockSizeHorizontal),
                            SizedBox(
                              width: SizeConfig.screenWidth / 3 -
                                  SizeConfig.blockSizeHorizontal * 5,
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
          ),
        ),
        Positioned(
          right: -SizeConfig.blockSizeHorizontal * 8,
          top: -SizeConfig.blockSizeVertical * 2,
          child: RawMaterialButton(
            onPressed: onButtonPressed,
            elevation: 0,
            fillColor: const Color(0xff08A5D2),
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
              child: Icon(
                LineIcons.addToShoppingCart,
                color: Colors.white,
                size: SizeConfig.blockSizeHorizontal * 8,
              ),
            ),
            shape: const CircleBorder(),
          ),
        ),
      ],
    );
  }
}
