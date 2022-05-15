import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_getx/controllers/home_controller.dart';
import 'package:pattern_getx/widgets/slidable_widget.dart';

class HomePage extends StatelessWidget {
  static const String id = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      init: HomeController(),
      builder: (_controller){
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 4.0,
            title: const Text('GetX'),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _controller.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return postWidget(_controller, _controller.posts[index]);
                },
              ),
              _controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Container(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 10.0,
            onPressed: _controller.openCreatePage,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
