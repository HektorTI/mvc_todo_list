import 'package:mvc_todo_list/Login/controller/auth_controller.dart';
import 'package:mvc_todo_list/Login/view/auth_screen.dart';
import 'package:mvc_todo_list/home/view/home_page_todolist.dart';
import 'package:mvc_todo_list/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthController(),
      child: MaterialApp(
        home: const SplashScreen(),
        routes: {
          '/auth': (context) => const AuthScreen(),
          '/todo': (context) => const TodoListView(),
        },
      ),
    ),
  );
}
