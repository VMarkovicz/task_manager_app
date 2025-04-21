import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/task_management/task_controller.dart';
import 'package:task_manager_app/task_management/task_model.dart';

class EditTaskPage extends StatefulWidget {
    final TaskController taskController;
    final TaskModel task;
    const EditTaskPage({super.key, required this.taskController, required this.task});

    @override
    State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
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
                        Text("Edit your task"), 
                        SizedBox(height: 20),
                        TextField(
                            controller: _titleController,
                            decoration: InputDecoration(labelText: widget.task.title),
                        ),
                        TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(labelText: widget.task.description ?? "Description (optional)"),
                            obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () async {
                                widget.taskController.updateTaskById(
                                    widget.task.id!,
                                    _titleController.text.trim().isEmpty ? widget.task.title : _titleController.text.trim(), 
                                    _descriptionController.text.trim().isEmpty ? widget.task.description : _descriptionController.text.trim()
                                );
                                Get.back();
                                Get.snackbar(
                                    "Task Updated",
                                    "Your task has been updated successfully.",
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