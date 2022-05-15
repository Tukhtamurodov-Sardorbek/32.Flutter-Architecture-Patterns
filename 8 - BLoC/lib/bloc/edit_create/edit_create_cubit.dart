import 'package:bloc_pattern/models/post_model.dart';
import 'package:bloc_pattern/services/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_create_state.dart';

class EditCreatePostCubit extends Cubit<EditCreatePostState>{
  EditCreatePostCubit() : super(EditCreatePostInit());
  
  // void createPost(Post post) async{
  //   print(post.toJson());
  //   emit(EditCreatePostLoading());
  //   final response = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
  //   print('``` $response ```');
  //   if(response != null){
  //     emit(EditCreatePostLoaded(isDone: true));
  //   } else{
  //     emit(EditCreatePostError(error: 'Couldn\'t create the post'));
  //   }
  // }
  //
  // void updatePost(Post post) async{
  //   post.userId = 1;
  //   print(post.toJson());
  //   emit(EditCreatePostLoading());
  //   final response = await Network.PUT(Network.API_UPDATE + post.id.toString(), Network.paramsUpdate(post));
  //   print(response);
  //   if (response != null) {
  //     emit(EditCreatePostLoaded(isDone: true));
  //   } else {
  //     emit(EditCreatePostError(error: 'Couldn\'t update post'));
  //   }
  // }

  void saveAndExit(Post post, String title, String body) async {
    emit(EditCreatePostLoading());
    /// Edit
    if(post.title != null && post.body != null){
      Post postUpdate = Post(id: post.id, title: title, body: body, userId: post.userId);

      final response = await Network.PUT(
          Network.API_UPDATE + postUpdate.id.toString(), Network.paramsUpdate(postUpdate));

      if (response != null) {
        emit(EditCreatePostLoaded(isDone: true));
      } else {
        emit(EditCreatePostError(error: "Couldn't update post"));
      }

    }
    /// Create
    else {
      Post postCreate = Post(title: title, body: body, userId: title.hashCode);
      final response = await Network.POST(Network.API_CREATE, Network.paramsCreate(postCreate));

      if (response != null) {
        emit(EditCreatePostLoaded(isDone: true));
      } else {
        emit(EditCreatePostError(error: "Couldn't create post"));
      }
    }
  }
}