import 'package:todo_app/model/todo.dart';

abstract class TodoRepository {
  Future<Todo> findBy(int id);

  Future<List<Todo>> findAll();

  Future save(Todo todo);

  Future create(Todo todo);

  Future delete(Todo todo) async {}
}
