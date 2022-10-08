// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/services/profile_service.dart';

import 'package:foodadora/ui/widgets/empty_indicator.dart';
import 'package:foodadora/ui/widgets/noconnection_indicator.dart';
import 'package:foodadora/ui/widgets/orders_notlogged.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:stacked/stacked.dart';

import '../../../../app/utilites/enums.dart';
import '../../../../app/utilites/screen_sizes.dart';
import '../../../../services/connectivity_service.dart';
import '../../../stores/domain/entites/store.dart';
import '../viewmodels/orders_viewmodel.dart';
import '../widgets/order_item.dart';

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
            if (!context.watch<ProfileService>().isLoggedOn) {
              return const OrdersNotLoggedIndicator();
            }
            if (model.loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (!context.watch<ConnectivityService>().isConnected) {
              return NoConnection(handleRetry: () => model.getOrders());
            }

            if (model.orders.isEmpty) {
              return const EmptyIndicator(widgetType: WidgetType.orders);
            }

            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: blockSizeHorizontal(context) * 1,
                  vertical: blockSizeVertical(context) * 2),
              child: RefreshIndicator(
                onRefresh: () async => model.getOrders(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    constraints:
                        BoxConstraints(minHeight: screenHeight(context) / 2),
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
                ),
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
