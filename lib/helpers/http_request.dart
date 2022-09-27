import 'dart:io';

class HttpRequest {
  static const key = '';
  static String baseUrl = Platform.environment['PRODUCTION'] == 'true'
      ? 'https://lara-recipes.herokuapp.com'
      : 'http://127.0.0.1:8000';
}
