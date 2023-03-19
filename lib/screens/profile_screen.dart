import 'package:f_home_mo/provider/user.dart';
import 'package:f_home_mo/repostitory/user_repository.dart';
import 'package:f_home_mo/screens/edit_profile_screen.dart';
import 'package:f_home_mo/screens/login_screen.dart';
import 'package:f_home_mo/utils/firebase_service.dart';
import 'package:f_home_mo/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    List<UserModel> users = context.read<UserProvider>().list;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uId = prefs.getString('idUser');
    uId = idAdmin;
    // print('uId $uId');
    setState(() {
      _isLoading = false;
    });
    // userModel = await UserRepository().getUserInfo(uId!);
    for (var user in users) {
      if (user.id == idAdmin) {
        userModel = user;
        setState(() {
          _isLoading = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: _isLoading == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(userModel.imgUrl),
                ),
                const SizedBox(height: 20),
                Text(
                  userModel.fullname,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  userModel.email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.3),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EditProfileScreen(
                            userModel: userModel,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    top: 20,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await FirebaseServices().signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => const LoginScreen()));
                    },
                    child: const Text(
                      'Đăng xuất',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
