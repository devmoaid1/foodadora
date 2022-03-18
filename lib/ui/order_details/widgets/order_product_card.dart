// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/constants/assets.dart';
import '../../../models/product.dart';
import '../../utilites/screen_sizes.dart';

class OrderProductCard extends StatelessWidget {
  final Product product;
  const OrderProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: blockSizeVertical(context) * 2),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context),
                vertical: blockSizeVertical(context) * 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeightPercentage(context, percentage: 0.10),
                  width: screenWidthPercentage(context, percentage: 0.25),
                  child: Image(
                    image: NetworkImage(product.productImages![0]),
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName.toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff5C5C5F),
                            fontSize: blockSizeHorizontal(context) * 4),
                      ),
                      SizedBox(
                        height: blockSizeHorizontal(context) * 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.priceIcon,
                                    height: blockSizeVertical(context) * 2,
                                  ),
                                  SizedBox(
                                    width: blockSizeVertical(context),
                                  ),
                                  Text(
                                    "${product.productPrice!.toStringAsFixed(2)} RM"
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff5C5C5F),
                                        fontSize:
                                            blockSizeHorizontal(context) * 3),
                                  ),
                                  SizedBox(
                                    width: blockSizeVertical(context) * 2,
                                  ),
                                  Text(
                                    "X ${product.quantity}".toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff5C5C5F),
                                        fontSize:
                                            blockSizeHorizontal(context) * 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "${product.productPrice! * product.quantity!.toInt()}  RM"
                                  .toString(),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffDDA73A),
                                  fontSize: blockSizeHorizontal(context) * 3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
