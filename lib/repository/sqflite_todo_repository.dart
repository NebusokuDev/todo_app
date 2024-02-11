import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/repository/todo_repository.dart';

class SqliteTodoRepository implements TodoRepository {
  final SqfliteDatabaseProvider _provider;

  SqliteTodoRepository({required SqfliteDatabaseProvider provider})
      : _provider = provider;

  @override
  Future delete(Todo todo) async {
    final db = await _provider.database;
    await db.delete(
      "todo",
      where: "id = ?",
      whereArgs: [todo.id],
    );
  }

  @override
  Future save(Todo todo) async {
    final db = await _provider.database;
    final result = await db.query(
      "todo",
      where: "id = ?",
      whereArgs: [todo.id],
    );

    if (result.isEmpty) {
      await db.insert(
        "todo",
        todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );
      return;
    }

    await db
        .update("todo", todo.toMap(), where: "id = ?", whereArgs: [todo.id]);
  }

  @override
  Future create(Todo todo) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> findAll() async {
    final db = await _provider.database;
    final query = await db.query("todo", orderBy: "id DESC");

    return query.map((map) => Todo.fromMap(map)).toList();
  }

  @override
  Future<Todo> findBy(int id) async {
    final db = await _provider.database;
    final query = await db.query("todo", where: "id = ?", whereArgs: [id]);

    if (query.isEmpty) {
      return Todo(title: '', detail: '', isComplete: false);
    }

    return Todo.fromMap(query.first);
  }
}

class SqfliteDatabaseProvider {
  static Database? _database;

  Future<Database> initDb() {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
    return openDatabase(
      "database.db",
      onCreate: (db, version) {
        return db.execute("""
        CREATE TABLE todo(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          detail TEXT,
          isComplete INTEGER)""");
      },
      version: 1,
    );
  }

  Future<Database> get database async {
    _database ??= await initDb();
    return _database!;
  }
}
