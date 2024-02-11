import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_mode_notifier.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  late SharedPreferences prefs;
  static const String key = 'ThemeMode';

  @override
  Future<ThemeMode> build() async {
    prefs = await SharedPreferences.getInstance();

    final themeMode = await prefs.getString(key) ?? '';

    return switch (themeMode) {
      'ThemeMode.dark' => ThemeMode.dark,
      'ThemeMode.light' => ThemeMode.light,
      _ => ThemeMode.system
    };
  }

  Future toggle() async {
    var newState = switch (state.value ?? ThemeMode.system) {
      ThemeMode.system => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
      ThemeMode.light => ThemeMode.system,
    };

    await prefs.setString(key, newState.toString());

    state = AsyncValue.data(newState);
  }
}
