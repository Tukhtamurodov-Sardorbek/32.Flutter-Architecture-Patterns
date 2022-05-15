import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_getx/controllers/edit_create_controller.dart';

class EditCreatePage extends StatelessWidget {
  static const String id = '/edit_create_page';
  EditCreateController? controller;

  EditCreatePage({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<EditCreateController>(
      init: EditCreateController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 4.0,
            title: Text(controller!.post.value.title != null &&
                    controller!.post.value.body != null
                ? "Edit post"
                : "Create post"),
            centerTitle: true,
            actions: [
              TextButton(
                  onPressed: controller!.saveAndExit,
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 18),
                  ))
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: controller!.titleController.value
                          ..text =
                              controller!.post.value.title?.toUpperCase() ??
                                  controller!.titleController.value.text,
                        maxLines: null,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(bottom: 10, top: 10),
                            hintText: "Title"),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller!.bodyController.value
                          ..text = controller!.post.value.body ??
                              controller!.bodyController.value.text,
                        maxLines: null,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "Body",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ],
                  ),
                ),
              ),
              controller!.isLoading.value
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
