import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/authentication/auth_service.dart';
import 'package:task_manager_app/pages/add_task_page.dart';
import 'package:task_manager_app/pages/edit_task_page.dart';
import 'package:task_manager_app/task_management/task_controller.dart';

class HomePage extends StatefulWidget {
    const HomePage({super.key});

    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    bool toggleFavorite = false;

    @override
    void initState() {
        super.initState();
        Get.find<TaskController>().fetchTasks();

    }

    @override
    Widget build(BuildContext context) {
        final taskController = Get.find<TaskController>();
        final tasks = taskController.tasks.obs;
        final favouriteTasks = taskController.favouriteTasks.obs;

        tasks.refresh();

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
            body: ListView.builder(
                itemCount: toggleFavorite ? favouriteTasks.length : tasks.length,
                itemBuilder: (_, index) {
                final task = toggleFavorite ? favouriteTasks[index] : tasks[index];
                return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                        onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                title: Center(
                                    child: Text(task.title)
                                ),
                                content: Center(
                                    child: Text(task.description ?? "No description")
                                ),
                                actions: [
                                    TextButton(
                                        child: Text('Close'),
                                        onPressed: () => Navigator.of(context).pop(),
                                    ),
                                ],
                                ),
                            );
                        },
                        leading: Checkbox(
                            value: task.isDone,
                            onChanged: (_) => taskController.toggleDone(task.id!),
                        ),
                        title: Text(
                            task.title,
                            style: TextStyle(
                                decoration: task.isDone ? TextDecoration.lineThrough : null,
                            ),
                        ),
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                IconButton(
                                    icon: Icon(
                                    task.isFavorite ? Icons.star : Icons.star_border,
                                    color: Colors.amber,
                                    ),
                                    onPressed: () => taskController.toggleFavorite(task.id!),
                                ),
                                IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                        Get.to(() => EditTaskPage(
                                            taskController: taskController,
                                            task: task,
                                        ));
                                    },
                                ),
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                            title: Text('Confirm delete'),
                                            content: Text('Are you sure you want to delete this task?'),
                                            actions: [
                                                    TextButton(
                                                    child: Text('Cancel'),
                                                    onPressed: () => Get.back(),
                                                    ),
                                                    TextButton(
                                                    child: Text('Confirm'),
                                                    onPressed: () {
                                                        Get.back(); 
                                                        taskController.deleteTask(task.id!);
                                                    },
                                                    ),
                                                ],
                                            ),
                                        );
                                    },
                                ),
                            ],
                        ),
                    ),
                );
                },
            ),
            bottomNavigationBar: BottomAppBar(
                child: SizedBox(
                    height: 50,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            IconButton(
                                icon: toggleFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
                                onPressed: () {
                                    setState(() {
                                        toggleFavorite = !toggleFavorite;
                                    });
                                },
                            ),
                            IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                    Get.to(() => AddTaskPage(taskController: taskController));
                                },
                            ),
                            IconButton(
                                icon: Icon(Icons.logout),
                                onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                        title: Text('Confirm logout'),
                                        content: Text('Are you sure you want to logout?'),
                                        actions: [
                                                TextButton(
                                                child: Text('Cancel'),
                                                onPressed: () => Get.back(),
                                                ),
                                                TextButton(
                                                child: Text('Logout'),
                                                onPressed: () {
                                                    Get.back(); 
                                                    AuthController.to.logout();
                                                },
                                                ),
                                            ],
                                        ),
                                    );
                                },
                            ),
                        ],
                    ),
                ),
                
            ),
        );
    }
}