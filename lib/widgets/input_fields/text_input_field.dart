import 'package:flutter/material.dart';

import '../../colors/my_colors.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    this.controller,
    this.label,
    this.validatorCallback,
    this.keyboardType,
    this.focusNode,
    this.autofocus,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final String? Function(String?)? validatorCallback;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged ?? (_) {},
      autofocus: autofocus ?? false,
      focusNode: focusNode ?? FocusNode(),
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
