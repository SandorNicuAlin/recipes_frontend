import 'package:flutter/cupertino.dart';

class IosSearchField extends StatefulWidget {
  const IosSearchField({
    Key? key,
    required this.controller,
    required this.prefixIcon,
    required this.suffixIcon,
    this.onChangeCallback,
  }) : super(key: key);

  final Icon prefixIcon;
  final Icon suffixIcon;
  final TextEditingController controller;
  final Function(String)? onChangeCallback;

  @override
  State<IosSearchField> createState() => _IosSearchFieldState();
}

class _IosSearchFieldState extends State<IosSearchField> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      prefixIcon: Padding(
        padding: const EdgeInsets.only(top: 3.5),
        child: widget.prefixIcon,
      ),
      suffixIcon: widget.suffixIcon,
      controller: widget.controller,
      onChanged: widget.onChangeCallback,
    );
  }
}
