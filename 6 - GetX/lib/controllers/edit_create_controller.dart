import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_getx/models/post_model.dart';
import 'package:pattern_getx/services/http_service.dart';

class EditCreateController extends GetxController {
  var isLoading = false.obs;
  var titleController = TextEditingController().obs;
  var bodyController = TextEditingController().obs;
  var post = Post().obs;

  void saveAndExit() async {
    isLoading.value = true;

    String title = titleController.value.text.toString().trim();
    String body = bodyController.value.text.toString().trim();

    if (post.value.title != null && post.value.body != null) {
      Post postUpdate = Post(
          id: post.value.id,
          title: title,
          body: body,
          userId: post.value.userId);
      await Network.PUT(Network.API_UPDATE + postUpdate.id.toString(),
          Network.paramsUpdate(postUpdate));
      Get.back(result: postUpdate);
    } else {
      Post postCreate = Post(title: title, body: body, userId: title.hashCode);
      await Network.POST(Network.API_CREATE, Network.paramsCreate(postCreate));
      Get.back(result: postCreate);
    }
    isLoading.value = false;
  }
}
