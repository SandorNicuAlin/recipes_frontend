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
    this.maxLines,
    this.decoration,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final String? Function(String?)? validatorCallback;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Function(String)? onChanged;
  final int? maxLines;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: onChanged ?? (_) {},
      autofocus: autofocus ?? false,
      focusNode: focusNode ?? FocusNode(),
      controller: controller,
      keyboardType: keyboardType!,
      cursorColor: MyColors.greenColor,
      decoration: decoration ??
          InputDecoration(
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
