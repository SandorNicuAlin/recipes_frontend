import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/recipe.dart';
import '../helpers/http_request.dart';

class RecipeProvier with ChangeNotifier {
  List<Recipe> _recipes = [];

  List<Recipe> get recipes {
    return _recipes;
  }

  Future<void> getAllForGroups(List groups) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/recipes');
    var response = await http.post(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    }, body: {
      'groups': groups,
    });

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    _recipes = [];
    decodedBody['recipes'].forEach((recipe) {
      _recipes.add(
        Recipe(
          id: recipe['id'],
          name: recipe['name'],
          description: recipe['description'],
        ),
      );
    });

    notifyListeners();
  }
}
