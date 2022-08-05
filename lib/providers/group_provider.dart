import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/group.dart';
import '../helpers/http_request.dart';

class GroupProvider with ChangeNotifier {
  List<Group> _groups = [];

  List<Group> get groups {
    return _groups;
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

    _groups = [];
    decodedBody['groups'].forEach((group) {
      _groups.add(
        Group(
          id: group['id'],
          name: group['name'],
        ),
      );
    });

    notifyListeners();
  }
}
