import 'package:bloc/bloc.dart';
import 'package:bloc_pattern/bloc/home_bloc/home_state.dart';
import 'package:bloc_pattern/models/post_model.dart';
import 'package:bloc_pattern/pages/edit_create_page.dart';
import 'package:bloc_pattern/services/hive_service.dart';
import 'package:bloc_pattern/services/http_service.dart';
import 'package:flutter/material.dart';

class PostListCubit extends Cubit<PostListState>{
  PostListCubit() : super(PostListInit());
  
  void fetchPosts() async{
    emit(PostListLoading());
    final response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    
    if(response != null){
      List<Post> _posts = await List<Post>.from(Network.parsePostList(response));
      HiveService.storeData(_posts);
      emit(PostListLoaded(posts: _posts));
    } else {
      emit(PostListError(error: 'Something went wrong'));
    }
  }

  void deletePost(Post post) async{
    final response = await Network.DELETE(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());

    if(response != null){
      // await HiveService.removeData(post.id!);
      // List<Post> _posts = await HiveService.loadData();
      // emit(PostListLoaded(posts: _posts));
      fetchPosts();
    } else {
      emit(PostListError(error: 'Something went wrong'));
    }
  }

  void openEditCreatePage(BuildContext context, Post post) async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditCreatePage(post: post)));
    if (result != null) {
      fetchPosts();
      // Add new post to hive
      // posts.add(result as Post);
    }
  }
}