import 'package:flutter/material.dart';

class CustomAccordion extends StatefulWidget {
  const CustomAccordion({
    Key? key,
    required this.title,
    required this.content,
    this.showContent = false,
  }) : super(key: key);

  final Widget title;
  final Widget content;
  final bool showContent;

  @override
  State<CustomAccordion> createState() => _CustomAccordionState();
}

class _CustomAccordionState extends State<CustomAccordion> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _showContent = !_showContent;
        });
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black12,
            ),
            bottom: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: 3.0, right: 10.0),
              title: widget.title,
              trailing: _showContent
                  ? const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    )
                  : const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
            ),
            _showContent
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 3.0,
                      right: 3.0,
                      bottom: 10.0,
                    ),
                    child: widget.content,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
