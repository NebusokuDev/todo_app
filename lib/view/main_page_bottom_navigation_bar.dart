import 'package:flutter/material.dart';

class TodoInputField extends StatefulWidget {
  const TodoInputField({super.key, required this.onSubmitted});

  final void Function(String value) onSubmitted;

  @override
  State<TodoInputField> createState() => _TodoInputFieldState();
}

class _TodoInputFieldState extends State<TodoInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        onSubmitted: (String value) {
          widget.onSubmitted(_controller.text);
          _controller.clear();
        },
        decoration: InputDecoration(
          hintText: "create todo!",
          border: InputBorder.none,
          filled: true,
          prefixIcon: Icon(Icons.add),
          suffix: IconButton(
            onPressed: () {
              widget.onSubmitted(_controller.text);
              _controller.clear();
            },
            icon: Icon(Icons.send),
          ),
        ),
      ),
    );
  }
}
