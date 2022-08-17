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
  bool _isLoading = false;
  bool _firstTime = true;

  @override
  void didChangeDependencies() async {
    if (_firstTime) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<NotificationProvider>(context, listen: false)
          .fetchAllNotifications();
      setState(() {
        _isLoading = false;
      });
      _firstTime = false;
    }
    super.didChangeDependencies();
  }

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
