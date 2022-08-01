import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/auth/register.dart';
import './screens/auth/login.dart';
import './colors/my_colors.dart';
import 'screens/main/main_screen.dart';
import './widgets/modals/auth_modal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> _checkIfLoggedIn() async {
    bool sessionStatus = false;
    final localStorage = await SharedPreferences.getInstance();
    if (localStorage.getString('API_ACCESS_KEY')!.isNotEmpty) {
      sessionStatus = true;
    }
    return sessionStatus;
  }

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
            // final approach
            // _checkIfLoggedIn() ? const HomeScreen() : const LoginScreen()

            //custom card
            //     const Scaffold(
            //   body: CustomCard(),
            // ),

            // login screen
            const LoginScreen()

        // alert dialog
        // Scaffold(body: const AuthModal())

        // page with navigation menu
        // const HomeScreen(),
        );
  }
}
