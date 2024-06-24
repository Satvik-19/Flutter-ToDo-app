import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/pages/task_edit_page.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final Function(Task, String) onEdit;
  final Function(Task) onToggleComplete;
  final Function(Task) onDelete;

  TaskWidget({
    required this.task,
    required this.onEdit,
    required this.onToggleComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
          ),
          onPressed: () => onToggleComplete(task),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                final result = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskEditPage(initialTitle: task.title),
                  ),
                );
                if (result != null && result.isNotEmpty) {
                  onEdit(task, result);
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => onDelete(task),
            ),
          ],
        ),
      ),
    );
  }
}
