import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './screens/auth/register.dart';
import './screens/auth/login.dart';
import './colors/my_colors.dart';
import 'screens/main/home_screen.dart';
import './widgets/loading/loading_screen.dart';
import './providers/user_provider.dart';
import './providers/group_provider.dart';
import './providers/notification_provider.dart';
import './providers/recipe_provider.dart';
import './providers/recipe_step_provider.dart';
import './providers/product_stock_provider.dart';
import './providers/product_provider.dart';
import './screens/main/account/menu/my_details/my_details_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

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
        ChangeNotifierProvider(create: (ctx) => GroupProvider()),
        ChangeNotifierProvider(create: (ctx) => NotificationProvider()),
        ChangeNotifierProvider(create: (ctx) => RecipeProvider()),
        ChangeNotifierProvider(create: (ctx) => RecipeStepProvider()),
        ChangeNotifierProvider(create: (ctx) => ProductStockProvider()),
        ChangeNotifierProvider(create: (ctx) => ProductProvider()),
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
            _isLoading
                ? const LoadingScreen()
                : (_loggedIn ? const HomeScreen() : const LoginScreen()),

        // group card

        //     const Scaffold(
        //   body: GroupCard(),
        // ),

        // custom card
        //     const Scaffold(
        //   body: CustomCard(
        //     image: AssetImage('images/banana.png'),
        //     title: 'Banana',
        //     subtitle: 'Bananas',
        //     content: Text('2 gr.'),
        //   ),
        // ),

        // custom card 2
        //     const Scaffold(
        //   body: CustomCardTwo(
        //     color: Colors.blue,
        //     image: AssetImage('/images/beverages.png'),
        //     text: 'Beverages',
        //   ),
        // ),

        // login screen
        // const LoginScreen()

        // alert dialog
        // Scaffold(body: const AuthModal())

        // page with navigation menu
        // const HomeScreen(),
      ),
    );
  }
}
