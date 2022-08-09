import 'package:flutter/material.dart';

import '../../colors/my_colors.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key, this.selectedIndex, this.onTapCallback})
      : super(key: key);

  final int? selectedIndex;
  final Function(int)? onTapCallback;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 10 / 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 25,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            selectedIconTheme:
                const IconThemeData(size: 30, color: MyColors.greenColor),
            unselectedIconTheme:
                const IconThemeData(size: 30, color: Colors.black),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 16,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shop_outlined,
                ),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore_outlined,
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_none,
                ),
                label: 'Activity',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_box_outlined,
                ),
                label: 'Account',
              ),
            ],
            currentIndex: selectedIndex!,
            selectedItemColor: MyColors.greenColor,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: onTapCallback,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
