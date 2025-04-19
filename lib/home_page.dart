import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
    const HomePage({super.key});

    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final FirebaseAuth auth = FirebaseAuth.instance;

    String getCurrentUserEmail() {
        User? user = auth.currentUser;
        return user != null ? user.email! : "No user logged in";
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Row(
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
                        Text("Home Page"), 
                        SizedBox(height: 20),
                        Text("Your email is: ${getCurrentUserEmail()}"),
                    ],
                ),
            ),
        );
    }
}