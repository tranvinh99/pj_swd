import 'dart:convert';
import 'dart:developer';

import 'package:f_home_mo/models/post.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<PostModel>> getAllPosts() async {
    List<PostModel> posts = [];
    try {
      const url = 'https://fhome-be.vercel.app';
      final response = await http.get(Uri.parse("$url/getAllStatus"));
      final parsed = json.decode(response.body);
      final postsJson = parsed['data']['postings'].cast<Map<String, dynamic>>();
      posts =
          postsJson.map<PostModel>((json) => PostModel.fromMap(json)).toList();

      log('post length:${posts.length}');
    } catch (e) {
      print(e);
    }
    return posts;
  }

  Future<void> approvePost(String id) async {
    try {
      const url = 'https://fhome-be.vercel.app';
      final response = await http.put(Uri.parse("$url/approve-post/$id"));
    } catch (e) {
      print(e);
    }
  }

  Future<void> rejectPost(String id) async {
    try {
      const url = 'https://fhome-be.vercel.app';
      final response = await http.delete(Uri.parse("$url/deletePosting/$id"));
    } catch (e) {
      print(e);
    }
  }
}
