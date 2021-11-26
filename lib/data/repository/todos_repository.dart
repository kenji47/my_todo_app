import 'package:my_todo_app/logic/models/todo.dart';

abstract class TodosRepository {
  Future<List<Todo>> loadTodos();
  Future saveTodos(List<Todo> todos);
}