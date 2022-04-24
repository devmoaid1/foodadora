// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/ui/orders/orders_viewmodel.dart';

import 'package:foodadora/ui/widgets/empty_indicator.dart';
import 'package:foodadora/ui/widgets/noconnection_indicator.dart';
import 'package:foodadora/ui/widgets/orders_notlogged.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stacked/stacked.dart';

import '../../app/utilites/enums.dart';
import '../../app/utilites/screen_sizes.dart';
import '../../models/store.dart';
import 'widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<OrdersViewModel>.reactive(
          viewModelBuilder: () => ordersViewModel,
          onModelReady: (model) => model.getOrders(),
          initialiseSpecialViewModelsOnce: true,
          fireOnModelReadyOnce: true,
          disposeViewModel: false,
          builder: (context, model, _) {
            if (!model.isLoggedOn) {
              return const OrdersNotLoggedIndicator();
            }
            if (model.loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (!model.isConnected) {
              return NoConnection(
                handleRetry: () {
                  model.getOrders();
                },
              );
            }

            if (model.orders.isEmpty) {
              return const EmptyIndicator(widgetType: WidgetType.orders);
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
                            color: textColor,
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

  var seen = <String>{};
  List<Store> uniqueStores = viewModel.stores
      .where((store) => seen.add(store.id.toString()))
      .toList(); // remove duplicate stores

  for (var order in viewModel.orders) {
    for (var uniquestore in uniqueStores) {
      if (order.storeId == uniquestore.id) {
        orderCards.add(OrderItem(store: uniquestore, order: order));
      }
    }
  }

  return orderCards;
}
