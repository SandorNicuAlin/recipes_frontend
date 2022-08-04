import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../helpers/custom_animations.dart';
import './edit_user_screen.dart';

class MyDetailsScreen extends StatelessWidget {
  const MyDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/my_details_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(
        context: context,
        title: 'My Details',
      ),
      body: SingleChildScrollView(
        child: Consumer<UserProvider>(
          builder: (context, user, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    CustomAnimations.pageTransitionRightToLeft(
                      EditUserScreen(characteristic: 'Name'),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 16.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(fontSize: 17),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 70 / 100,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black12))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 8.0, bottom: 16.0),
                          child: Text(
                            user.user.username!,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    CustomAnimations.pageTransitionRightToLeft(
                      EditUserScreen(characteristic: 'Email'),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 16.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(fontSize: 17),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 70 / 100,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black12))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 8.0, bottom: 16.0),
                          child: Text(
                            user.user.email!,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    CustomAnimations.pageTransitionRightToLeft(
                      EditUserScreen(characteristic: 'Phone'),
                    ),
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black12),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 16.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Phone',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 70 / 100,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, top: 8.0, bottom: 16.0),
                            child: Text(
                              user.user.phone!,
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Edit your profile by tapping on each element.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
