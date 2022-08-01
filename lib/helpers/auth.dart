import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_request.dart';

class Auth {
  static Future<Map> register(
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

    final decodeBody = json.decode(response.body) as Map<String, dynamic>;

    return {
      'statusCode': response.statusCode,
      'body': decodeBody,
    };
  }

  static Future<int> login(
    String email,
    String password,
  ) async {
    var url = Uri.parse('${HttpRequest.baseUrl}/api/login');
    var response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
        'device_name': await _getDeviceName(),
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // TODO
    print('Response status: ${response.statusCode}');
    print(
        'Response body: ${json.decode(response.body) as Map<String, dynamic>}');

    final decodedBody = json.decode(response.body) as Map<String, dynamic>;
    final localStorage = await SharedPreferences.getInstance();
    localStorage.setString('API_ACCESS_KEY', decodedBody['token']);
    return response.statusCode;
  }

  static Future<String> _getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      return info.model!;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      return info.name!;
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      WebBrowserInfo info = await deviceInfo.webBrowserInfo;
      return info.appName!;
    }
    return 'noname';
  }
}
