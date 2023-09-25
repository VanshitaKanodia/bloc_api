/*Code which actually calls the API*/

import 'dart:convert';
import 'dart:developer';

import 'package:bloc_api/features/posts/models/post_data_ui_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo{

  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client.get(
        // https://jsonplaceholder.typicode.com/posts
          Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post = PostDataUiModel.fromJson(
            result[i] as Map<String, dynamic>);
        posts.add(post);
      }

      // print(posts);
      return posts;
    }
    catch (e) {
      log(e.toString());
      return [];
    }
  }

}