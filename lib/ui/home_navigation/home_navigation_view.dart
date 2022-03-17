import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/ui/cart/cart_view.dart';

import 'package:foodadora/ui/home_navigation/home_navigation_viewmodel.dart';

import 'package:foodadora/ui/home_navigation/home_views/stores_view.dart';
import 'package:foodadora/ui/home_navigation/widgets/bottom_navigation.dart';
import 'package:foodadora/ui/orders/orders_view.dart';
import 'package:foodadora/ui/profile/profile_view.dart';

import 'package:foodadora/ui/utilites/app_colors.dart';
import 'package:stacked/stacked.dart';

class HomeNavigationView extends StatelessWidget {
  const HomeNavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeNavigationViewModel>.reactive(
        viewModelBuilder: () => HomeNavigationViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: scaffoldColor,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: scaffoldColor,
                elevation: 0,
                title: SvgPicture.asset(
                  Assets.appLogo,
                ),
              ),
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
              bottomNavigationBar:
                  BottomNavigation(model.setIndex, model.currentIndex),
            ));
  }

  Widget getView(int index) {
    switch (index) {
      case 0:
        return const StoresView();
      case 1:
        return CartScreen();
      case 2:
        return const OrdersScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const StoresView();
    }
  }
}
