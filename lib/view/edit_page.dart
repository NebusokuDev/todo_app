import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todo_list_notifier.dart';

class EditPage extends ConsumerWidget {
  const EditPage({super.key, required this.editData});

  final Todo editData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: IntrinsicWidth(
          child: TextFormField(
            initialValue: editData.title,
            onChanged: (value) {
              ref
                  .read(todoListNotifierProvider.notifier)
                  .save(editData.copyWith(title: value));
            },
            maxLines: 1,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.edit),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: TextFormField(
                  initialValue: editData.detail,
                  onChanged: (value) => ref
                      .read(todoListNotifierProvider.notifier)
                      .save(editData.copyWith(detail: value)),
                  minLines: 50,
                  maxLines: 50,
                  decoration: const InputDecoration(
                    hintText: "detail input here!",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
