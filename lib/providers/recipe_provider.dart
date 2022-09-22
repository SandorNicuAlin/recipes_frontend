import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/recipe.dart';
import '../helpers/http_request.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _filteredRecipes = [];
  List<Recipe> _availableRecipes = [];

  List<Recipe> get filteredRecipes {
    return _filteredRecipes;
  }

  List<Recipe> get availableRecipes {
    return _availableRecipes;
  }

  Future<void> getAvailableForGroups(List groups) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/recipes/get-available');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          'groups': groups,
        },
      ),
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    _availableRecipes = [];
    _filteredRecipes = [];
    decodedBody['recipes'].forEach((recipe) {
      _availableRecipes.add(
        Recipe(
          id: recipe['id'],
          name: recipe['name'],
          description: recipe['description'],
        ),
      );
      _filteredRecipes.add(
        Recipe(
          id: recipe['id'],
          name: recipe['name'],
          description: recipe['description'],
        ),
      );
    });

    notifyListeners();
  }

  void filterByText(String text) {
    _filteredRecipes = _availableRecipes
        .where(
            (recipe) => recipe.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
