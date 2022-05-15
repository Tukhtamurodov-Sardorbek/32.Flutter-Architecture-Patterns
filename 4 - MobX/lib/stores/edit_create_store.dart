import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_pattern/models/post_model.dart';
import 'package:mobx_pattern/services/http_service.dart';

part 'edit_create_store.g.dart';

class AddOrEditStore = _AddOrEditStore with _$AddOrEditStore;

abstract class _AddOrEditStore with Store {
  @observable
  Post? post;
  @observable
  bool isLoading = false;
  @observable
  TextEditingController titleController = TextEditingController();
  @observable
  TextEditingController bodyController = TextEditingController();

  void saveAndExit(BuildContext context) async {
    isLoading = true;
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();

    if (post!.title != null && post!.body != null) {
      Post postUpdate =
          Post(id: post!.id, title: title, body: body, userId: post!.userId);
      await Network.PUT(Network.API_UPDATE + postUpdate.id.toString(),
          Network.paramsUpdate(postUpdate));
      Navigator.pop((context), postUpdate);
    } else {
      Post postCreate = Post(title: title, body: body, userId: title.hashCode);
      await Network.POST(Network.API_CREATE, Network.paramsCreate(postCreate));
      Navigator.pop((context), postCreate);
    }
    isLoading = false;
  }
}
