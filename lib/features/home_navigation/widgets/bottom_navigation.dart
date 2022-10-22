import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:foodadora/app/constants/assets.dart';

import 'package:provider/provider.dart';

import '../../../app/utilites/app_colors.dart';
import 'package:stacked/stacked.dart';

import '../../../core/providers/cart/cart_Service.dart';
import '../home_navigation_viewmodel.dart';
import 'nav_icon.dart';

const bottomNavigationBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(12), topRight: Radius.circular(12));

class BottomNavigation extends ViewModelWidget<HomeNavigationViewModel> {
  @override
  Widget build(BuildContext context, HomeNavigationViewModel viewModel) {
    return ClipRRect(
      borderRadius: bottomNavigationBorderRadius,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: viewModel.currentIndex,
          selectedItemColor: activeColor,
          unselectedItemColor: textColor,
          selectedFontSize: 12,
          showUnselectedLabels: true,
          onTap: (index) => viewModel.setIndex(index),
          items: [
            BottomNavigationBarItem(
              icon: NavIcon(
                iconPath: Assets.homeIcon,
                itemIndex: 0,
                activeIndex: viewModel.currentIndex,
              ),
              label: translate("bottom_nav.home").toUpperCase(),
            ),
            BottomNavigationBarItem(
              icon: CartIcon(
                itemsCount: context.watch<CartService>().cartLength,
                itemIndex: 1,
                activeIndex: viewModel.currentIndex,
              ),
              label: translate("bottom_nav.cart").toUpperCase(),
            ),
            BottomNavigationBarItem(
              icon: NavIcon(
                iconPath: Assets.ordersIcon,
                itemIndex: 2,
                activeIndex: viewModel.currentIndex,
              ),
              label: translate("bottom_nav.orders").toUpperCase(),
            ),
            BottomNavigationBarItem(
              icon: NavIcon(
                iconPath: Assets.settingsIcon,
                itemIndex: 3,
                activeIndex: viewModel.currentIndex,
              ),
              label: translate("bottom_nav.settings").toUpperCase(),
            ),
          ],
        ),
      ),
    );
  }
}
