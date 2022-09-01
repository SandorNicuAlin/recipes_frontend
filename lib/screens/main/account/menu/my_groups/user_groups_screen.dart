import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../../providers/group_provider.dart';
import '../../../../../widgets/cards/group_card.dart';
import '../../../../../helpers/custom_animations.dart';
import './single_user_group_screen.dart';
import './create_group_screen.dart';

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
        title: 'My Groups',
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 20.0,
            ),
            child: Icon(
              Icons.add_rounded,
            ),
          )
        ],
        onActionTapCallback: () {
          Navigator.of(context).push(
            CustomAnimations.pageTransitionRightToLeft(
              const CreateGroupScreen(),
            ),
          );
        },
      ),
      body: Consumer<GroupProvider>(
        builder: (context, groupProvider, child) => Center(
          child: groupProvider.groups_by_user.isEmpty
              ? const Center(
                  child: Text(
                    'Your are not currently part of any group',
                    style: TextStyle(color: Colors.black45),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    children: [
                      ...groupProvider.groups_by_user.map(
                        (group) => InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (
                                  BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                ) =>
                                    SingleUserGroupScreen(
                                  groupId: group.id,
                                  name: group.name,
                                  isAdministrator: group.isAdministrator!,
                                ),
                                transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) =>
                                    Align(
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: GroupCard(
                            name: group.name,
                            members: group.members,
                            isAdministrator: group.isAdministrator!,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
