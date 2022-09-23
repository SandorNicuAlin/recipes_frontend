import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/recipe_step.dart';
import '../classes/ingredient.dart';
import '../helpers/http_request.dart';

class RecipeStepProvider with ChangeNotifier {
  List<RecipeStep> _recipeSteps = [];

  List<RecipeStep> get recipeSteps {
    return _recipeSteps;
  }

  List<Ingredient> _ingredients = [];

  List<Ingredient> get ingredients {
    return _ingredients;
  }

  Future<void> fetchAllForRecipe(recipeId) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/recipe-steps');
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

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    _recipeSteps = [];
    decodedBody['recipe_steps'].forEach((recipeStep) {
      _recipeSteps.add(
        RecipeStep(
          id: recipeStep['id'],
          name: recipeStep['name'],
          description: recipeStep['description'],
          order: recipeStep['order'],
        ),
      );
    });

    _ingredients = [];
    decodedBody['ingredients'].forEach((ingredient) {
      _ingredients.add(
        Ingredient(
          id: ingredient['id'],
          name: ingredient['name'],
          quantity: ingredient['quantity'],
          um: ingredient['um'],
        ),
      );
    });

    notifyListeners();
  }
}
