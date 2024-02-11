import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/provider/theme_mode_notifier.dart';
import 'package:todo_app/theme_data.dart';
import 'package:todo_app/view/main_page.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Brightness.light.theme,
      darkTheme: Brightness.dark.theme,
      themeMode: themeMode.value,
      home: const MainPage(),
    );
  }
}
