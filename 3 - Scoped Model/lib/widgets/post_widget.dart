import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model_pattern/models/post_model.dart';
import 'package:scoped_model_pattern/scopes/home_scoped.dart';

Widget postWidget(BuildContext context, HomeScoped controller, Post post) {
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
              controller.openEditPage(context, post);
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