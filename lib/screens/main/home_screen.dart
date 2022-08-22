import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/navigation_menu/navigation_menu.dart';
import './account/account_screen.dart';
import './activity/activity_screen.dart';
import '../../providers/notification_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _firstTime = true;

  @override
  void didChangeDependencies() async {
    if (_firstTime) {
      await Provider.of<NotificationProvider>(
        context,
        listen: false,
      ).fetchAllNotifications();
      _firstTime = false;
    }
    super.didChangeDependencies();
  }

  int _selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    const Scaffold(
      body: Center(
        child: Text('Recipes'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Stock'),
      ),
    ),
    const ActivityScreen(),
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
