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

  List<String> tabs = [
    "Admin",
    "Lanlord",
    "Fptmember",
  ];
  int current = 0;

  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 20;
      case 1:
        return 85;
      case 2:
        return 165;
      default:
        return 0;
    }
  }

  double changeContainerWidth() {
    return 10;
  }

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
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                width: size.width,
                height: size.height * 0.05,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        width: size.width,
                        height: size.height * 0.04,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: tabs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: index == 0 ? 10 : 23, top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      current = index;
                                    });
                                  },
                                  child: Text(
                                    tabs[index],
                                    style: TextStyle(
                                      fontSize: current == index ? 16 : 14,
                                      fontWeight: current == index
                                          ? FontWeight.w400
                                          : FontWeight.w300,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    AnimatedPositioned(
                      curve: Curves.fastLinearToSlowEaseIn,
                      bottom: 0,
                      left: changePositionedOfLine(),
                      duration: const Duration(milliseconds: 500),
                      child: AnimatedContainer(
                        margin: const EdgeInsets.only(left: 10),
                        width: changeContainerWidth(),
                        height: size.height * 0.008,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
                    )
                  ],
                ),
              ),
              _isLoading == true
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Status',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
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
              renderUserByRole(),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderUserByRole() {
    List<UserModel> tmp = [];

    switch (current) {
      case 0:
        tmp = [...users.where((user) => user.roleName == 'admin')];
        break;
      case 1:
        tmp = [...users.where((user) => user.roleName == 'landlord')];
        break;
      case 2:
        tmp = [...users.where((user) => user.roleName == 'fptmember')];
        break;
      default:
    }
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: tmp.length,
        itemBuilder: (context, i) {
          UserModel user = tmp[i];
          return ItemUser(
            userModel: user,
          );
        },
      ),
    );
  }
}
