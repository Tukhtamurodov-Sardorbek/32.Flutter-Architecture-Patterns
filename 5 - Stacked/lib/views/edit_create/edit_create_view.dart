import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_pattern/models/post_model.dart';
import 'package:stacked_pattern/views/edit_create/edit_create_view_model.dart';

class EditCreateView extends StatefulWidget {
  static const String id = '/edit_create_page';
  Post? post;

  EditCreateView({Key? key, this.post}) : super(key: key);

  @override
  _EditCreateViewState createState() => _EditCreateViewState();
}

class _EditCreateViewState extends State<EditCreateView> {
  EditCreateViewModel viewModel = EditCreateViewModel();

  @override
  void initState() {
    viewModel.post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditCreateViewModel>.reactive(
      viewModelBuilder: () => EditCreateViewModel(),
      builder:
          (BuildContext context, EditCreateViewModel model, Widget? child) {
        return Scaffold(
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
                    viewModel.saveAndExit(context);
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
                        controller: viewModel.titleController
                          ..text = widget.post!.title?.toUpperCase() ??
                              viewModel.titleController.text,
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
                        controller: viewModel.bodyController
                          ..text =
                              widget.post!.body ?? viewModel.bodyController.text,
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
              viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
