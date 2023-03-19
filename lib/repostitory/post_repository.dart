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
      final parsed = json.decode(response.body) as Map<String?, dynamic>;

      final loadPost = parsed['data']['postings'] as List<dynamic>;

      List<PostModel> lpost = [];
      for (var p in loadPost) {
        lpost.add(PostModel(
            id: p['_id'],
            title: p['title'],
            description: p['description'],
            status: p['status'],
            buildings: p['buildings'],
            rooms: p['rooms'],
            userPosting: p['userPosting']['email'] ?? 'unknown',
            createdAt: p['createdAt'] ?? 'unknown',
            updatedAt: p['updatedAt'] ?? 'unknown',
            img: p['img'] ?? 'unknown',
            invoiceId: p['invoiceId'] ?? 'unknown'));
      }
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
