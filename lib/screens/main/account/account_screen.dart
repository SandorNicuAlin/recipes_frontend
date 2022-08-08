import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../../widgets/buttons/custom_elevated_button.dart';
import '../../../colors/my_colors.dart';
import './../../auth/login.dart';
import '../../../helpers/auth.dart';
import '../../../widgets/account/account_menu_item.dart';
import './menu/my_details/my_details_screen.dart';
import '../../../helpers/custom_animations.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/group_provider.dart';
import '../../../widgets/loading/text_placeholder.dart';
import '../account/menu/my_groups/user_groups_screen.dart';
import './menu/help/help_screen.dart';
import './menu/about/about_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _firstTime = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_firstTime) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<UserProvider>(context, listen: false).fetchUser();
      if (!mounted) return;
      await Provider.of<GroupProvider>(context, listen: false)
          .fetchAllForUser();
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      _firstTime = false;
    }
    super.didChangeDependencies();
  }

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
          accountHeader(),
          Column(
            children: [
              InkWell(
                onTap: _isLoading
                    ? () {}
                    : () {
                        Navigator.of(context).push(
                          CustomAnimations.pageTransitionRightToLeft(
                            const MyDetailsScreen(),
                          ),
                        );
                      },
                child: const AccountMenuItem(
                  icon: Icons.account_box_outlined,
                  text: Text(
                    'My details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Consumer<GroupProvider>(
                builder: (context, groupProvider, child) => InkWell(
                  onTap: _isLoading
                      ? () {}
                      : () {
                          Navigator.of(context).push(
                            CustomAnimations.pageTransitionRightToLeft(
                              const UserGroupsScreen(),
                            ),
                          );
                        },
                  child: AccountMenuItem(
                    icon: Icons.group_outlined,
                    text: Text(
                      _isLoading
                          ? 'My groups'
                          : 'My groups (${groupProvider.groups_by_user.length})',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: _isLoading
                    ? () {}
                    : () {
                        Navigator.of(context).push(
                          CustomAnimations.pageTransitionRightToLeft(
                            const HelpScreen(),
                          ),
                        );
                      },
                child: const AccountMenuItem(
                  icon: Icons.help_outline,
                  text: Text(
                    'Help',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              InkWell(
                onTap: _isLoading
                    ? () {}
                    : () {
                        Navigator.of(context).push(
                          CustomAnimations.pageTransitionRightToLeft(
                            const AboutScreen(),
                          ),
                        );
                      },
                child: const AccountMenuItem(
                  icon: Icons.info_outline,
                  text: Text(
                    'About',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
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

  Widget accountHeader() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) => Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xffE2E2E2),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 5 / 100,
              vertical: MediaQuery.of(context).size.height * 3 / 100),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _isLoading ? Colors.grey : MyColors.greenColor,
                ),
                width: 50,
                height: 50,
                child: Center(
                  child: Text(
                    _isLoading
                        ? ''
                        : userProvider.user.username[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 3 / 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _isLoading
                      ? const TextPlaceholder(width: 120)
                      : Text(
                          userProvider.user.username,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 / 100,
                  ),
                  _isLoading
                      ? const TextPlaceholder()
                      : Text(
                          userProvider.user.email,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
