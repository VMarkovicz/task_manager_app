import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/controller/task_controller.dart';

class HomePage extends StatefulWidget {
    const HomePage({super.key});

    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    @override
    void initState() {
        super.initState();
        Provider.of<TaskController>(context, listen: false).fetchTasks();
    }

    @override
    Widget build(BuildContext context) {
        final taskController = Provider.of<TaskController>(context);
        final tasks = taskController.tasks;

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
            itemCount: tasks.length,
            itemBuilder: (_, index) {
            final task = tasks[index];
            return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
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
                                // abrir tela de edição
                                },
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => taskController.deleteTask(task.id!),
                            ),
                        ],
                    ),
                ),
            );
            },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
                taskController.addTask(
                    'Tarefa de Teste',
                    'Criada automaticamente para testar o botão.',
                );
            },
            child: const Icon(Icons.add),
        ),
        );
    }
}