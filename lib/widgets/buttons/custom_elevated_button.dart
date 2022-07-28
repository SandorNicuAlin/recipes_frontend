import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.text,
    this.onSubmitCallback,
    this.backgroundColor,
  }) : super(key: key);

  final void Function()? onSubmitCallback;
  final Color? backgroundColor;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          backgroundColor!,
        ),
      ),
      onPressed: onSubmitCallback!,
      child: Text(text!),
    );
  }
}
