import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/todo.dart';

part 'todo_list_notifier.g.dart';

@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  
  @override
  List<Todo> build() {
    return [];
  }

  void add({String? title, String? detail, bool? isComplete}) {
    state = [
      ...state,
      Todo(
        id: "${state.length}",
        title: title ?? 'untitled',
        detail: detail ?? '',
        isComplete: isComplete ?? false,
      )
    ];
  }

  void save(Todo todo) {
    var newState = state;

    final index = state.indexWhere((item) => todo.id == item.id);

    if (index >= 0) {
      newState[index] = todo;
    } else {
      newState.add(todo);
    }

    state = [...newState];
  }

  void delete(Todo todo) {
    var newState = state;
    newState.removeWhere((item) => todo.id == item.id);
    state = [...newState];
  }
}
