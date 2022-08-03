import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../classes/user.dart';
import '../../colors/my_colors.dart';
import '../loading/text_placeholder.dart';

class AccountHeader extends StatefulWidget {
  const AccountHeader({Key? key}) : super(key: key);

  @override
  State<AccountHeader> createState() => _AccountHeaderState();
}

class _AccountHeaderState extends State<AccountHeader> {
  bool _firstTime = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_firstTime) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<UserProvider>(context, listen: false).fetchUser();
      setState(() {
        _isLoading = false;
      });
      _firstTime = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                        : userProvider.user.username![0].toUpperCase(),
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
                          userProvider.user.username!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 / 100,
                  ),
                  _isLoading
                      ? const TextPlaceholder()
                      : Text(
                          userProvider.user.email!,
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
