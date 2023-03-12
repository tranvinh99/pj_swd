import "package:f_home_mo/provider/user.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      await Provider.of<UserProvider>(context, listen: false).getAllUsers();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: userData.listSize,
              itemBuilder: (context, i) {
                return Container(
                  height: 100,
                  color: Colors.amber,
                  child: Column(
                    children: [
                      Text(userData.list[i].fullname),
                      Text(userData.list[i].status.toString()),
                      OutlinedButton(
                          onPressed: () async {},
                          child: const Text('Change Status'))
                    ],
                  ),
                );
              }),
    );
  }
}
