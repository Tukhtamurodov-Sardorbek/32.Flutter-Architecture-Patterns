import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_pattern/stores/home_store.dart';
import 'package:mobx_pattern/widgets/post_widget.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore store = HomeStore();

  @override
  void initState() {
    store.fetchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 4.0,
        title: const Text('MobX'),
        centerTitle: true,
      ),
      body: Observer(
          builder: (context) {
            return Stack(
              children: [
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: store.posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return postWidget(store.posts[index], context, store);
                    },
                ),
                store.isLoading
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : Container(),
              ],
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 10.0,
        onPressed: () {
          store.openCreatePage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
