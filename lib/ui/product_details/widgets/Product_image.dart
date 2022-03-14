// ignore_for_file: file_names, use_key_in_widget_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';

class ProductImage extends StatelessWidget {
  final String? productimage;
  final int? expiry;
  const ProductImage({this.productimage, this.expiry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: blockSizeHorizontal(context) * 3,
          vertical: blockSizeVertical(context) * 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenWidth(context),
            height: screenHeightPercentage(context, percentage: 0.25),
            child: Image(
              image: NetworkImage(productimage.toString()),
              fit: BoxFit.fill,
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
                          left: Radius.circular(12.0),
                          right: Radius.circular(12.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.access_alarm_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: blockSizeHorizontal(context) * 1,
                      ),
                      Text(
                        'Expires in $expiry weeks',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: blockSizeHorizontal(context) * 3,
                            fontWeight: FontWeight.w700,
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
