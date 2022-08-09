import 'package:flutter/material.dart';

import '../user/user_in_a_group_badge.dart';
import '../../classes/user.dart';
import '../../colors/my_colors.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    Key? key,
    required this.name,
    required this.members,
  }) : super(key: key);

  final String name;
  final List<User> members;

  @override
  Widget build(BuildContext context) {
    List<Widget> membersWidget = [
      const SizedBox(
        width: 25,
        height: 25,
      )
    ];
    double positioned = 0.0;
    for (var i = 0; i < members.length; i++) {
      if (i == 5) {
        break;
      }
      membersWidget.add(
        Positioned(
          right: positioned,
          child: UserInAGroup(
            char: members[i].username[0].toUpperCase(),
          ),
        ),
      );
      positioned += 20.0;
    }

    return Card(
      elevation: 5,
      child: Stack(
        children: [
          Hero(
            tag: 'group:$name',
            child: const Image(
              fit: BoxFit.fill,
              image: AssetImage('images/groceries_2_2x.png'),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        overflow: TextOverflow.fade,
                        name,
                        softWrap: false,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 30,
                      child: Stack(
                        children: membersWidget,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
