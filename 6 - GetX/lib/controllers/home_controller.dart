import 'dart:convert';

import 'package:get/get.dart';
import 'package:pattern_getx/controllers/edit_create_controller.dart';
import 'package:pattern_getx/models/post_model.dart';
import 'package:pattern_getx/pages/edit_create_page.dart';
import 'package:pattern_getx/services/http_service.dart';

class HomeController extends GetxController{
  var isLoading = false.obs;
  var posts = <Post>[].obs;

  final controller = Get.put(EditCreateController());

  @override
  void onInit() {
    fetchList();
    super.onInit();
  }

  void fetchList() {
    isLoading.value = true;

    Network.GET(Network.API_LIST, Network.paramsEmpty())
        .then((response) => parseResponse(response));
  }

  void deletePost(Post post) {
    Network.DELETE(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
  }

  void parseResponse(String? response) {
    if (response != null) {
      List json = jsonDecode(response);
      posts.value = List<Post>.from(json.map((x) => Post.fromJson(x)));
    }
    isLoading.value = false;
  }

  void openCreatePage() async {
    controller.post.value = Post();
    var result = await Get.to(() => EditCreatePage(controller: controller));

    if (result != null) {
      posts.add(result as Post);
      fetchList();
    }
  }

  void openEditPage(Post post) async {
    controller.post.value = post;
    var result = await Get.to(() => EditCreatePage(controller: controller));

    if (result != null) {
      posts
          .replaceRange(posts.indexOf(post), posts.indexOf(post) + 1, [result]);
      fetchList();
    }
  }
}