import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/task_management/task_controller.dart';

class AddTaskPage extends StatefulWidget {
    final TaskController taskController;
    const AddTaskPage({super.key, required this.taskController});

    @override
    State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    Icon(Icons.assignment),
                    SizedBox(width: 8),
                    Text('To Do App'),
                    ],
                ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text("Create your task"), 
                        SizedBox(height: 20),
                        TextField(
                            controller: _titleController,
                            decoration: InputDecoration(labelText: 'Title'),
                        ),
                        TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(labelText: 'Description (optional)'),
                            obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () async {
                                widget.taskController.addTask(
                                    _titleController.text.trim(), 
                                    _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim()
                                );
                                Get.back();
                                Get.snackbar(
                                    "Task Created",
                                    "Your task has been created successfully.",
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: Duration(seconds: 2),
                                );
                            },
                            child: Text('Save Task'),
                        ),
                    ],
                ),
            ),
        );
    }
}