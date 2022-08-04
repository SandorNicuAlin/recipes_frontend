import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import './screens/auth/register.dart';
import './screens/auth/login.dart';
import './colors/my_colors.dart';
import 'screens/main/home_screen.dart';
import './widgets/modals/auth_modal.dart';
import './widgets/loading/loading_screen.dart';
import './providers/user_provider.dart';
import 'screens/main/account/menu/my_details/my_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = false;
  bool _firstTime = true;
  bool _loggedIn = false;

  @override
  void didChangeDependencies() async {
    if (_firstTime) {
      setState(() {
        _isLoading = true;
      });

      final localStorage = await SharedPreferences.getInstance();
      final key = localStorage.getString('API_ACCESS_KEY');

      if (key != '' && key != null) {
        _loggedIn = true;
      }

      setState(() {
        _isLoading = false;
      });
      _firstTime = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
      ],
      child: MaterialApp(
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
          MyDetailsScreen.routeName: (ctx) => const MyDetailsScreen(),
        },
        home:
            // final approach
            // _checkIfLoggedIn() ? const HomeScreen() : const LoginScreen()

            //custom card
            //     const Scaffold(
            //   body: CustomCard(),
            // ),

            // login screen
            // const LoginScreen()
            _isLoading
                ? const LoadingScreen()
                : (_loggedIn ? const HomeScreen() : const LoginScreen()),

        // alert dialog
        // Scaffold(body: const AuthModal())

        // page with navigation menu
        // const HomeScreen(),
      ),
    );
  }
}
