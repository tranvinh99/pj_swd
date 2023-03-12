import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotiProvider with ChangeNotifier {
  Future<void> sendNotification(String message, String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("deviceToken");
  }
}
