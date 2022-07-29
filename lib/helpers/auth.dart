import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'http_request.dart';

class Auth {
  static Future<int> register(
    String username,
    String email,
    String phone,
    String password,
  ) async {
    var url = Uri.parse('${HttpRequest.baseUrl}/api/register');
    var response = await http.post(
      url,
      body: jsonEncode({
        'username': username,
        'email': email,
        'phone': phone,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.statusCode;
  }
}
