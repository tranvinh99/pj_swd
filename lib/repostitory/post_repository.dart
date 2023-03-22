import 'dart:convert';
import 'dart:developer';

import 'package:f_home_mo/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostRepository {
  Future<List<PostModel>> getAllPosts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString("accessToken");
    List<PostModel> posts = [];
    try {
      const url = 'https://fhome-be.vercel.app/posts';
      final response = await http.get(Uri.parse("$url/"), headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
      List<PostModel> nlist = [];
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      final loadPost = parsed['data']['postings'] as List<dynamic>;
      log('loadpost length: $loadPost');
      for (var post in loadPost) {
        nlist.add(PostModel(
          id: post['_id'],
          title: post['title'],
          description: post['description'],
          status: post['status'],
          buildings: post['buildings']['_id'],
          rooms: post['rooms']['_id'],
          userPosting: post['userPosting']['_id'],
          createdAt: post['createdAt'],
          updatedAt: post['updatedAt'],
          img: post['img'],
        ));
        log('nlist length: ${nlist.length}');
      }
      // final postsJson = parsed['data']['postings'].cast<Map<String, dynamic>>();
      // posts =
      //     postsJson.map<PostModel>((json) => PostModel.fromMap(json)).toList();

      // log('listPost: $posts');
      posts = nlist;
    } catch (e) {
      print(e);
    }
    return posts;
  }

  Future<void> approvePost(String id) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final String? accessToken = pref.getString("accessToken");
      const url = 'https://fhome-be.vercel.app/posts';
      final response = await http.put(Uri.parse("$url/approve/$id"), headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> rejectPost(String id) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final String? accessToken = pref.getString("accessToken");
      const url = 'https://fhome-be.vercel.app/posts';
      final response = await http.put(Uri.parse("$url/reject/$id"), headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
    } catch (e) {
      print(e);
    }
  }
}
