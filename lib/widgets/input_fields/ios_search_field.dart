import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosSearchField extends StatefulWidget {
  const IosSearchField({
    Key? key,
    required this.prefixIcon,
  }) : super(key: key);

  final Widget prefixIcon;

  @override
  State<IosSearchField> createState() => _IosSearchFieldState();
}

class _IosSearchFieldState extends State<IosSearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      prefixIcon: const Padding(
        padding: EdgeInsets.only(top: 3.5),
        child: Icon(Icons.search_rounded),
      ),
      suffixIcon: const Icon(Icons.clear_rounded),
      controller: _controller,
    );
  }
}
