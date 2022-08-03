import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/buttons/custom_elevated_button.dart';
import '../../../colors/my_colors.dart';
import './../../auth/login.dart';
import '../../../helpers/auth.dart';
import '../../../widgets/account/account_menu_item.dart';
import '../../../widgets/account/account_header.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AccountHeader(),
          Column(
            children: const [
              AccountMenuItem(
                icon: Icons.account_box_outlined,
                text: Text(
                  'My details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              AccountMenuItem(
                icon: Icons.group_outlined,
                text: Text(
                  'My groups',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              AccountMenuItem(
                icon: Icons.help_outline,
                text: Text(
                  'Help',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              AccountMenuItem(
                icon: Icons.info_outline,
                text: Text(
                  'About',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2.5 / 100,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 90 / 100,
              height: 70,
              child: CustomElevatedButton(
                backgroundColor: const Color(0xffF2F3F2),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.logout, color: MyColors.greenColor),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Log Out',
                      style: TextStyle(
                        color: MyColors.greenColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                onSubmitCallback: () async {
                  await _logOutHandler();
                  if (true) {}
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
