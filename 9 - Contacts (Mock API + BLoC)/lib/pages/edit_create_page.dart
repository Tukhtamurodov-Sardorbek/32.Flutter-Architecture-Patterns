import 'package:contacts_mock_api_bloc/bloc/edit_creat_bloc/edit_create_cubit.dart';
import 'package:contacts_mock_api_bloc/bloc/edit_creat_bloc/edit_create_state.dart';
import 'package:contacts_mock_api_bloc/models/contact_model.dart';
import 'package:contacts_mock_api_bloc/views/edit_create_view/edit_create_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCreatePage extends StatefulWidget {
  static const String id = "edit_create_page";
  final Contact contact;

  const EditCreatePage({Key? key, required this.contact}) : super(key: key);

  @override
  _EditCreatePageState createState() => _EditCreatePageState();
}

class _EditCreatePageState extends State<EditCreatePage> {

  void finish(BuildContext context){
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.pop(context, 'result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCreateContactCubit(),
      child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 4.0,
            title: Text(widget.contact.name != null && widget.contact.number != null ? 'Edit contact' : 'Create contact'),
            centerTitle: true,
          ),
          body: BlocBuilder<EditCreateContactCubit, EditCreateContactState>(
            builder: (BuildContext context, EditCreateContactState state){
              if(state is EditCreateContactLoading){
                return EditCreateView(widget.contact, true, context);
              } else if(state is EditCreateContactLoaded){
                finish(context);
              } else if(state is EditCreateContactError){}
              return EditCreateView(widget.contact, false, context);
            },
          )
      ),
    );
  }
}