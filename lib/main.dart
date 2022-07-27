import 'package:flutter/material.dart';
// import 'widgets/navigation_menu.dart';
import './screens/auth/register.dart';
import './colors/my_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // int _selectedIndex = 0;

  // List<Widget> widgetOptions = <Widget>[
  //   Scaffold(
  //     body: Container(color: Colors.red),
  //   ),
  //   Scaffold(
  //     body: Container(color: Colors.green),
  //   ),
  //   Scaffold(
  //     body: Container(color: Colors.blue),
  //   ),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Recipes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Gilroy',
          primaryColor: MyColors.greenColor,
        ),
        home: const RegisterScreen()
        // Scaffold(
        //   extendBody: true,
        //   body: Stack(
        //     children: [
        //       Center(
        //         child: widgetOptions.elementAt(_selectedIndex),
        //       ),
        //       NavigationMenu(
        //         selectedIndex: _selectedIndex,
        //         onTapCallback: _onItemTapped,
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
