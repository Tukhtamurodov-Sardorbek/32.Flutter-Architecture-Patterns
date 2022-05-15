import 'package:contacts_mock_api_bloc/bloc/home_bloc/home_cubit.dart';
import 'package:contacts_mock_api_bloc/bloc/home_bloc/home_state.dart';
import 'package:contacts_mock_api_bloc/models/contact_model.dart';
import 'package:contacts_mock_api_bloc/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    BlocProvider.of<ContactListCubit>(context).fetchContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 4.0,
        title: const Text('BLoC'),
        centerTitle: true,
      ),
      body: BlocBuilder<ContactListCubit, ContactListState>(
        builder: (BuildContext context, ContactListState state){
          if(state is ContactListError){
            return HomeView([], true);
          } else if(state is ContactListLoaded){
            return HomeView(state.contacts, false);
          }

          return HomeView([], true);
          // return const Center(
          //   child: CircularProgressIndicator(),
          // );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 10.0,
        onPressed: (){
          BlocProvider.of<ContactListCubit>(context).openEditCreatePage(context, Contact());
        }, // openCreatePage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
