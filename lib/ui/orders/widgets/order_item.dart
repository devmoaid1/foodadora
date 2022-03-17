// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodadora/ui/order_details/order_details_viewModel.dart';
import 'package:foodadora/ui/utilites/date_formmater.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../../app/constants/assets.dart';
import '../../../models/order.dart';
import '../../../models/store.dart';
import '../../utilites/app_colors.dart';
import '../orders_viewmodel.dart';

class OrderItem extends ViewModelWidget<OrdersViewModel> {
  final Store store;
  final Order order;

  const OrderItem({
    required this.store,
    required this.order,
  });
  @override
  Widget build(BuildContext context, OrdersViewModel viewModel) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: blockSizeHorizontal(context) * 4,
            vertical: blockSizeVertical(context) * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(Assets.orderIcon),
            SizedBox(
              width: blockSizeHorizontal(context) * 3,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${store.storeName} Store",
                  style: GoogleFonts.poppins(
                      color: const Color(0xffDDA73A),
                      fontSize: blockSizeHorizontal(context) * 5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formattedDate(date: order.orderDate as DateTime),
                      style: GoogleFonts.poppins(
                          color: const Color(0xff5C5C5F),
                          fontSize: blockSizeHorizontal(context) * 4),
                    ),
                    SizedBox(
                      width: blockSizeHorizontal(context),
                    ),
                    Container(
                      width: screenWidthPercentage(context, percentage: 0.18),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "${order.totalPrice} RM ",
                          style: GoogleFonts.poppins(
                              color: const Color(0xff5C5C5F),
                              fontSize: blockSizeHorizontal(context) * 3),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: blockSizeVertical(context) * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: blockSizeHorizontal(context) * 3,
                          vertical: blockSizeVertical(context) * 1),
                      decoration: BoxDecoration(
                          color: scaffoldColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          order.status.toString(),
                          style: GoogleFonts.poppins(
                              color: const Color(0xff5C5C5F),
                              fontSize: blockSizeHorizontal(context) * 4),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: blockSizeHorizontal(context),
                    ),
                    GestureDetector(
                      onTap: () {
                        viewModel.navigateToOrderDetails(
                            store: store, order: order);
                      },
                      child: Row(
                        children: [
                          Container(
                            width: screenWidthPercentage(context,
                                percentage: 0.18),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "View Details ",
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff0095DA),
                                    fontSize: blockSizeHorizontal(context) * 3),
                              ),
                            ),
                          ),
                          SvgPicture.asset(Assets.arrowRightIcon)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
