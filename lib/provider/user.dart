import 'dart:convert';
import 'dart:developer';

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

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      fullname: map['fullname'] as String,
      phone: map['phoneNumber'] as String,
      imgUrl: map['img'] as String,
      roleName: map['roleName'] as String,
      status: map['status'] as bool,
      email: map['email'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'img': imgUrl,
      'phoneNumber': phone,
      'email': email
    };
  }
}

class UserProvider with ChangeNotifier {
  List<UserModel> _list = [];

  List<UserModel> get list {
    return [..._list];
  }

  int get listSize {
    return _list.length;
  }

  Future<void> getAllUsers() async {
    _list = [];
    const url = 'https://fhome-be.vercel.app';
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString("accessToken");
    final response = await http.get(Uri.parse("$url/getAllUsers"));
    // debugPrint('getAlluser successful');
    final loadedUser = jsonDecode(response.body) as List<dynamic>;
    log('length:${loadedUser.length}');
    for (var user in loadedUser) {
      _list.add(UserModel(
        id: user['_id'],
        email: user['email'],
        phone: user['phoneNumber'],
        fullname: user['fullname'],
        imgUrl: user['img'],
        roleName: user['roleName'],
        status: user['status'],
      ));
    }
    // for (var user in _list) {
    //   print(user);
    // }
    notifyListeners();
  }
}
