import 'package:flutter/material.dart';

import '../../widgets/navigation_menu/navigation_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    const Scaffold(
      body: Center(
        child: Text('Shop'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Explore'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Cart'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Favorite'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Account'),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: widgetOptions.elementAt(_selectedIndex),
        ),
        NavigationMenu(
          selectedIndex: _selectedIndex,
          onTapCallback: _onItemTapped,
        )
      ],
    );
  }
}
