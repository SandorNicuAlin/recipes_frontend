import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../user/user_in_a_group_badge.dart';
import '../../classes/user.dart';
import '../../colors/my_colors.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    Key? key,
    required this.name,
    required this.members,
    required this.isAdministrator,
  }) : super(key: key);

  final String name;
  final List<User> members;
  final bool isAdministrator;

  @override
  Widget build(BuildContext context) {
    List<Widget> membersWidget = [
      const SizedBox(
        width: 20,
        height: 20,
      )
    ];
    double positioned = 0.0;
    for (var i = 0; i < members.length; i++) {
      if (i == 4) {
        break;
      }
      membersWidget.add(
        Positioned(
          right: positioned,
          child: UserInAGroupBadge(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isAdministrator
                  ? const Padding(
                      padding: EdgeInsets.only(
                        left: 12.0,
                        top: 12.0,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.crown,
                        color: MyColors.greenColor,
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 8.0,
                ),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  name.replaceAll('', '\u200B'),
                  softWrap: false,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                //  Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     SizedBox(
                // width: 80,
                //   width: MediaQuery.of(context).size.width * 30 / 100,
                //   child: Text(
                //     overflow: TextOverflow.fade,
                //     name,
                //     softWrap: false,
                //     style: const TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 18,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   width: 90,
                //   height: 30,
                //   child: Stack(
                //     children: membersWidget,
                //   ),
                // ),
                // ],
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
