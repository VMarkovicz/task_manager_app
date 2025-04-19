import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/authentication/auth_service.dart';
import 'package:task_manager_app/authentication/login_page.dart';
import 'package:task_manager_app/home_page.dart';

class RegisterPage extends StatefulWidget {
    const RegisterPage({super.key});

    @override
    State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final AuthService _auth = AuthService();

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
                        Text("Create an account"),
                        SizedBox(height: 20),
                        TextField(
                            controller: _emailController,
                            decoration: InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () async {
                                User? user = await _auth.registerWithEmailAndPassword(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                );

                                if (!mounted) return;

                                if (user != null) {
                                    Navigator.push(
                                        context, 
                                        MaterialPageRoute(builder: (context) => HomePage()),
                                    );
                                }
                            },
                            child: Text('Register'),
                        ),
                        TextButton(
                            onPressed: () {
                                Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => LoginPage()),
                                );
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center, // Opcional: alinha os textos verticalmente ao centro
                                children: <Widget>[
                                Text(
                                    "Already have an account?",
                                    textAlign: TextAlign.center, // Opcional: alinha o texto ao centro
                                ),
                                Text(
                                    "Login",
                                    textAlign: TextAlign.center, // Opcional: alinha o texto ao centro
                                ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}