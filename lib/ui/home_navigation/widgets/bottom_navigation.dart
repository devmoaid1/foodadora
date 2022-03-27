import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/ui/home_navigation/widgets/nav_icon.dart';

import '../../../app/utilites/app_colors.dart';

const bottomNavigationBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(12), topRight: Radius.circular(12));

class BottomNavigation extends StatelessWidget {
  final Function changeIndex;
  final int currentIndex;
  const BottomNavigation(this.changeIndex, this.currentIndex);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: bottomNavigationBorderRadius,
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            selectedItemColor: activeColor,
            unselectedItemColor: textColor,
            selectedFontSize: 12,
            showUnselectedLabels: true,
            onTap: (index) => changeIndex(index),
            items: [
              BottomNavigationBarItem(
                icon: NavIcon(
                  iconPath: Assets.homeIcon,
                  itemIndex: 0,
                  activeIndex: currentIndex,
                ),
                label: "HOME",
              ),
              BottomNavigationBarItem(
                icon: NavIcon(
                  iconPath: Assets.cartIcon,
                  itemIndex: 1,
                  activeIndex: currentIndex,
                ),
                label: "CART",
              ),
              BottomNavigationBarItem(
                icon: NavIcon(
                  iconPath: Assets.ordersIcon,
                  itemIndex: 2,
                  activeIndex: currentIndex,
                ),
                label: "ORDERS",
              ),
              BottomNavigationBarItem(
                icon: NavIcon(
                  iconPath: Assets.settingsIcon,
                  itemIndex: 3,
                  activeIndex: currentIndex,
                ),
                label: "SETTINGS",
              ),
            ],
          ),
        ),
      );
}
