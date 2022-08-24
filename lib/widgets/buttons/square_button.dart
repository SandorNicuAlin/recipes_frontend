import 'package:flutter/material.dart';

import '../../colors/my_colors.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    Key? key,
    required this.content,
    this.borderRadius,
  }) : super(key: key);

  final double? borderRadius;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 11),
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.3,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 11),
          ),
          child: content,
        ),
      ),
    );
  }
}
