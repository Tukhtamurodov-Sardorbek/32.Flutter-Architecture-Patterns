import 'package:bloc_pattern/bloc/edit_create/edit_create_cubit.dart';
import 'package:bloc_pattern/bloc/home_bloc/home_cubit.dart';
import 'package:bloc_pattern/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class postWidget extends StatelessWidget {
  final Post post;
  const postWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                BlocProvider.of<PostListCubit>(context).openEditCreatePage(context, post);
                // openEditPage(post);
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
                BlocProvider.of<PostListCubit>(context).deletePost(post);
                // posts.remove(post);
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
}
