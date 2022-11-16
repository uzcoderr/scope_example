import 'package:flutter/material.dart';
import 'package:scope_ex/model/Post.dart';
import 'package:scope_ex/screens/edit_post_screen.dart';
import 'package:scope_ex/service/ApiService.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeViewModel extends Model {
  List<Post> posts = [];

  void apiGetUsers() {
    ApiService.GET(ApiService.GET_API, ApiService.paramsEmpty())
        .then((value) => {
          posts = value!,
          notifyListeners()
        });
  }

  Future<bool?> apiDeleteUsers(String api) {
    return ApiService.DELETE(api, ApiService.paramsEmpty());
  }

  void nextPage(BuildContext context, Post post, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PostUpdateScreen(post: post, index: index)),
    );

    posts[index] = result;
    notifyListeners();
  }
  Future<bool?> removePost(index) {
    var response = apiDeleteUsers("${ApiService.GET_API}/$index");
    posts.removeAt(index);
    notifyListeners();
    return response;
  }
}
