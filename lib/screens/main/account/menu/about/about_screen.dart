import 'package:flutter/material.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'About',
        border: const Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      body: const Center(
        child: Text('About Screen'),
      ),
    );
  }
}
