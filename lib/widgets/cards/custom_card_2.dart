import 'package:flutter/material.dart';

class CustomCardTwo extends StatelessWidget {
  const CustomCardTwo({
    Key? key,
    required this.color,
    required this.image,
    required this.text,
  }) : super(key: key);

  final ImageProvider<Object> image;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            border: Border.all(color: color.withAlpha(125), width: 1.3),
            borderRadius: BorderRadius.circular(15),
          ),
          width: MediaQuery.of(context).size.height * 25 / 100,
          height: MediaQuery.of(context).size.height * 28 / 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: image,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
