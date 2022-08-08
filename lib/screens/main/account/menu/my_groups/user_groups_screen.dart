import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../../providers/group_provider.dart';

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
        border: const Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      body: Consumer<GroupProvider>(
        builder: (context, groupProvider, child) => Center(
          child: groupProvider.groups_by_user.isEmpty
              ? const Center(
                  child: Text('You are not part of any group yet.'),
                )
              : Column(
                  children: [
                    ...groupProvider.groups_by_user.map(
                      (group) => Text(group.name),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
