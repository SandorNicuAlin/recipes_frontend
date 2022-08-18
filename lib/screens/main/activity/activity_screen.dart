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
              child: notificationProvider.notifications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(
                            image: AssetImage('images/success_grey.png'),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
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
                          notificationId:
                              notificationProvider.notifications[index].id,
                          groupId: groupIdInt,
                          type: notificationProvider.notifications[index].type,
                          text: notificationProvider.notifications[index].text,
                          seen: notificationProvider.notifications[index].seen,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
