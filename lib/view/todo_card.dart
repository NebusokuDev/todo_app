import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todo_list_notifier.dart';
import 'package:todo_app/view/edit_page.dart';

class TodoCard extends ConsumerWidget {
  const TodoCard({super.key, required this.todo});

  final Todo todo;

  factory TodoCard.create(Todo todo) => TodoCard(todo: todo);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
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
        subtitle: todo.detail.isNotEmpty ? Text(todo.detail) : null,
        trailing: IconButton(
          hoverColor: Colors.redAccent,
          icon: const Icon(Icons.delete),
          onPressed: () {
            ref.read(todoListNotifierProvider.notifier).delete(todo);
          },
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditPage(editData: todo),
            ),
          );
        },
      ),
    );
  }
}
