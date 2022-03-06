import 'package:flutter/material.dart';
import 'package:foodadora/ui/orders/orders_viewmodel.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';

import 'widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: blockSizeVertical(context) * 10,
        backgroundColor: Colors.white,
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
      body: ViewModelBuilder<OrdersViewModel>.reactive(
          viewModelBuilder: () => OrdersViewModel(),
          onModelReady: (model) => model.getOrders(),
          builder: (context, model, _) {
            if (model.loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (model.orders.isEmpty) {
              return Center(
                child: Text(
                  "There is no orders",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: blockSizeHorizontal(context) * 5),
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: blockSizeHorizontal(context) * 5,
                  vertical: blockSizeVertical(context) * 2),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Orders',
                      style: GoogleFonts.poppins(
                          fontSize: blockSizeHorizontal(context) * 8),
                    ),
                    SizedBox(height: blockSizeVertical(context) * 3),
                    Expanded(
                      child: ListView.builder(
                        itemCount: model.orders.length,
                        itemBuilder: (context, index) => OrderItem(
                          orderId: "27138222",
                          orderTotal: model.orders[index].totalPrice as double,
                          orderStatus: model.orders[index].status.toString(),
                        ),
                      ),
                    )
                  ]),
            );
          }),
    );
  }
}
