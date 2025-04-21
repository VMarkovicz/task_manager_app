import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'task_model.dart';

class TaskController extends ChangeNotifier {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final List<TaskModel> _tasks = [];

    List<TaskModel> get tasks => _tasks;

    Future<void> fetchTasks() async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) return;

        final snapshot = await _firestore
            .collection('tasks')
            .where('userId', isEqualTo: user.uid)
            .orderBy('creationDate', descending: true)
            .get();

        _tasks.clear();
        _tasks.addAll(snapshot.docs.map((doc) {
            return TaskModel.fromMap(doc.data(), doc.id);
        }));
        notifyListeners();
    }

    Future<void> addTask(String title, String? description) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) return;

        final task = TaskModel(
            title: title,
            description: description,
            userId: user.uid,
        );

        final doc = await _firestore.collection('tasks').add(task.toMap());
        task.id = doc.id;
        _tasks.add(task);
        notifyListeners();
    }

    Future<void> updateTaskById(String taskId, String newTitle, String? newDescription) async {
        final index = _tasks.indexWhere((task) => task.id == taskId);
        if (index == -1) return;

        final task = _tasks[index];
        task.title = newTitle;
        task.description = newDescription;

        await _firestore.collection('tasks').doc(task.id).update({
            'title': newTitle,
            'description': newDescription,
        });

        notifyListeners();
    }

    Future<void> toggleDone(String id) async {
        final task = _tasks.firstWhere((t) => t.id == id);
        task.isDone = !task.isDone;
        await _firestore.collection('tasks').doc(id).update({'isDone': task.isDone});
        notifyListeners();
    }

    Future<void> toggleFavorite(String id) async {
        final task = _tasks.firstWhere((t) => t.id == id);
        task.isFavorite = !task.isFavorite;
        await _firestore.collection('tasks').doc(id).update({'isFavorite': task.isFavorite});
        notifyListeners();
    }

    Future<void> deleteTask(String id) async {
        _tasks.removeWhere((t) => t.id == id);
        await _firestore.collection('tasks').doc(id).delete();
        notifyListeners();
    }
}
