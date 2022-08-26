import 'package:flutter/material.dart';

import '../buttons/custom_elevated_button.dart';
import '../../colors/my_colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.content,
    this.onClickCallback,
    this.onDeleteCallback,
  }) : super(key: key);

  final ImageProvider<Object> image;
  final String title;
  final String subtitle;
  final Widget content;
  final void Function()? onClickCallback;
  final void Function()? onDeleteCallback;

  final EdgeInsetsGeometry _symmetricOneEdgeInsets =
      const EdgeInsets.symmetric(vertical: 1);
  final FontWeight _fontWeightBold = FontWeight.bold;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: onClickCallback ?? () {},
        splashFactory: NoSplash.splashFactory,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    onDeleteCallback == null
                        ? Container()
                        : Positioned(
                            right: 0,
                            child: IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashRadius: 30,
                              icon: const Icon(
                                Icons.close,
                                color: Colors.grey,
                                size: 18,
                              ),
                              onPressed: onDeleteCallback,
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Image(
                          image: image,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: _symmetricOneEdgeInsets,
                        child: Text(
                          title,
                          style: TextStyle(fontWeight: _fontWeightBold),
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: _symmetricOneEdgeInsets,
                        child: Text(
                          subtitle,
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
