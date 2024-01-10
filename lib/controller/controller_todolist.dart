// Controller
import 'package:flutter/material.dart';
import 'package:mvc_todo_list/model/models_todolist.dart';

class TodoController extends ValueNotifier<List<TodoItem>> {
  TodoController() : super([]);

  void addTodoItem(String title, String description) {
    value.add(TodoItem(title: title, description: description));
    notifyListeners();
  }

  void toggleTodoItem(int index) {
    value[index].isDone = !value[index].isDone;
    notifyListeners();
  }

  void editTodoItem(int index, String title, String description) {
    value[index].title = title;
    value[index].description = description;
    notifyListeners();
  }

  void removeTodoItem(int index) {
    value.removeAt(index);
    notifyListeners();
  }
}
