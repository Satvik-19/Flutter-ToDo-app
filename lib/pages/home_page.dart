import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/pages/task_edit_page.dart';
import 'package:todolist/widgets/task_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  void _addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
    });
  }

  void _editTask(Task task, String title) {
    setState(() {
      task.title = title;
    });
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: TaskWidget(
                    task: tasks[index],
                    onEdit: _editTask,
                    onToggleComplete: _toggleTaskCompletion,
                    onDelete: _deleteTask,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<String>(
            context,
            MaterialPageRoute(
              builder: (context) => TaskEditPage(),
            ),
          );
          if (result != null && result.isNotEmpty) {
            _addTask(result);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
