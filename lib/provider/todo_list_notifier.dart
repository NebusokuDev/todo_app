import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/repository/sqflite_todo_repository.dart';
import 'package:todo_app/repository/todo_repository.dart';

part 'todo_list_notifier.g.dart';

@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  TodoRepository repository = SqliteTodoRepository(
    provider: SqfliteDatabaseProvider(),
  );

  @override
  Future<List<Todo>> build() async => (await repository.findAll()).toList();

  Future _refresh() async {
    state = AsyncValue.data(await repository.findAll());
  }

  Future add({String? title, String? detail, bool? isComplete}) async {
    final newData = Todo(
      id: 0,
      title: title ?? "untitled",
      detail: detail ?? "",
      isComplete: isComplete ?? false,
    );

    await repository.save(newData);

    await _refresh();
  }

  Future save(Todo todo) async {
    await repository.save(todo);
    await _refresh();
  }

  Future delete(Todo todo) async {
    await repository.delete(todo);
    await _refresh();
  }
}
