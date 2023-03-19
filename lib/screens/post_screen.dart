import 'package:f_home_mo/models/post.dart';
import 'package:f_home_mo/provider/post_provider.dart';
import 'package:f_home_mo/widgets/item_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  List<String> tabs = [
    "All",
    "Pending",
    "Approved",
    "Rejected",
    "Published",
  ];
  int current = 0;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      await Provider.of<PostProvider>(context, listen: false).getAllPosts();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 5;
      case 1:
        return 65;
      case 2:
        return 140;
      case 3:
        return 220;
      case 4:
        return 300;
      default:
        return 0;
    }
  }

  double changeContainerWidth() {
    return 10;
  }

  int _groupValue = 2; // false

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách bài đăng'),
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
                  : renderPostByStatus(),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderPostByStatus() {
    final postData =
        Provider.of<PostProvider>(context, listen: false).getPosts();
    postData.sort((a, b) {
      DateTime first = DateTime.parse(a.createdAt!);
      DateTime second = DateTime.parse(b.createdAt!);

      return second.compareTo(first);
    });
    List<PostModel> tmp = [];

    switch (current) {
      case 0:
        tmp = [...postData.where((post) => post.status != 'draft')];
        break;
      case 1:
        tmp = [...postData.where((post) => post.status == 'pending')];
        break;
      case 2:
        tmp = [...postData.where((post) => post.status == 'approved')];
        break;
      case 3:
        tmp = [...postData.where((post) => post.status == 'rejected')];
        break;
      case 4:
        tmp = [...postData.where((post) => post.status == 'published')];
        break;
      default:
    }
    return Expanded(
      child: ListView.builder(
        itemCount: tmp.length,
        itemBuilder: (context, index) {
          return ItemPost(
            postModel: tmp[index],
          );
        },
        shrinkWrap: true,
      ),
    );
  }
}
