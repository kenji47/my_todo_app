import 'dart:async';

import 'package:my_todo_app/data/repository/todos_repository.dart';
import 'package:my_todo_app/logic/models/todo.dart';

class DummyTodosRepository implements TodosRepository{
  List<Todo> todos = [
    Todo('task1', note: 'note1'),
    Todo('task2', note: 'note2'),
    Todo('task3', note: 'note3'),
  ];

  @override
  Future<List<Todo>> loadTodos() async{
    return Future.delayed(Duration(seconds: 3)).then((value) => todos);
  }

  @override
  Future saveTodos(List<Todo> todos) async{
    this.todos = todos;
  }

}