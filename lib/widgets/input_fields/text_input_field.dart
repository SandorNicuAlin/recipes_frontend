import 'package:flutter/material.dart';

import '../../colors/my_colors.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    this.controller,
    this.label,
    this.validatorCallback,
    this.keyboardType,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final String? Function(String?)? validatorCallback;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType!,
      cursorColor: MyColors.greenColor,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.greenColor,
          ),
        ),
        label: Text(label!),
      ),
      validator: validatorCallback!,
    );
  }
}
