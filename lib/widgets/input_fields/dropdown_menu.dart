import 'package:flutter/material.dart';

import '../../colors/my_colors.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({
    Key? key,
    required this.options,
    required this.icon,
    this.validatorCallback,
    this.autofocus,
  }) : super(key: key);

  final List<String> options;
  final Widget icon;
  final String? Function(String?)? validatorCallback;
  final bool? autofocus;

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  late String _dropdownValue;

  @override
  Widget build(BuildContext context) {
    _dropdownValue = widget.options[0];
    return DropdownButtonFormField<String>(
      autofocus: widget.autofocus ?? false,
      validator: widget.validatorCallback,
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.greenColor,
          ),
        ),
      ),
      icon: widget.icon,
      value: _dropdownValue,
      items: widget.options
          .map(
            (String value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
      onChanged: (String? newValue) {
        setState(() {
          _dropdownValue = newValue!;
        });
      },
    );
  }
}
