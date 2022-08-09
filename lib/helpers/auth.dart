import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_request.dart';
import '../widgets/modals/auth_modal.dart';

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

  static Future<Map> login(
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

    final decodedBody = json.decode(response.body) as Map<String, dynamic>;

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }

  static Future<String> _getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      return 'android';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      return info.name!;
    } else if (kIsWeb) {
      WebBrowserInfo info = await deviceInfo.webBrowserInfo;
      return info.browserName.toString();
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      WindowsDeviceInfo info = await deviceInfo.windowsInfo;
      return info.computerName;
    }
    return 'noname';
  }

  static Future<void> logout() async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/logout');
    await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
  }

  static void navigatorPop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void badServerRequestsHandler(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AuthModal.authModal(
        context,
        title: 'Server Error - 500',
        subtitle: 'Something went wrong!',
        image: const Image(
          image: AssetImage('assets/images/groceries.png'),
        ),
        buttonText: 'Try again',
        buttonCallback: navigatorPop,
      ),
    );
  }
}
