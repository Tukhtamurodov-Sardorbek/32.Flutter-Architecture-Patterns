import 'package:flutter/material.dart';
import 'package:patternprovider/models/post_model.dart';
import 'package:patternprovider/services/http_service.dart';

class AddOrEditController extends ChangeNotifier{
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  Post? post;


  void saveAndExit(BuildContext context) async {
    isLoading = true;
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    notifyListeners();

    if(post != null && post!.title !=null && post!.body !=null){
      Post postUpdate = Post(
          id: post!.id,
          title: title,
          body: body,
          userId: post!.userId
      );
      await Network.PUT(
          Network.API_UPDATE + postUpdate.id.toString(), Network.paramsUpdate(postUpdate));
      Navigator.pop((context), postUpdate);
    } else {
      Post postCreate = Post(title: title, body: body, userId: title.hashCode);
      await Network.POST(Network.API_CREATE, Network.paramsCreate(postCreate));
      Navigator.pop((context), postCreate);
    }
    isLoading = false;
    notifyListeners();
  }
}