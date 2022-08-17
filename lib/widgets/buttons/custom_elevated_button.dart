import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.content,
    this.onSubmitCallback,
    this.backgroundColor,
    required this.borderRadius,
  }) : super(key: key);

  final void Function()? onSubmitCallback;
  final Color? backgroundColor;
  final Widget? content;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          backgroundColor!,
        ),
      ),
      onPressed: onSubmitCallback!,
      child: content!,
    );
  }
}
