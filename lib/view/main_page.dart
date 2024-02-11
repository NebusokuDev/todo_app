import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/theme_mode_notifier.dart';
import 'package:todo_app/provider/todo_list_notifier.dart';
import 'package:todo_app/view/main_page_bottom_navigation_bar.dart';
import 'package:todo_app/view/todo_card.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  Icon getIcon(WidgetRef ref) {
    final iconData = ref.watch(themeModeNotifierProvider).when(
          loading: () {},
          data: (themeMode) => switch (themeMode) {
            ThemeMode.system => Icons.brightness_auto,
            ThemeMode.light => Icons.light_mode,
            ThemeMode.dark => Icons.dark_mode,
          },
          error: (err, trace) {},
        );

    return Icon(iconData ?? Icons.brightness_auto);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListNotifierProvider);
    final content = todoList.when(
      loading: () {},
      data: (List<Todo> todoList) {
        return ListView(children: todoList.map(TodoCard.create).toList());
      },
      error: (err, stack) {},
    );

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
            icon: getIcon(ref),
          ),
        ],
        centerTitle: true,
      ),
      body: Center(child: content),
      bottomNavigationBar: TodoInputField(
        onSubmitted: (value) {
          ref.read(todoListNotifierProvider.notifier).add(title: value);
        },
      ),
    );
  }
}
