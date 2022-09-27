class HttpRequest {
  static const key = '';
  static const baseUrl = String.fromEnvironment('PRODUCTION') == 'true'
      ? 'https://lara-recipes.herokuapp.com'
      : 'http://127.0.0.1:8000';
}
