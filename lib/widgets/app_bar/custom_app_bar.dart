import 'package:flutter/material.dart';

class CustomAppBar {
  static AppBar customAppBar({
    required BuildContext context,
    required String title,
    List<Widget>? actions,
  }) {
    return AppBar(
      actions: actions ?? [],
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.white10,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      foregroundColor: Colors.black,
      shape: const Border(
        bottom: BorderSide(color: Colors.black12),
      ),
    );
  }
}
