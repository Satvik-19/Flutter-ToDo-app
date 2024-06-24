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

  void _addTask(String title, DateTime? dueDate) {
    setState(() {
      tasks.add(Task(title: title, dueDate: dueDate));
    });
  }

  void _editTask(int index, String title, DateTime? dueDate) {
    setState(() {
      tasks[index].title = title;
      tasks[index].dueDate = dueDate;
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      body: Container(
        color: Colors.grey[200], // Light grey background
        child: AnimationLimiter(
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
                      onEdit: () => _navigateToEditTask(context, index),
                      onDelete: () => _deleteTask(index),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(
              builder: (context) => TaskEditPage(),
            ),
          );
          if (result != null && result['title'].isNotEmpty) {
            _addTask(result['title'], result['dueDate']);
          }
        },
        backgroundColor: Colors.amberAccent, // Amber FAB color
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToEditTask(BuildContext context, int index) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => TaskEditPage(
          initialTitle: tasks[index].title,
          initialDueDate: tasks[index].dueDate,
        ),
      ),
    );
    if (result != null && result['title'].isNotEmpty) {
      _editTask(index, result['title'], result['dueDate']);
    }
  }
}
