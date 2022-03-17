// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:foodadora/ui/orders/orders_viewmodel.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stacked/stacked.dart';

import 'widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  horizontal: blockSizeHorizontal(context) * 1,
                  vertical: blockSizeVertical(context) * 2),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Orders',
                        style: GoogleFonts.poppins(
                            color: const Color(0xff5C5C5F),
                            fontSize: blockSizeHorizontal(context) * 8),
                      ),
                      SizedBox(height: blockSizeVertical(context) * 3),
                      Column(
                        children: buildOrdersCards(viewModel: model),
                      )
                    ]),
              ),
            );
          }),
    );
  }
}

List<Widget> buildOrdersCards({required OrdersViewModel viewModel}) {
  List<Widget> orderCards = [];

  viewModel.orders.forEach((order) {
    viewModel.stores.forEach((store) {
      if (order.products![0].storeId == store.id) {
        orderCards.add(OrderItem(store: store, order: order));
      }
    });
  });

  return orderCards;
}
