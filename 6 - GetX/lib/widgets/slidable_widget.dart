
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pattern_getx/controllers/home_controller.dart';
import 'package:pattern_getx/models/post_model.dart';

Widget postWidget(HomeController controller, Post post) {
  return Card(
    child: Slidable(
      /// Edit
      startActionPane: ActionPane(
        dragDismissible: true,
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: CupertinoColors.activeBlue,
            onPressed: (_) {
              controller.openEditPage(post);
            },
            icon: Icons.edit,
          ),
        ],
      ),

      /// Delete
      endActionPane: ActionPane(
        dragDismissible: true,
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: CupertinoColors.systemRed,
            onPressed: (_) {
              controller.posts.remove(post);
              controller.deletePost(post);
            },
            icon: Icons.delete,
          ),
        ],
      ),

      /// Body
      child: ListTile(
        title: Text(post.title!.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(post.body!),
      ),
    ),
  );
}