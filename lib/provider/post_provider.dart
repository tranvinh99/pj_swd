import 'package:f_home_mo/models/post.dart';
import 'package:f_home_mo/repostitory/post_repository.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  List<PostModel> _posts = [];

  Future<void> getAllPosts() async {
    List<PostModel> posts = await PostRepository().getAllPosts();
    _posts = posts;
    notifyListeners();
  }

  List<PostModel> getPosts() => _posts;
}
