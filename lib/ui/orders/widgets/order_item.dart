// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodadora/ui/widgets/pressable.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../../app/constants/assets.dart';
import '../../../app/utilites/app_colors.dart';
import '../../../app/utilites/date_formmater.dart';
import '../../../app/utilites/screen_sizes.dart';
import '../../../models/order.dart';
import '../../../models/store.dart';

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
    return Material(
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
                        Text(
                          "${order.totalPrice} RM ",
                          style: GoogleFonts.poppins(
                              color: const Color(0xff5C5C5F),
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
                                  color: const Color(0xff5C5C5F),
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
                                        color: const Color(0xff0095DA),
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
    );
  }
}
