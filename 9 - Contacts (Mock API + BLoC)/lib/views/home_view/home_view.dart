import 'package:contacts_mock_api_bloc/models/contact_model.dart';
import 'package:contacts_mock_api_bloc/views/home_view/contact_list_view.dart';
import 'package:flutter/material.dart';
Widget HomeView(List<Contact> contacts, bool isLoading){
  return Stack(
    children: [
      ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return postWidget(contact: contacts[index]);
        },
      ),
      isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Container(),
    ],
  );
}