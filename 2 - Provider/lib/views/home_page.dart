import 'package:flutter/material.dart';
import 'package:patternprovider/view_models/home_view_model.dart';
import 'package:patternprovider/widgets/post_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = HomeController();

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
        title: const Text('Provider'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => controller,
        child: Consumer<HomeController>(
          builder: (ctx, model, index){
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