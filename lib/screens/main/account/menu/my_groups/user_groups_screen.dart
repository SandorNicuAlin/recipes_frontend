import 'package:flutter/material.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';

class UserGroupsScreen extends StatefulWidget {
  const UserGroupsScreen({Key? key}) : super(key: key);

  @override
  State<UserGroupsScreen> createState() => _UserGroupsScreenState();
}

class _UserGroupsScreenState extends State<UserGroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'My Groups',
      ),
      body: const Center(
        child: Text('groups..'),
      ),
    );
  }
}
