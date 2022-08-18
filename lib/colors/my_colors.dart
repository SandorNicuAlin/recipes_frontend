import 'package:flutter/material.dart';

class MyColors {
  static const Color greenColor = Color(0xff53B175);

  static Color generateRandomColor() {
    return ([
      Colors.blue,
      Colors.red,
      Colors.yellow,
      Colors.orange,
      Colors.brown,
      Colors.indigo,
      Colors.teal,
      Colors.pink,
      Colors.purple,
      Colors.lime,
    ]..shuffle())
        .first;
  }
}
