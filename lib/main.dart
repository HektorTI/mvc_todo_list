import 'package:flutter/material.dart';
import 'view/home_page_todolist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List MVC',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const TodoListView(),
    );
  }
}
