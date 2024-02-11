import 'package:flutter/material.dart';

extension ThemeExt on Brightness {
  ThemeData get theme => ThemeData(
        brightness: this,
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      );
}
