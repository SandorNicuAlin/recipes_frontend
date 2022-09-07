import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/product.dart';
import '../helpers/http_request.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return _products;
  }

  void resetProducts() {
    _products = [];
    notifyListeners();
  }

  Future<Map> fetchByText(String filterText) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/products');

    var response = await http.post(
      url,
      body: jsonEncode({
        'filter_text': filterText,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    _products = [];
    decodedBody['products'].forEach((product) {
      _products.add(
        Product(
          id: product['id'],
          name: product['name'],
          um: product['um'],
        ),
      );
    });

    if (filterText.isEmpty) {
      _products = [];
    }

    notifyListeners();

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }
}
