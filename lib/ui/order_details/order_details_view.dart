// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodadora/ui/cart/widgets/cart_text_row.dart';
import 'package:foodadora/ui/order_details/widgets/order_product_card.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../../app/constants/assets.dart';
import '../../app/utilites/app_colors.dart';
import '../../app/utilites/date_formmater.dart';
import '../../app/utilites/screen_sizes.dart';
import '../../models/order.dart';
import '../../models/store.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;
  final Store store;
  const OrderDetailsScreen({Key? key, required this.order, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: blockSizeVertical(context) * 10,
          backgroundColor: scaffoldColor,
          leading: IconButton(
              icon: Icon(
                LineIcons.angleLeft,
                color: Theme.of(context).primaryColor,
                size: blockSizeHorizontal(context) * 8,
              ),
              onPressed: () => Navigator.pop(context)),
          title: Padding(
            padding: EdgeInsets.all(blockSizeHorizontal(context)),
            child: Image.asset(
              'assets/images/sublogo.png',
              height: blockSizeVertical(context) * 8.5,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context) * 5,
                vertical: blockSizeVertical(context) * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.storeicon,
                      height: blockSizeVertical(context) * 6,
                    ),
                    SizedBox(
                      width: blockSizeHorizontal(context),
                    ),
                    Text(
                      "${store.storeName} Store",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffDDA73A),
                          fontSize: blockSizeHorizontal(context) * 6),
                    ),
                  ],
                ),
                SizedBox(
                  height: blockSizeVertical(context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockSizeHorizontal(context)),
                  child: Row(
                    children: [
                      Text(
                        formattedDate(date: order.orderDate as DateTime),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: textColor,
                            fontSize: blockSizeHorizontal(context) * 4),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockSizeHorizontal(context),
                      vertical: blockSizeVertical(context) * 2),
                  child: Row(
                    children: [
                      Text(
                        "Invoice # ${order.id!.substring(0, 8)}",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: textColor,
                            fontSize: blockSizeHorizontal(context) * 4),
                      ),
                      SizedBox(
                        width: blockSizeVertical(context) * 3,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: blockSizeHorizontal(context) * 10,
                            vertical: blockSizeVertical(context) * 1),
                        decoration: BoxDecoration(
                            color: const Color(0xffECECEC),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            order.status.toString(),
                            style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: blockSizeHorizontal(context) * 3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: blockSizeVertical(context),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: buildCards(order: order)),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(blockSizeHorizontal(context) * 4),
                    child: Column(
                      children: [
                        CartTextRow(
                          title: 'Subtotal:',
                          price: order.totalPrice as double,
                        ),
                        SizedBox(height: blockSizeVertical(context) * 2),
                        const CartTextRow(
                          title: 'Taxes:',
                        ),
                        SizedBox(height: blockSizeVertical(context)),
                        const DottedLine(
                          dashColor: Color(0xffCFCFCF),
                        ),
                        SizedBox(height: blockSizeVertical(context)),
                        CartTextRow(
                          title: 'Total:',
                          price: order.totalPrice as double,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> buildCards({required Order order}) {
  List<Widget> cards = [];

  order.products!.forEach((product) {
    cards.add(OrderProductCard(product: product));
  });

  return cards;
}