import 'package:bloc_pattern/bloc/edit_create/edit_create_cubit.dart';
import 'package:bloc_pattern/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget EditCreateView(Post post, bool isLoading, BuildContext context){
  TextEditingController titleController = TextEditingController(text: post.title);
  TextEditingController bodyController = TextEditingController(text: post.body);
  return Stack(
    children: [
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController..text = post.title?.toUpperCase() ?? titleController.text,
                maxLines: null,
                style:
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10, top: 10),
                    hintText: 'Title',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller:  bodyController..text = post.body ?? bodyController.text,
                maxLines: null,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Body',
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
              const SizedBox(height: 40),
              MaterialButton(
                height: 45,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)
                ),
                color: CupertinoColors.systemBlue,
                child: Text(
                    post.title != null && post.body != null
                        ? 'Save'
                        : 'Create',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 20),
                ),
                onPressed: (){
                  print('Title: ${titleController.text}');
                  print('Body: ${bodyController.text}');
                  BlocProvider.of<EditCreatePostCubit>(context).saveAndExit(post, titleController.text.toString().trim(), bodyController.text.toString().trim());
                },
              )
            ],
          ),
        ),
      ),
      isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Container(),
    ],
  );
}