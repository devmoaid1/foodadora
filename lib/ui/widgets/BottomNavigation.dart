import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodadora/app/constants/assets.dart';

class BottomNavigation extends StatefulWidget {
  final Function changeIndex;
  final int selectedItemIndex;
  BottomNavigation(this.changeIndex, this.selectedItemIndex);
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildNavBarItem(Assets.homeicon, 0),
            buildNavBarItem(Assets.shoppingicon, 1),
            const SizedBox(
              width: 20,
            ),
            buildNavBarItem(Assets.historyicon, 2),
            buildNavBarItem(Assets.usericon, 3),
          ],
        ),
      ),
      shape: const CircularNotchedRectangle(),
    );
  }

  buildNavBarItem(String iconPath, int index) {
    return GestureDetector(
      onTap: () => widget.changeIndex(index),
      child: Container(
        width: 25,
        child: SvgPicture.asset(
          iconPath,
          height: 35,
          color: widget.selectedItemIndex == index
              ? Color(0xff08A8DB)
              : Colors.black,
        ),
      ),
    );
  }
}
