import 'package:f_home_mo/app.dart';
import 'package:f_home_mo/firebase_options.dart';
import 'package:f_home_mo/provider/bottom_navigation_provider.dart';
import 'package:f_home_mo/provider/post_provider.dart';
import 'package:f_home_mo/provider/user.dart';
import 'package:f_home_mo/screens/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? accessToken = pref.getString("accessToken");
  // print(accessToken);
  // await FirebaseMessaging.instance.getInitialMessage();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserProvider()),
      ChangeNotifierProvider.value(value: PostProvider()),
      ChangeNotifierProvider.value(value: BottomNavigationProvider())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: accessToken == null ? const LoginScreen() : const MyApp(),
    ),
  ));
}
