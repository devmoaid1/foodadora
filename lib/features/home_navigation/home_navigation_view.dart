import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/widgets/internet_connection_wrapper.dart';

import 'package:stacked/stacked.dart';

import '../../app/utilites/app_colors.dart';
import '../../core/widgets/foodadora_app_bar.dart';
import '../../features/cart/presentation/views/cart_view.dart';
import '../../features/orders/presentation/views/orders_view.dart';
import '../../features/settings/presentation/views/settings_view.dart';
import '../../features/stores/presentation/views/stores_view.dart';
import 'home_navigation_viewmodel.dart';
import 'widgets/bottom_navigation.dart';

class HomeNavigationView extends StatelessWidget {
  const HomeNavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeNavigationViewModel>.reactive(
        viewModelBuilder: () => homeNavigationViewModel,
        disposeViewModel: false,
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: scaffoldColor,
            appBar: foodadoraAppBar(context),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: PageTransitionSwitcher(
                reverse: model.reverse,
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return SharedAxisTransition(
                      child: child,
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal);
                },
                child: getView(model.currentIndex),
              ),
            ),
            bottomNavigationBar: BottomNavigation(),
          );
        });
  }

  Widget getView(int index) {
    switch (index) {
      case 0:
        return const InternetConnectionWrapper(screen: StoresScreen());
      case 1:
        return InternetConnectionWrapper(screen: CartScreen());
      case 2:
        return const InternetConnectionWrapper(screen: OrdersScreen());
      case 3:
        return InternetConnectionWrapper(screen: SettingsView());
      default:
        return const InternetConnectionWrapper(screen: StoresScreen());
    }
  }
}
