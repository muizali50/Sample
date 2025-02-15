import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mind_labify/main.dart';
import 'package:mind_labify/models/app_user.dart';

class UserProvider extends ChangeNotifier {
  AppUser? user;

  void setUser(AppUser user) {
    this.user = user;
    notifyListeners();
  }

  void getUser() async {
    String? userString = prefs.getString(
      'users',
    );
    if (userString != null) {
      user = AppUser.fromMap(
        json.decode(
          userString,
        ),
      );
    }
  }
}
