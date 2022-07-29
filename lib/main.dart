import 'package:flutter/material.dart';

import './screens/auth/register.dart';
import './screens/auth/login.dart';
import './colors/my_colors.dart';
import 'screens/main/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Recipes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Gilroy',
          primaryColor: MyColors.greenColor,
        ),
        routes: {
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          RegisterScreen.routeName: (ctx) => const RegisterScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
        },
        home:

            //custom card
            //     const Scaffold(
            //   body: CustomCard(),
            // ),

            // login screen
            const LoginScreen()

        // page with navigation menu
        // const HomeScreen(),
        );
  }
}
