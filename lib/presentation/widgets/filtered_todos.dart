import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/logic/bloc/filtered-todos/filtered_todos_bloc.dart';
import 'package:my_todo_app/logic/bloc/todos/todos_bloc.dart';
import 'package:my_todo_app/presentation/screens/details_screen.dart';
import 'package:my_todo_app/presentation/widgets/delete_todo_snack_bar.dart';
import 'package:my_todo_app/presentation/widgets/todo_item.dart';
import 'package:my_todo_app/presentation/widgets/todo_item2.dart';

class FilteredTodos extends StatelessWidget {
  FilteredTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FilteredTodosLoadSuccess) {
          final todos = state.filteredTodos;

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];

              return TodoItem(
                todo: todo,
                onDismissed: (direction) {
                  BlocProvider.of<TodosBloc>(context).add(TodoDeleted(todo));
                  ScaffoldMessenger.of(context).showSnackBar(
                    DeleteTodoSnackBar(
                      todo: todo,
                      onUndo: () => BlocProvider.of<TodosBloc>(context)
                          .add(TodoAdded(todo)),
                    ),
                  );
                },
                onTap: () async {
                  //todo
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: todo.id);
                    }),
                  );
                  //todo was deleted
                  if (removedTodo != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      DeleteTodoSnackBar(
                        todo: todo,
                        onUndo: () => BlocProvider.of<TodosBloc>(context)
                            .add(TodoAdded(todo)),
                      ),
                    );
                  }
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<TodosBloc>(context).add(
                    TodoUpdated(todo.copyWith(complete: !todo.complete)),
                  );
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
