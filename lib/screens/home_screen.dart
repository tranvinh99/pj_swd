import "package:f_home_mo/provider/user.dart";
import "package:f_home_mo/widgets/item_user.dart";
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
  List<UserModel> users = [];

  filterStatus(int value) {
    List<UserModel> tmp = context.read<UserProvider>().list;
    List<UserModel> filtered = [];
    switch (value) {
      case 0:
        filtered = tmp.where((user) => !user.status).toList();
        print(filtered);
        break;
      case 1:
        filtered = tmp.where((user) => user.status).toList();
        print(filtered);
        break;
      default:
        filtered = tmp;
    }

    users = [];
    users.addAll(filtered);
    setState(() {});
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      await Provider.of<UserProvider>(context, listen: false).getAllUsers();
      users = Provider.of<UserProvider>(context, listen: false).list;

      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  int _groupValue = 2; // false

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách người dùng'),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 2,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            filterStatus(value!);

                            setState(() {
                              _groupValue = value;
                            });
                          },
                        ),
                        const Text(
                          'All',
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            Radio(
                              value: 0,
                              groupValue: _groupValue,
                              onChanged: (value) {
                                filterStatus(value!);
                                setState(() {
                                  _groupValue = value;
                                });
                              },
                            ),
                            const Text(
                              'False',
                            )
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _groupValue,
                              onChanged: (value) {
                                filterStatus(value!);

                                setState(() {
                                  _groupValue = value;
                                });
                              },
                            ),
                            const Text(
                              'True',
                            )
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: users.length,
                        itemBuilder: (context, i) {
                          UserModel user = users[i];
                          return ItemUser(
                            userModel: user,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
