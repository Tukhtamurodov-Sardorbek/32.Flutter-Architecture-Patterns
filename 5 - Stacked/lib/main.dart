import 'package:flutter/material.dart';
import 'package:stacked_pattern/views/edit_create/edit_create_view.dart';
import 'package:stacked_pattern/views/home/home_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stacked',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
      routes: {
        HomeView.id: (context) => const HomeView(),
        EditCreateView.id: (context) => EditCreateView()
      },
    );
  }
}