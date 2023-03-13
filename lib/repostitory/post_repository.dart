import 'dart:convert';

import 'package:f_home_mo/models/post.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<PostModel>> getAllPosts() async {
    List<PostModel> posts = [];
    try {
      const url = 'https://f-homes-be.vercel.app';
      final response = await http.get(Uri.parse("$url/getAllPostings"));
      final parsed = json.decode(response.body);
      final postsJson = parsed['data']['postings'].cast<Map<String, dynamic>>();
      posts =
          postsJson.map<PostModel>((json) => PostModel.fromMap(json)).toList();
    } catch (e) {
      print(e);
    }
    return posts;
  }
}
