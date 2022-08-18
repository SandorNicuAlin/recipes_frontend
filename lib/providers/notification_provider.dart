import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/app_notification.dart';
import '../helpers/http_request.dart';

class NotificationProvider with ChangeNotifier {
  List<AppNotification> _notifications = [];

  List<AppNotification> get notifications {
    return _notifications;
  }

  Future<void> fetchAllNotifications() async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/notifications');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    _notifications = [
      ...decodedBody['notifications']
          .map(
            (notification) => AppNotification(
              id: notification['id'],
              type: notification['type'],
              text: notification['text'],
              seen: notification['seen'] == 1 ? true : false,
            ),
          )
          .toList()
    ];

    notifyListeners();
  }

  Future<Map> confirmGroupInvitation(groupId) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/groups/add-members');
    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'group_id': groupId.toString(),
      },
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    await fetchAllNotifications();

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }

  Future<void> deleteNotification(notificationId) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/notifications/delete');
    await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'notification_id': notificationId.toString(),
      },
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    await fetchAllNotifications();
  }
}
