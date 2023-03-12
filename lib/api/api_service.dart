// import "package:shared_preferences/shared_preferences.dart";
// import "package:http/http.dart" as http;

// class ApiService {
//   final url = 'https://f-homes-be.vercel.app';

//   Future<void> getAllUsers() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     final String? accessToken = pref.getString('accessToken');
//     final response = await http.get(Uri.parse("$url/getAllUsers"), headers: {
//       'Content-type': 'application/json',
//       'Authorization': 'bearer $accessToken'
//     });
//   }
// }
