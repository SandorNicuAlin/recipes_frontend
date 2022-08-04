import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/user.dart';
import '../helpers/http_request.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User get user {
    return _user!;
  }

  Future<void> fetchUser() async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/user');
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

    _user = User(
      id: decodedBody['user']['id'],
      username: decodedBody['user']['username'],
      email: decodedBody['user']['email'],
      phone: decodedBody['user']['phone'],
    );

    notifyListeners();
  }

  Future<Map> editUser(String selector, String value) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/edit');
    // print(selector);
    // print(value);
    var response = await http.post(
      url,
      body: jsonEncode({
        'selector': selector,
        'value': value,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    await fetchUser();

    return {
      'statusCode': response.statusCode,
      'body': response.body,
    };
  }
}
