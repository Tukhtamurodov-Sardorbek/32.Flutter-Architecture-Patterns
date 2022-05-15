import 'package:contacts_mock_api_bloc/bloc/edit_creat_bloc/edit_create_cubit.dart';
import 'package:contacts_mock_api_bloc/models/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget EditCreateView(Contact contact, bool isLoading, BuildContext context) {
  TextEditingController titleController =
      TextEditingController(text: contact.name);
  TextEditingController bodyController =
      TextEditingController(text: contact.number);
  return Stack(
    children: [
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController
                  ..text = contact.name?.toUpperCase() ?? titleController.text,
                maxLines: null,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 10, top: 10),
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: bodyController
                  ..text = contact.number ?? bodyController.text,
                maxLines: 1,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Phone',
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
              const SizedBox(height: 40),
              MaterialButton(
                height: 45,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                color: CupertinoColors.systemBlue,
                child: Text(
                  contact.name != null && contact.number != null
                      ? 'Save'
                      : 'Create',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 20),
                ),
                onPressed: () {
                  debugPrint('Title: ${titleController.text}');
                  debugPrint('Body: ${bodyController.text}');
                  BlocProvider.of<EditCreateContactCubit>(context).saveAndExit(
                      contact,
                      titleController.text.toString().trim(),
                      bodyController.text.toString().trim());
                },
              )
            ],
          ),
        ),
      ),
      isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Container(),
    ],
  );
}
