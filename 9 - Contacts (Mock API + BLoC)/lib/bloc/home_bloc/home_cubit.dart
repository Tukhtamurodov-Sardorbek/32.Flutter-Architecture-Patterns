import 'package:bloc/bloc.dart';
import 'package:contacts_mock_api_bloc/bloc/home_bloc/home_state.dart';
import 'package:contacts_mock_api_bloc/models/contact_model.dart';
import 'package:contacts_mock_api_bloc/pages/edit_create_page.dart';
import 'package:contacts_mock_api_bloc/services/hive_service.dart';
import 'package:contacts_mock_api_bloc/services/http_service.dart';
import 'package:flutter/material.dart';

class ContactListCubit extends Cubit<ContactListState>{
  ContactListCubit() : super(ContactListInit());
  
  void fetchContacts() async{
    emit(ContactListLoading());
    final response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    
    if(response != null){
      List<Contact> _contacts = await List<Contact>.from(Network.parsePostList(response));
      await HiveService.storeData(_contacts);
      emit(ContactListLoaded(contacts: _contacts));
    } else {
      emit(ContactListError(error: 'Something went wrong'));
    }
  }

  void deleteContact(Contact contact) async{
    final response = await Network.DELETE(Network.API_DELETE + contact.id.toString(), Network.paramsEmpty());

    if(response != null){
      // await HiveService.removeData(int.parse(contact.id));
      // List<Contact> _contacts = await HiveService.loadData();
      // emit(ContactListLoaded(contacts: _contacts));
      fetchContacts();
    } else {
      emit(ContactListError(error: 'Something went wrong'));
    }
  }

  void openEditCreatePage(BuildContext context, Contact contact) async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditCreatePage(contact: contact)));
    if (result != null) {
      fetchContacts();
      // Add new post to hive
      // posts.add(result as Post);
    }
  }
}