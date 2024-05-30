
import 'package:flutter/material.dart';

import '../../models/todo_model.dart';

class ManageTodoDialog extends StatefulWidget {
  final Todo? todo;
  final bool isEdit;

  const ManageTodoDialog({super.key, this.todo, required this.isEdit});

  @override
  State<ManageTodoDialog> createState() => _ManageTodoDialogState();
}

class _ManageTodoDialogState extends State<ManageTodoDialog> {
  String todoTitle = '';
  String todoDescription = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      todoTitle = widget.todo!.todoTitle;
      todoDescription = widget.todo!.todoDescription;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEdit ? 'Edit todo' : 'Add todo'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: todoTitle,
              decoration: const InputDecoration(labelText: 'title'),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter title!';
                }
                return null;
              },
              onSaved: (String? newValue) {
                if (newValue != null) {
                  todoTitle = newValue;
                }
              },
            ),
            TextFormField(
              initialValue: todoDescription,
              decoration: const InputDecoration(labelText: 'description'),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter description!';
                }
                return null;
              },
              onSaved: (String? newValue) {
                if (newValue != null) {
                  todoDescription = newValue;
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              Navigator.pop(context, {
                'todoTitle': todoTitle,
                'todoDescription': todoDescription,
              });
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
