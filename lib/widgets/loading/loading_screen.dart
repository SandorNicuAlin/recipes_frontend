import 'package:flutter/material.dart';

import 'custom_circular_progress_indicator.dart';
import '../../colors/my_colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.greenColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Image.asset('assets/images/carrot_white.png'),
            ),
            const SizedBox(
              height: 100,
            ),
            const CustomCircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
