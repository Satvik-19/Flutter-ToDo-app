import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/models/task.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final void Function() onDelete;
  final void Function() onEdit;

  TaskWidget({
    required this.task,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(task.title),
        subtitle: task.dueDate != null
            ? Text('Due Date: ${DateFormat.yMd().add_jm().format(task.dueDate!)}')
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                onEdit();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                onDelete();
              },
            ),
          ],
        ),
        onTap: () {
          // Handle tap action (optional)
        },
      ),
    );
  }
}
