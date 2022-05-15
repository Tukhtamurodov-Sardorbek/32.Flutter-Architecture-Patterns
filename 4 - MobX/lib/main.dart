import 'package:flutter/material.dart';
import 'package:mobx_pattern/pages/edit_create_page.dart';
import 'package:mobx_pattern/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        EditCreatePage.id: (context) => EditCreatePage()
      },
    );
  }
}