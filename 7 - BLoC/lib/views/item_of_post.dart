
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patterns_bloc/blocs/list_post_cubit.dart';
import 'package:patterns_bloc/model/post_model.dart';

Widget itemOfPost(BuildContext context,Post post) {
  return Slidable(
    /// Edit
    startActionPane: ActionPane(
      dragDismissible: true,
      extentRatio: 0.3,
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          backgroundColor: Colors.indigo,
          icon: Icons.edit,
          onPressed: (_) {
            BlocProvider.of<ListPostCubit>(context).callUpdatePage(context,post);
          },
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
          backgroundColor: Colors.red,
          icon: Icons.delete,
          onPressed: (_) {
            BlocProvider.of<ListPostCubit>(context).apiPostDelete(post);
          },
        ),
      ],
    ),

    child: Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title.toUpperCase(),
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(post.body),
        ],
      ),
    ),
  );
}