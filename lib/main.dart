import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/data/repository/dummy_todos_repository.dart';
import 'package:my_todo_app/logic/bloc/app-tab/app_tab_bloc.dart';
import 'package:my_todo_app/logic/bloc/filtered-todos/filtered_todos_bloc.dart';
import 'package:my_todo_app/logic/bloc/stats/stats_bloc.dart';
import 'package:my_todo_app/logic/bloc/todos/todos_bloc.dart';
import 'package:my_todo_app/logic/models/todo.dart';
import 'package:my_todo_app/presentation/constants.dart';
import 'package:my_todo_app/presentation/screens/add_edit_screen.dart';
import 'package:my_todo_app/presentation/screens/home_screen.dart';
import 'package:my_todo_app/presentation/widgets/app_theme.dart';

void main() {
  runApp(BlocProvider(
    create: (context) {
      return TodosBloc(
        DummyTodosRepository(),
      )..add(TodosLoaded());
    },
    child: const TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My todo app',
      theme: AppTheme.themeDark,
      routes: {
        Constants.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AppTabBloc>(
                create: (context) => AppTabBloc(),
              ),
              BlocProvider<FilteredTodosBloc>(
                create: (context) => FilteredTodosBloc(
                  BlocProvider.of<TodosBloc>(context),
                ),
              ),
              BlocProvider<StatsBloc>(
                create: (context) => StatsBloc(
                  BlocProvider.of<TodosBloc>(context),
                ),
              ),
            ],
            child: HomeScreen(),
          );
        },
        Constants.addTodo: (context) {
          return AddEditScreen(
            todo: null,
            onSave: (task, note, date) {
              BlocProvider.of<TodosBloc>(context).add(
                TodoAdded(Todo(task, note: note, date: date)),
              );
            },
            isEditing: false,
          );
        },
      },
    );
  }
}
