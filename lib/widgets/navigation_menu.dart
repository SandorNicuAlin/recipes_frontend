import 'package:flutter/material.dart';

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
        height: MediaQuery.of(context).size.height * 12 / 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
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
            selectedFontSize: 16,
            selectedIconTheme: const IconThemeData(size: 30),
            iconSize: 25,
            elevation: 1,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.business_rounded,
                ),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.school_rounded,
                ),
                label: 'School',
              ),
            ],
            currentIndex: selectedIndex!,
            selectedItemColor: Colors.amber[800],
            onTap: onTapCallback,
          ),
        ),
      ),
    );
  }
}
