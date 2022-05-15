import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_pattern/scopes/home_scoped.dart';
import 'package:scoped_model_pattern/widgets/post_widget.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeScoped controller = HomeScoped();

  @override
  void initState() {
    controller.fetchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 4.0,
        title: const Text('Scoped Model'),
        centerTitle: true,
      ),
      body: ScopedModel<HomeScoped>(
        model: controller,
        child: ScopedModelDescendant<HomeScoped>(
          builder: (ctx, child, model){
            return Stack(
              children: [
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return postWidget(context, controller, controller.posts[index]);
                  },
                ),
                controller.isLoading
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : Container(),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 10.0,
        onPressed: (){
          controller.openCreatePage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}