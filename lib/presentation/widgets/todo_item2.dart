

import 'package:flutter/material.dart';
import 'package:my_todo_app/logic/models/todo.dart';

class TodoItem2 extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool?>? onCheckboxChanged;
  final Todo todo;

  TodoItem2({
    Key? key,
    required this.onDismissed,
    required this.onTap,
    required this.onCheckboxChanged,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: onDismissed,
      key: ValueKey(todo.id), //todo
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          child: Card(
            color: Theme.of(context).cardColor,
            child: InkWell(
              onTap: onTap,
              child: Column(
                children: [
                  Checkbox(
                    value: todo.complete,
                    onChanged: onCheckboxChanged,
                  ),
                  Hero(
                    tag: '${todo.id}__heroTag',
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        todo.task,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  todo.note.isNotEmpty
                      ? Text(
                    todo.note,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}