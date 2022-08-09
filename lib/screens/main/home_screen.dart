import 'package:flutter/material.dart';
import 'package:recipes_frontend/screens/main/account/menu/my_details/my_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/navigation_menu/navigation_menu.dart';
import '../../widgets/buttons/custom_elevated_button.dart';
import '../../colors/my_colors.dart';
import '../auth/login.dart';
import './account/account_screen.dart';

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
        child: Text('Notifications'),
      ),
    ),
    const AccountScreen(),
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
        ),
      ],
    );
  }
}
