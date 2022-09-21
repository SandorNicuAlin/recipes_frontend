import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../modals/yes_no_modal.dart';

class DeletableGreyElement extends StatelessWidget {
  const DeletableGreyElement({
    Key? key,
    required this.thisIndex,
    required this.name,
    required this.description,
    required this.onDelete,
    required this.elementType,
  }) : super(key: key);

  final int thisIndex;
  final String name;
  final String description;
  final Function onDelete;
  final String elementType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
        ),
        color: Colors.black26,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "${(thisIndex + 1).toString()}. $name: $description",
                style: TextStyle(
                  color: Colors.black.withAlpha(200),
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => YesNoModal.yesNoModal(
                    title: Text(
                      'Delete $elementType',
                    ),
                    content: Text(
                      "Do you want to delete '$name' $elementType?",
                    ),
                    actions: [
                      CupertinoDialogAction(
                          child: const Text('Yes'),
                          onPressed: () {
                            Navigator.pop(context);
                            onDelete({
                              'name': name,
                              'description': description,
                            });
                          }),
                      CupertinoDialogAction(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  barrierDismissible: true,
                );
              },
              child: const Icon(
                CupertinoIcons.clear_circled_solid,
                color: Colors.black26,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
