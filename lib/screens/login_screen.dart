import "package:f_home_mo/app.dart";
import "package:f_home_mo/utils/firebase_service.dart";
import "package:flutter/material.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                const SizedBox(height: 170.0),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    top: 25.0,
                  ),
                  child: const Text(
                    "Welcome to FHome management",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                const SizedBox(height: 30.0),
                SizedBox(
                    height: 50.0,
                    child: InkWell(
                      onTap: () async {
                        await FirebaseServices().signInWithGoogle();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyApp()));
                      },
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0,
                                  3), // thay đổi độ lệch để tạo hiệu ứng đổ bóng
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10.0),
                            Text(
                              "Login with Google",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
