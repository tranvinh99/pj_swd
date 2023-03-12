import 'dart:convert';

import 'package:f_home_mo/provider/user.dart';
import 'package:f_home_mo/utils/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BuildingRepository {
  Future<UserModel> getBuildingInfo(String id) async {
    var jsonResponse;
    try {
      const url = 'https://f-homes-be.vercel.app';
      SharedPreferences pref = await SharedPreferences.getInstance();
      const String accessToken = token;
      final response = await http.get(Uri.parse("$url/users/$id"), headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
      print(response.body);
      jsonResponse = json.decode(response.body);
    } catch (e) {
      print(e.toString());
    }

    return UserModel.fromMap(jsonResponse);
  }
}
