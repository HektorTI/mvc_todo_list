// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mvc_todo_list/controller/controller_todolist.dart';
import 'package:mvc_todo_list/model/models_todolist.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  _TodoListViewState createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  final TodoController _controller = TodoController();
  void _showAddTodoDialog() {
    String title = '';
    String description = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Todo Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (value) {
                  description = value;
                },
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (title.isNotEmpty && description.isNotEmpty) {
                  _controller.addTodoItem(title, description);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List MVC'),
        backgroundColor: const Color.fromARGB(255, 31, 153, 80),
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, List<TodoItem> todoList, child) {
          return ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              final item = todoList[index];
              return CheckboxListTile(
                title: Text(item.title,
                    style: TextStyle(
                      decoration: item.isDone ? TextDecoration.lineThrough : null,
                    )),
                subtitle: Text(item.description),
                value: item.isDone,
                onChanged: (bool? newValue) {
                  _controller.toggleTodoItem(index);
                },
                secondary: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        print('Edit icon tapped for index $index');
                        _showEditTodoDialog(index);
                      },
                      child: const Icon(Icons.edit),
                    ),
                    GestureDetector(
                      onTap: () {
                        _controller.removeTodoItem(index);
                      },
                      child: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditTodoDialog(int index) {
    // Cria os controladores para os campos de texto.
    TextEditingController titleController = TextEditingController(text: _controller.value[index].title);
    TextEditingController descriptionController = TextEditingController(text: _controller.value[index].description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Todo Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                final String title = titleController.text;
                final String description = descriptionController.text;
                if (title.isNotEmpty && description.isNotEmpty) {
                  _controller.editTodoItem(index, title, description);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    ).then((_) {
      // Descarta os controladores quando o diálogo é fechado.
      titleController.dispose();
      descriptionController.dispose();
    });
  }
}
