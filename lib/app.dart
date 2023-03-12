import 'package:f_home_mo/provider/bottom_navigation_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:f_home_mo/screens/home_screen.dart';
import 'package:f_home_mo/screens/post_screen.dart';
import 'package:f_home_mo/screens/profile_screen.dart';
import 'package:f_home_mo/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> screens = const [
    HomeScreen(),
    PostScreen(),
    ProfileScreen()
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var bottomProvider = Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      extendBody: true,
      body: screens[bottomProvider.currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabWidget(
                iconData: FontAwesomeIcons.users,
                onPressed: () {
                  bottomProvider.currentIndex = 0;
                },
                name: 'Users',
                color: bottomProvider.currentIndex == 0
                    ? const Color(0xFF000000)
                    : const Color(0xFF000000).withOpacity(0.1),
              ),
              TabWidget(
                onPressed: () {
                  bottomProvider.currentIndex = 1;
                },
                iconData: FontAwesomeIcons.list,
                name: 'Posts',
                color: bottomProvider.currentIndex == 1
                    ? const Color(0xFF000000)
                    : const Color(0xFF000000).withOpacity(0.1),
              ),
              TabWidget(
                onPressed: () {
                  bottomProvider.currentIndex = 2;
                },
                iconData: FontAwesomeIcons.user,
                name: 'Profile',
                color: bottomProvider.currentIndex == 2
                    ? const Color(0xFF000000)
                    : const Color(0xFF000000).withOpacity(0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
