import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/activity/notification_item.dart';
import '../../../providers/notification_provider.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Text(
              'Notifications',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Consumer<NotificationProvider>(
            builder: (context, notificationProvider, child) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 11 / 100,
                ),
                child: notificationProvider.notifications.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Image.asset('assets/images/inbox.gif'),
                            ),
                            const Text(
                              'Your inbox is empty at the moment',
                              style: TextStyle(color: Colors.black45),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: notificationProvider.notifications.length,
                        itemBuilder: (context, index) {
                          String groupIdStr = notificationProvider
                              .notifications[index].type
                              .replaceAll(RegExp(r'[^0-9]'), '');
                          int groupIdInt = int.parse(groupIdStr);
                          return NotificationItem(
                            key: Key(
                              notificationProvider.notifications[index].id
                                  .toString(),
                            ),
                            notificationId:
                                notificationProvider.notifications[index].id,
                            groupId: groupIdInt,
                            type:
                                notificationProvider.notifications[index].type,
                            text:
                                notificationProvider.notifications[index].text,
                            seen:
                                notificationProvider.notifications[index].seen,
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
