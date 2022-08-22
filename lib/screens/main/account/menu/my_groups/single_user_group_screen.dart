import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:another_flushbar/flushbar.dart';

import '../../../../../widgets/app_bar/custom_app_bar_with_image.dart';
import '../../../../../providers/group_provider.dart';
import '../../../../../classes/group.dart';
import '../../../../../colors/my_colors.dart';
import '../../../../../widgets/modals/yes_no_modal.dart';
import '../../../../../helpers/custom_animations.dart';
import './add_member_screen.dart';

class SingleUserGroupScreen extends StatelessWidget {
  const SingleUserGroupScreen({
    Key? key,
    required this.groupId,
    required this.name,
    required this.isAdministrator,
  }) : super(key: key);

  final int groupId;
  final String name;
  final bool isAdministrator;

  Future<void> _giveAdminPrivilages(
    BuildContext context,
    userId,
    groupId,
  ) async {
    Navigator.pop(context);
    Map response = await Provider.of<GroupProvider>(
      context,
      listen: false,
    ).giveAdminPrivilages(
      userId,
      groupId,
    );

    if (response['statusCode'] == 400) {
      if (true) {}
      await Flushbar(
        backgroundColor: Colors.red,
        title: 'Error',
        message: 'Something went wrong',
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 60 / 100,
        ),
        child: CustomAppBarWithImage(
          image: const AssetImage('images/groceries_2_2x.png'),
          title: name,
          actions: isAdministrator
              ? [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          CustomAnimations.pageTransitionRightToLeft(
                            AddGroupMemberScreen(
                              groupId: groupId,
                              groupName: name,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.group_add_rounded),
                    ),
                  ),
                ]
              : [],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Consumer<GroupProvider>(
                builder: (context, groupProvider, child) {
                  Group group = groupProvider.groupByName(name)!;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListView.builder(
                        itemCount: group.members.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColors.greenColor,
                                    ),
                                    width: 45,
                                    height: 45,
                                    child: Center(
                                      child: Text(
                                        group.members[index].username[0]
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        3 /
                                        100,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        group.members[index].username,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5 /
                                                100,
                                      ),
                                      Text(
                                        group.members[index].email,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              group.members[index].isAdministrator!
                                  ? const FaIcon(
                                      FontAwesomeIcons.solidChessKing,
                                      color: MyColors.greenColor,
                                    )
                                  : (isAdministrator
                                      ? InkWell(
                                          child: const FaIcon(
                                            FontAwesomeIcons.chessKing,
                                            color: MyColors.greenColor,
                                          ),
                                          onTap: () {
                                            showCupertinoDialog(
                                              context: context,
                                              builder: (context) =>
                                                  YesNoModal.yesNoModal(
                                                title: const Text(
                                                  'Administrator Privilages',
                                                ),
                                                content: Text(
                                                  'Do you want to give ${group.members[index].username} administrator privilages?',
                                                ),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    child: const Text('Yes'),
                                                    onPressed: () async {
                                                      await _giveAdminPrivilages(
                                                        context,
                                                        group.members[index].id,
                                                        group.id,
                                                      );
                                                    },
                                                  ),
                                                  CupertinoDialogAction(
                                                    child: const Text('No'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ),
                                              barrierDismissible: true,
                                            );
                                          },
                                        )
                                      : Container()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
