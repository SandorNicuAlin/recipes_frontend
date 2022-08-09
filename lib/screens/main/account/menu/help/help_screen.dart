import 'package:flutter/material.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Help',
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      body: Center(
        child: Text('Help'),
      ),
    );
  }
}
