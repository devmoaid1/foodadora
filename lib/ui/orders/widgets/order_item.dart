// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';

import 'order_text_row.dart';

class OrderItem extends StatelessWidget {
  final String orderId;
  final double orderTotal;
  final String orderStatus;

  const OrderItem({
    required this.orderId,
    required this.orderStatus,
    required this.orderTotal,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      elevation: 1,
      color: const Color(0xffF4F4F4),
      child: Padding(
        padding: EdgeInsets.all(blockSizeHorizontal(context) * 4),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                width: blockSizeHorizontal(context) * 60,
                child: FittedBox(
                    child: Text('#$orderId',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: blockSizeHorizontal(context) * 5,
                          color: const Color(0xffA6A6A6),
                        ))),
              ),
              SizedBox(height: blockSizeVertical(context)),
              const DottedLine(
                dashColor: Color(0xffCFCFCF),
              ),
              SizedBox(height: blockSizeVertical(context)),
              OrderTextRow(
                title: 'Order Total:',
                value: 'RM ${orderTotal.toStringAsFixed(1)}',
              ),
              SizedBox(height: blockSizeVertical(context) * 2),
              OrderTextRow(
                title: 'Status:',
                value: orderStatus,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
