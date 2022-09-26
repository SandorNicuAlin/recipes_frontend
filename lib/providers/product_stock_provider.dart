import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/product_stock.dart';
import '../classes/product.dart';
import '../helpers/http_request.dart';

class ProductStockProvider with ChangeNotifier {
  List<ProductStock> _stock = [];

  List<ProductStock> get stock {
    return _stock.reversed.toList();
  }

  Future<void> fetchStock() async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/product-stock');
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

    _stock = [
      ...decodedBody['product_stock']
          .map(
            (productStock) => ProductStock(
              id: productStock['id'],
              quantity: productStock['quantity'],
              product: Product(
                id: productStock['product']['id'],
                name: productStock['product']['name'],
                um: productStock['product']['um'],
              ),
            ),
          )
          .toList()
    ];

    notifyListeners();
  }

  Future<Map> addStock(
    String quantity,
    String name,
    String um,
  ) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/product-stock/add');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          'quantity': quantity,
          'product': {
            'name': name,
            'um': um,
          }
        },
      ),
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    await fetchStock();

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }

  Future<Map> updateQuantity(String quantity, int productStockId) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/product-stock/update');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          'value': quantity,
          'product_stock_id': productStockId,
        },
      ),
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    await fetchStock();

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }

  Future<Map> incrementDecrementQuantity(
    bool isIncrementing,
    int productStockId,
  ) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse(
        '${HttpRequest.baseUrl}/api/product-stock/increment-decrement');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          'is_incrementing': isIncrementing,
          'product_stock_id': productStockId,
        },
      ),
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    await fetchStock();

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }

  Future<Map> removeStock(int productStockId) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/product-stock/remove');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          'product_stock_id': productStockId,
        },
      ),
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    await fetchStock();

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }

  Future<Map> updateStockAfterCooking(int recipeId) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url =
        Uri.parse('${HttpRequest.baseUrl}/api/product-stock/remove-for-recipe');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          'recipe_id': recipeId,
        },
      ),
    );

    print('statusCode: ${response.statusCode}');
    print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }
}
