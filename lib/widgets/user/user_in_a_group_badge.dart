import 'package:flutter/material.dart';

import '../../colors/my_colors.dart';

class UserInAGroupBadge extends StatelessWidget {
  const UserInAGroupBadge({
    Key? key,
    required this.char,
  }) : super(key: key);

  final String char;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.2,
          color: Colors.green[700]!,
        ),
        borderRadius: BorderRadius.circular(20),
        color: MyColors.greenColor,
      ),
      width: 25,
      height: 25,
      child: Center(
        child: Text(
          char,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
