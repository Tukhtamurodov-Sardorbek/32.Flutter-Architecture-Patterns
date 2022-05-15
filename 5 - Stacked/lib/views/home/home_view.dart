import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_pattern/views/home/home_view_model.dart';
import 'package:stacked_pattern/views/home/post_widget.dart';

class HomeView extends StatefulWidget {
  static const String id = '/home_page';

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel viewModel = HomeViewModel();
  @override
  void initState() {
    viewModel.fetchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 4.0,
        title: const Text('Stacked'),
        centerTitle: true,
      ),
      body: ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        builder: (BuildContext context, HomeViewModel model, Widget? child) {
          return Stack(
            children: [
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: viewModel.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return postWidget(context, viewModel, viewModel.posts[index]);
                },
              ),
              viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Container(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 10.0,
        onPressed: (){
          viewModel.openCreatePage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
