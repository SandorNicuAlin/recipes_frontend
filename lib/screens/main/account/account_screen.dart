import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/buttons/custom_elevated_button.dart';
import '../../../colors/my_colors.dart';
import './../../auth/login.dart';
import '../../../helpers/auth.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  Future<void> _logOutHandler() async {
    await Auth.logout();
    final localStorage = await SharedPreferences.getInstance();
    localStorage.setString('API_ACCESS_KEY', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomElevatedButton(
          backgroundColor: MyColors.greenColor,
          content: const Text('Log Out'),
          onSubmitCallback: () async {
            await _logOutHandler();
            if (true) {}
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          },
        ),
      ),
    );
  }
}
