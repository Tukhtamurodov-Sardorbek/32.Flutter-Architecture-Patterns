import 'package:bloc_pattern/bloc/edit_create/edit_create_cubit.dart';
import 'package:bloc_pattern/bloc/edit_create/edit_create_state.dart';
import 'package:bloc_pattern/models/post_model.dart';
import 'package:bloc_pattern/services/http_service.dart';
import 'package:bloc_pattern/views/edit_create/edit_create_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCreatePage extends StatefulWidget {
  static const String id = "edit_create_page";
  final Post post;

  const EditCreatePage({Key? key, required this.post}) : super(key: key);

  @override
  _EditCreatePageState createState() => _EditCreatePageState();
}

class _EditCreatePageState extends State<EditCreatePage> {

  void finish(BuildContext context){
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.pop(context, 'result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EditCreatePostCubit(),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 4.0,
          title: Text(widget.post.title!=null && widget.post.body!=null ? 'Edit post' : 'Create post'),
          centerTitle: true,
        ),
        body: BlocBuilder<EditCreatePostCubit, EditCreatePostState>(
          builder: (BuildContext context, EditCreatePostState state){
            if(state is EditCreatePostLoading){
              return EditCreateView(widget.post, true, context);
            } else if(state is EditCreatePostLoaded){
              finish(context);
            } else if(state is EditCreatePostError){}
            return EditCreateView(widget.post, false, context);
          },
        )
      ),
    );
  }
}