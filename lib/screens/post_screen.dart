import 'package:f_home_mo/provider/post_provider.dart';
import 'package:f_home_mo/provider/user.dart';
import 'package:f_home_mo/repostitory/post_repository.dart';
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

  @override
  Widget build(BuildContext context) {
    final postData =
        Provider.of<PostProvider>(context, listen: false).getPosts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách bài đăng'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: postData.length,
              itemBuilder: (context, index) {
                return ItemPost(
                  postModel: postData[index],
                );
              },
              shrinkWrap: true,
            ),
    );
  }
}
