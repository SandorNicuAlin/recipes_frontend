import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/group.dart';
import '../classes/user.dart';
import '../helpers/http_request.dart';
import '../classes/recipe.dart';
import '../classes/recipe_step.dart';

class GroupProvider with ChangeNotifier {
  // ignore: non_constant_identifier_names
  List<Group> _groups_by_user = [];

  // ignore: non_constant_identifier_names
  List<Group> get groups_by_user {
    return _groups_by_user;
  }

  List<Recipe> _recipes = [];

  List<Recipe> get recipes {
    return _recipes;
  }

  Group? groupByName(String name) {
    for (var group in _groups_by_user) {
      if (group.name == name) {
        return group;
      }
    }
    return null;
  }

  Future<void> fetchAllForUser() async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/user/groups');
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

    _groups_by_user = [];
    decodedBody['groups'].forEach((group) {
      _groups_by_user.add(
        Group(
          id: group['id'],
          name: group['name'],
          members: group['members']
              .map<User>(
                (user) => User(
                  id: user['id'],
                  username: user['username'],
                  email: user['email'],
                  phone: user['phone'],
                  isAdministrator: user['is_administrator'] == 1 ? true : false,
                ),
              )
              .toList(),
          isAdministrator: group['is_administrator'] == 1 ? true : false,
        ),
      );
    });

    notifyListeners();
  }

  Future<Map> createGroup(String name) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/create-group');
    var response = await http.post(
      url,
      body: jsonEncode({
        'name': name,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      await fetchAllForUser();
    }

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }

  Future<Map> giveAdminPrivilages(int userId, int groupId) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/groups/make-administrator');
    var response = await http.post(
      url,
      body: jsonEncode({
        'user_id': userId,
        'group_id': groupId,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    await fetchAllForUser();

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }

  Future<Map> groupInvite(int groupId, List newMembers) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url =
        Uri.parse('${HttpRequest.baseUrl}/api/groups/add-members-notification');
    var response = await http.post(
      url,
      body: jsonEncode({
        'group_id': groupId,
        'new_members': newMembers,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }

  Future<Map> addRecipe(
    int groupId,
    String name,
    String description,
    List<Map<String, dynamic>> steps,
  ) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/recipes/add');
    var response = await http.post(
      url,
      body: jsonEncode({
        'group_id': groupId,
        'name': name,
        'description': description,
        'recipe_steps': steps,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }

  Future<Map> fetchRecipesForGroup(int groupId) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('API_ACCESS_KEY');
    var url = Uri.parse('${HttpRequest.baseUrl}/api/recipes');
    var response = await http.post(
      url,
      body: jsonEncode({
        'groups': [groupId]
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    // print('statusCode: ${response.statusCode}');
    // print('body: ${response.body}');

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;

    _recipes = decodedBody['recipes']
        .map<Recipe>(
          (recipe) => Recipe(
            id: recipe['id'],
            name: recipe['name'],
            description: recipe['description'],
          ),
        )
        .toList();

    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }
}
