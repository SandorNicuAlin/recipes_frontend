import 'package:flutter/material.dart';
import 'widgets/navigation_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    Scaffold(
      body: Container(color: Colors.red),
    ),
    Scaffold(
      body: Container(color: Colors.green),
    ),
    Scaffold(
      body: Container(color: Colors.blue),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            Center(
              child: widgetOptions.elementAt(_selectedIndex),
            ),
            NavigationMenu(
              selectedIndex: _selectedIndex,
              onTapCallback: _onItemTapped,
            )
          ],
        ),
      ),
    );
  }
}
