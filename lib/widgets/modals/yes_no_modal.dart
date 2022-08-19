import 'package:flutter/cupertino.dart';

class YesNoModal {
  static Widget yesNoModal(
      {Widget? title,
      required Widget content,
      List<CupertinoDialogAction>? actions}) {
    return CupertinoAlertDialog(
      title: title ?? const Text(''),
      content: content,
      actions: actions ?? [],
    );
  }
}
