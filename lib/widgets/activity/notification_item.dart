import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

import '../../colors/my_colors.dart';
import '../../widgets/buttons/custom_elevated_button.dart';
import '../../providers/notification_provider.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({
    Key? key,
    required this.notificationId,
    required this.groupId,
    required this.type,
    required this.text,
    required this.seen,
  }) : super(key: key);

  final int notificationId;
  final int groupId;
  final String type;
  final String text;
  final bool seen;

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool _isLoading = false;

  Future<void> _confirmInvite() async {
    setState(() {
      _isLoading = true;
    });
    Map response =
        await Provider.of<NotificationProvider>(context, listen: false)
            .confirmGroupInvitation(widget.groupId);
    if (response['statusCode'] == 400) {
      if (true) {}
      await Flushbar(
        backgroundColor: Colors.red,
        title: 'Error',
        message: 'Something went wrong',
        duration: const Duration(seconds: 3),
      ).show(context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _removeInvitation() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<NotificationProvider>(context, listen: false)
        .deleteNotification(widget.notificationId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width *
                (widget.seen ? 60 : 40) /
                100,
            child: Text(
              widget.text,
              style: TextStyle(
                fontWeight: widget.seen ? FontWeight.normal : FontWeight.bold,
              ),
            ),
          ),
          _isLoading
              ? Container(
                  width: 50,
                  padding: const EdgeInsets.only(right: 10),
                  child: const LinearProgressIndicator(
                    color: MyColors.greenColor,
                    backgroundColor: Colors.white,
                  ),
                )
              : widget.seen
                  ? const Icon(Icons.check_rounded, color: MyColors.greenColor)
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          borderRadius: 5,
                          backgroundColor: MyColors.greenColor,
                          content: const Text('Confirm'),
                          onSubmitCallback: _confirmInvite,
                        ),
                        const SizedBox(width: 10),
                        CustomElevatedButton(
                          borderRadius: 5,
                          backgroundColor: Colors.grey,
                          content: const Text('Remove'),
                          onSubmitCallback: _removeInvitation,
                        )
                      ],
                    )
        ],
      ),
    );
  }
}
