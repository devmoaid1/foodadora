// ignore_for_file: file_names, use_key_in_widget_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodadora/app/constants/assets.dart';

import '../../../app/utilites/screen_sizes.dart';

class ProductImage extends StatelessWidget {
  final String? productimage;
  final int? expiry;
  const ProductImage({this.productimage, this.expiry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: blockSizeHorizontal(context) * 4,
          vertical: blockSizeVertical(context) * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenWidth(context),
            height: screenHeightPercentage(context, percentage: 0.25),
            child: Image(
              image: NetworkImage(productimage.toString()),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: blockSizeVertical(context) * 2,
          ),
          Container(
            child: Row(
              children: [
                Container(
                  height: blockSizeVertical(context) * 5,
                  width: screenWidthPercentage(context, percentage: 0.40),
                  decoration: const BoxDecoration(
                      color: Color(0xffF46317),
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(17.0),
                          right: Radius.circular(17.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.clockIcon),
                      SizedBox(
                        width: blockSizeHorizontal(context) * 1,
                      ),
                      Text(
                        'Expires in $expiry weeks',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: blockSizeHorizontal(context) * 3,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
