class HttpRequest {
  static const key = '';
  static const baseUrl = bool.fromEnvironment('PRODUCTION')
      ? 'https://lara-recipes.herokuapp.com'
      : 'http://127.0.0.1:8000';
}
