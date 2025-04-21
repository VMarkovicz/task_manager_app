import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
    String? id;
    String title;
    String? description;
    bool isDone;
    bool isFavorite;
    DateTime creationDate;
    String userId;

    TaskModel({
        this.id,
        required this.title,
        this.description,
        this.isDone = false,
        this.isFavorite = false,
        required this.userId,
    }) : creationDate = DateTime.now();

    Map<String, dynamic> toMap() {
        return {
            'title': title,
            'description': description,
            'isDone': isDone,
            'isFavorite': isFavorite,
            'creationDate': Timestamp.fromDate(creationDate),
            'userId': userId,
        };
    }

    factory TaskModel.fromMap(Map<String, dynamic> map, String id) {
        return TaskModel(
            id: id,
            title: map['title'],
            description: map['description'],
            isDone: map['isDone'],
            isFavorite: map['isFavorite'],
            userId: map['userId'],
            )..creationDate = (map['creationDate'] as Timestamp).toDate();
        }
}
