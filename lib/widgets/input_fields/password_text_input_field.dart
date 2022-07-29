import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../colors/my_colors.dart';

class PasswordTextInputField extends StatefulWidget {
  const PasswordTextInputField({
    Key? key,
    this.passwordType = 'password',
    this.controller,
    this.label,
    this.keyboardType,
    this.validatorCallback,
  }) : super(key: key);

  final String? passwordType;
  final TextEditingController? controller;
  final String? label;
  final String? Function(String?)? validatorCallback;
  final TextInputType? keyboardType;

  @override
  State<PasswordTextInputField> createState() => _PasswordTextInputFieldState();
}

class _PasswordTextInputFieldState extends State<PasswordTextInputField> {
  bool _passwordVisibility = true;
  bool _confirmPasswordVisibility = true;

  void _changePasswordVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
    });
  }

  void _changeConfirmPasswordVisibility() {
    setState(() {
      _confirmPasswordVisibility = !_confirmPasswordVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType!,
      controller: widget.controller!,
      obscureText: widget.passwordType == 'password'
          ? _passwordVisibility
          : _confirmPasswordVisibility,
      cursorColor: MyColors.greenColor,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: widget.passwordType == 'password'
              ? _changePasswordVisibility
              : _changeConfirmPasswordVisibility,
          icon: (widget.passwordType == 'password'
                  ? _passwordVisibility
                  : _confirmPasswordVisibility)
              ? const Icon(
                  FontAwesomeIcons.eye,
                  size: 16,
                  color: Colors.grey,
                )
              : const Icon(
                  FontAwesomeIcons.eyeSlash,
                  size: 16,
                  color: Colors.grey,
                ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.greenColor,
          ),
        ),
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        label: Text(widget.label!),
      ),
      validator: widget.validatorCallback!,
    );
  }
}
