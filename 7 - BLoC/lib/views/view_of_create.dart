import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patterns_bloc/blocs/create_post_cubit.dart';
import 'package:patterns_bloc/model/post_model.dart';

Widget viewOfCreate(bool isLoading, BuildContext context, TextEditingController titleController, TextEditingController bodyController) {
  return Container(
    padding: const EdgeInsets.all(30),
    child: Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                hintText: 'Body',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FlatButton(
              onPressed: () {
                Post post = Post(
                    title: titleController.text.toString(),
                    body: bodyController.text.toString(),
                    userId: 1,
                );
                BlocProvider.of<CreatePostCubit>(context).apiPostCreate(post);
              },
              color: Colors.blue,
              child: const Text(
                "Create a Post",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const SizedBox.shrink(),
      ],
    ),
  );
}
