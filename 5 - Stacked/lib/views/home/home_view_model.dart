import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_pattern/models/post_model.dart';
import 'package:stacked_pattern/services/http_service.dart';
import 'package:stacked_pattern/views/edit_create/edit_create_view.dart';

class HomeViewModel extends BaseViewModel{
  bool isLoading = false;
  // bool get isLoading => _isLoading;

  var posts = <Post>[];
  // List<Post> get posts => _posts;

  Future fetchList() async {
    isLoading = true;
    notifyListeners();

    Network.GET(Network.API_LIST, Network.paramsEmpty())
        .then((response) => parseResponse(response));
  }

  Future deletePost(Post post) async {
    posts.remove(post);
    notifyListeners();

    Network.DELETE(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty())
        .then((response) => parseResponse(response));
  }

  void parseResponse(String? response) {
    if (response != null) {
      List json = jsonDecode(response);
      posts = List<Post>.from(json.map((x) => Post.fromJson(x)));
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }

  void openCreatePage(BuildContext context) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditCreateView(post: Post())));

    if (result != null) {
      posts.add(result as Post);
      fetchList();
    }
  }

  void openEditPage(BuildContext context, Post post) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditCreateView(post: post)
        )
    );

    if (result != null) {
      posts
          .replaceRange(posts.indexOf(post), posts.indexOf(post) + 1, [result]);
      fetchList();
    }
  }
}