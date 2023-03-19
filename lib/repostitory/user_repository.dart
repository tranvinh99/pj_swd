import 'dart:convert';

import 'package:f_home_mo/provider/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<UserModel> getUserInfo(String id) async {
    var jsonResponse;
    try {
      const url = 'https://fhome-be.vercel.app';
      SharedPreferences pref = await SharedPreferences.getInstance();
      final String? accessToken = pref.getString("accessToken");
      final response = await http.get(Uri.parse("$url/users/$id"), headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
      // print(response.body);
      jsonResponse = json.decode(response.body);
    } catch (e) {
      print(e.toString());
    }

    return UserModel.fromMap(jsonResponse);
  }

  Future<void> updateUser(UserModel userModel) async {
    var jsonResponse;
    // print(userModel.status.runtimeType);
    try {
      const url = 'https://f-homes-be.vercel.app';
      SharedPreferences pref = await SharedPreferences.getInstance();
      final String? accessToken = pref.getString("accessToken");
      await http.put(
        Uri.parse("$url/users/${userModel.id}"),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: userModel.toMap(),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateStatus(UserModel userModel) async {
    var jsonResponse;
    try {
      const url = 'https://f-homes-be.vercel.app';
      SharedPreferences pref = await SharedPreferences.getInstance();
      final String? accessToken = pref.getString("accessToken");
      await http.put(
        Uri.parse("$url/setUserStatus/${userModel.id}"),
        headers: {'Authorization': 'Bearer $accessToken'},
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
