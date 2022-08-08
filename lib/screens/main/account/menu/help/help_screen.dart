import 'package:flutter/material.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'Help',
        border: const Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      body: const Center(
        child: Text('Help Screen'),
      ),
    );
  }
}
