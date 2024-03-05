// Model
class TodoItem {
  String title;
  String description;
  bool isDone;

  TodoItem({required this.title, required this.description, this.isDone = false});
}
