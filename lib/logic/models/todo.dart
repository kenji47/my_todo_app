import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../uuid.dart';

@immutable
class Todo extends Equatable {
  final String id;
  final String task;
  final String note;
  final bool complete;
  final DateTime? date;

  Todo(
    this.task, {
    this.complete = false,
    String note = '',
    String? id,
    DateTime? date,
  })  : this.note = note ?? '',
        this.id = id ?? Uuid().generateV4(),
        this.date = date ?? null;

  Todo copyWith(
      {String? id,
      String? task,
      String? note,
      bool? complete,
      DateTime? date}) {
    return Todo(
      task ?? this.task,
      id: id ?? this.id,
      complete: complete ?? this.complete,
      note: note ?? this.note,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [id, task, note, complete, date];

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $note, id: $id, date: $date }';
  }
}
