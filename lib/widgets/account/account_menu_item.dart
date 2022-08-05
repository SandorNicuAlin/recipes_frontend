import 'package:flutter/material.dart';

class AccountMenuItem extends StatelessWidget {
  const AccountMenuItem({
    Key? key,
    this.icon,
    this.text,
  }) : super(key: key);

  final IconData? icon;
  final Widget? text;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            vertical: MediaQuery.of(context).size.height * 2 / 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon!),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 3 / 100,
                ),
                text!,
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
