import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/group.dart';
import '../classes/user.dart';
import '../helpers/http_request.dart';

class GroupProvider with ChangeNotifier {
  List<Group> _groups_by_user = [];

  List<Group> get groups_by_user {
    return _groups_by_user;
  }

  Group? groupByName(String name) {
    for (var group in _groups_by_user) {
      if (group.name == name) {
        return group;
      }
    }
    return null;
  }

  Future<void> fetchAllForUser() async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/user/groups');
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

    _groups_by_user = [];
    decodedBody['groups'].forEach((group) {
      _groups_by_user.add(
        Group(
          id: group['id'],
          name: group['name'],
          members: group['members']
              .map<User>(
                (user) => User(
                  id: user['id'],
                  username: user['username'],
                  email: user['email'],
                  phone: user['phone'],
                ),
              )
              .toList(),
        ),
      );
    });

    notifyListeners();
  }
}
