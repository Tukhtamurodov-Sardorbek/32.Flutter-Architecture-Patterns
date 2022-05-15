import 'package:bloc_pattern/models/post_model.dart';
import 'package:bloc_pattern/views/home/post_list_view.dart';
import 'package:flutter/material.dart';
Widget HomeView(List<Post> posts, bool isLoading){
  return Stack(
    children: [
      ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return postWidget(post: posts[index]);
        },
      ),
      isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Container(),
    ],
  );
}