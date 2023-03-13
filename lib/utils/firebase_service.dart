import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  var _deviceToken = '';

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
        FirebaseAuth fAuth = FirebaseAuth.instance;
        final User? firebaseUser =
            (await fAuth.signInWithCredential(authCredential).catchError((msg) {
          throw msg;
        }))
                .user;
        if (firebaseUser != null) {
          String token = await firebaseUser.getIdToken();
          // debugPrint('Get token from firebase: $token');
          // await sendTokenApi(token);
          String accessToken = await sendTokenApi(token);
          AccessTokenMiddleware.setAccessToken(accessToken);
        }
      }
    } on FirebaseAuthException {
      // print(e.message);
      rethrow;
    }
  }

  Future<String> sendTokenApi(String token) async {
    const url = 'https://f-homes-be.vercel.app/login';
    final headers = {
      'Content-Type': 'application/json',
    };
    await getDeviceToken();
    final body =
        json.encode({'accessToken': token, 'deviceToken': _deviceToken});
    final response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (response.statusCode >= 400) {
      await signOut();
    }
    debugPrint('responseData in login : $responseData');
    // final userData = responseData['data']['user'];
    final accessToken = responseData['data']['accessToken'];
    final uId = responseData['data']['user']['id'];

    debugPrint('uId $uId');

    await prefs.setString('accessToken', accessToken);
    await prefs.setString('idUser', uId);
    return accessToken;
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('deviceToken');
    await prefs.remove('idUser');
    _deviceToken = '';
  }

  Future<void> getDeviceToken() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    await firebaseMessaging.getToken().then((token) {
      _deviceToken = token!;
    });
    // print('Device token : $_deviceToken');
  }
}

class AccessTokenMiddleware {
  static String? _accessToken;
  // static String? _studentId;

  static void setAccessToken(String accessToken) {
    _accessToken = accessToken;
  }

  static String getAccessToken() {
    return _accessToken!;
  }
}
