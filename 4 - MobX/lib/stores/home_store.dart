import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:mobx_pattern/models/post_model.dart';
import 'package:mobx_pattern/pages/edit_create_page.dart';
import 'package:mobx_pattern/services/http_service.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable bool isLoading = false;
  @observable List<Post> posts = [];

  void fetchList() {
    isLoading = true;

    Network.GET(Network.API_LIST, Network.paramsEmpty())
        .then((response) => parseResponse(response));
  }

  void deletePost(Post post) {
    Network.DELETE(
            Network.API_DELETE + post.id.toString(), Network.paramsEmpty())
        .then((response) => parseResponse(response));
  }

  void parseResponse(String? response) {
    if (response != null) {
      List json = jsonDecode(response);
      posts = List<Post>.from(json.map((x) => Post.fromJson(x)));
    }
    isLoading = false;
  }

  void openCreatePage(BuildContext context) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditCreatePage(post: Post())));
    if (result != null) {
      posts.add(result as Post);
      fetchList();
    }
  }

  void openEditPage(BuildContext context, Post post) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditCreatePage(post: post)
        )
    );
    if (result != null) {
      posts
          .replaceRange(posts.indexOf(post), posts.indexOf(post) + 1, [result]);
      fetchList();
    }
  }
}
