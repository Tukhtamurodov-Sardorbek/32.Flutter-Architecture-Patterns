import 'package:bloc_pattern/bloc/home_bloc/home_cubit.dart';
import 'package:bloc_pattern/bloc/home_bloc/home_state.dart';
import 'package:bloc_pattern/models/post_model.dart';
import 'package:bloc_pattern/pages/edit_create_page.dart';
import 'package:bloc_pattern/views/home/home_view.dart';
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
    BlocProvider.of<PostListCubit>(context).fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 4.0,
        title: const Text('BLOC'),
        centerTitle: true,
      ),
      body: BlocBuilder<PostListCubit, PostListState>(
        builder: (BuildContext context, PostListState state){
          if(state is PostListError){
            return HomeView([], true);
          } else if(state is PostListLoaded){
            return HomeView(state.posts, false);
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
          BlocProvider.of<PostListCubit>(context).openEditCreatePage(context, Post());
        }, // openCreatePage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
