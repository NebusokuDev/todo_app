import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/pages/edit_page.dart';
import 'package:todo_app/theme_mode_notifier.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_list_notifier.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  Widget buildCard(Todo todo, BuildContext context, WidgetRef ref) {
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

  Icon getIcon(ThemeMode themeMode) => switch (themeMode) {
        ThemeMode.system => const Icon(Icons.brightness_auto),
        ThemeMode.light => const Icon(Icons.light_mode),
        ThemeMode.dark => const Icon(Icons.dark_mode),
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListNotifierProvider);
    final themeMode = ref.watch(themeModeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_box),
            Text("TODO APP"),
          ],
        ),
        actions: [
          IconButton(
            onPressed: ref.read(themeModeNotifierProvider.notifier).toggle,
            icon: getIcon(themeMode),
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children:
              todoList.map((todo) => buildCard(todo, context, ref)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ref.read(todoListNotifierProvider.notifier).add,
        child: const Icon(Icons.add),
      ),
    );
  }
}
