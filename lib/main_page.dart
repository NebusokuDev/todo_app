import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/edit_page.dart';
import 'package:todo_app/todo_list_notifier.dart';

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_box),
            Text("TODO APP"),
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: todoList
              .map(
                (todo) => Card(
                  child: ListTile(
                    leading: Checkbox(
                      value: todo.isComplete,
                      onChanged: (bool? value) {
                        ref
                            .read(todoListNotifierProvider.notifier)
                            .save(todo.copyWith(isComplete: value));
                      },
                    ),
                    title: Text(todo.title),
                    subtitle: todo.detail.isEmpty ? Text(todo.detail) : null,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref
                            .read(todoListNotifierProvider.notifier)
                            .delete(todo);
                      },
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditPage(
                            editData: todo,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(todoListNotifierProvider.notifier).add(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
