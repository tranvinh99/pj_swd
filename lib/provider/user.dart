import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

class UserModel {
  final String id, email, phone, fullname, imgUrl, roleName;
  final bool status;

  UserModel(
      {required this.id,
      required this.email,
      required this.phone,
      required this.fullname,
      required this.imgUrl,
      required this.roleName,
      required this.status});
}

class UserProvider with ChangeNotifier {
  final List<UserModel> _list = [];

  List<UserModel> get list {
    return [..._list];
  }

  int get listSize {
    return _list.length;
  }

  Future<void> getAllUsers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString('accessToken');
    const url = 'https://f-homes-be.vercel.app';

    final response = await http.get(Uri.parse("$url/getAllUsers"), headers: {
      'Content-type': 'application/json',
      'Authorization': 'bearer $accessToken'
    });
    debugPrint('getAlluser successful');
    final loadedUser = jsonDecode(response.body) as List<dynamic>;

    for (var user in loadedUser) {
      _list.add(UserModel(
          id: user['_id'],
          email: user['email'],
          phone: user['phoneNumber'],
          fullname: user['fullname'],
          imgUrl: user['img'],
          roleName: user['roleName'],
          status: user['status']));
    }
    notifyListeners();
  }

  Future<void> approveUser(String id) async {
    final url = Uri.parse('https://fhome-be.vercel.app/setUserStatus/$id');
    await http.put(url);
  }

  Future<void> deleteUser(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString('accessToken');
    final url = Uri.parse('https://fhome-be.vercel.app/users/$id');
    await http.delete(url, headers: {
      'Content-type': 'application/json',
      'Authorization': 'bearer $accessToken'
    }).then((res) {
      debugPrint(res.body);
    });
  }
}
