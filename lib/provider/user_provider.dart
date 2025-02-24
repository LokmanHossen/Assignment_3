import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../database/database_helper.dart';
import '../database/model.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse('https://randomuser.me/api/?results=30'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<User> loadedUsers = [];
        for (var user in data['results']) {
          loadedUsers.add(User.fromJson(user));
        }
        _users = loadedUsers;

        // Cache data locally
        final dbHelper = DatabaseHelper();
        for (var user in _users) {
          await dbHelper.insertUser(user);
        }
      }
    } catch (error) {
      // Load cached data if offline
      final dbHelper = DatabaseHelper();
      _users = await dbHelper.getUsers();
    }

    _isLoading = false;
    notifyListeners();
  }
}
