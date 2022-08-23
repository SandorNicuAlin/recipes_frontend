import 'package:flutter/material.dart';

import '../../../widgets/app_bar/custom_app_bar_with_image.dart';

class SingleRecipeScreen extends StatelessWidget {
  const SingleRecipeScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
  }) : super(key: key);

  final int id;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 40 / 100,
        ),
        child: CustomAppBarWithImage(
          image: const AssetImage('images/groceries.png'),
          title: name,
        ),
      ),
      body: Column(
        children: [
          Text(name),
          Text(description),
        ],
      ),
    );
  }
}
