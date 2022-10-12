// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodadora/app/utilites/format_price.dart';
import 'package:foodadora/ui/widgets/pressable.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/constants/assets.dart';
import '../../../../app/utilites/app_colors.dart';
import '../../../../app/utilites/date_formmater.dart';
import '../../../../app/utilites/screen_sizes.dart';

import '../../../stores/domain/entites/store.dart';
import '../../domain/entities/order.dart';
import '../viewmodels/orders_viewmodel.dart';

class OrderItem extends ViewModelWidget<OrdersViewModel> {
  final Store store;
  final OrderEntity order;

  const OrderItem({
    required this.store,
    required this.order,
  });
  @override
  Widget build(BuildContext context, OrdersViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        elevation: .5,
        child: Pressable(
          onPressed: () {
            viewModel.navigateToOrderDetails(store: store, order: order);
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${store.storeName} Store",
                        style: GoogleFonts.poppins(
                            color: activeColor,
                            fontSize: blockSizeHorizontal(context) * 5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formattedDate(date: order.orderDate as DateTime),
                            style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: blockSizeHorizontal(context) * 4),
                          ),
                          SizedBox(
                            width: blockSizeHorizontal(context),
                          ),
                          Text(
                            formatPrice(order.totalPrice),
                            style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: blockSizeHorizontal(context) * 4),
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
                                horizontal: blockSizeHorizontal(context) * 6,
                                vertical: blockSizeVertical(context) * 1),
                            decoration: BoxDecoration(
                                color: scaffoldColor,
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
                          SizedBox(
                            width: blockSizeHorizontal(context),
                          ),
                          Pressable(
                            onPressed: () {
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
                                          color: actionColor,
                                          fontSize:
                                              blockSizeHorizontal(context) * 3),
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
