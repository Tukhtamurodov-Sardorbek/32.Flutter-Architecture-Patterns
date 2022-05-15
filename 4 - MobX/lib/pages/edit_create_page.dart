import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_pattern/models/post_model.dart';
import 'package:mobx_pattern/stores/edit_create_store.dart';

class EditCreatePage extends StatefulWidget {
  static const String id = "edit_create_page";
  Post? post;

  EditCreatePage({Key? key, this.post}) : super(key: key);

  @override
  _EditCreatePageState createState() => _EditCreatePageState();
}

class _EditCreatePageState extends State<EditCreatePage> {
  AddOrEditStore store = AddOrEditStore();

  @override
  void initState() {
    store.post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 4.0,
          title: Text(widget.post!.title != null && widget.post!.body != null
              ? "Edit post"
              : "Create post"),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  store.saveAndExit(context);
                },
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
                      controller: store.titleController
                        ..text = widget.post!.title?.toUpperCase() ??
                            store.titleController.text,
                      maxLines: null,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10, top: 10),
                          hintText: "Title"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: store.bodyController
                        ..text = widget.post!.body ?? store.bodyController.text,
                      maxLines: null,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: "Body",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ],
                ),
              ),
            ),
            store.isLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Container(),
          ],
        ),
      ),
    );
  }
}
