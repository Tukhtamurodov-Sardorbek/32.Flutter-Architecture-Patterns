import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patternprovider/view_models/home_view_model.dart';
import 'package:patternprovider/models/post_model.dart';

Widget postWidget(BuildContext context, HomeController controller, Post post) {
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