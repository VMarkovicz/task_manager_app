import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/authentication/register_page.dart';
import 'package:task_manager_app/home_page.dart';
import 'auth_service.dart';

class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                        Text("Login to your account"), 
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
                                User? user = await _auth.signInWithEmailAndPassword(
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
                            child: Text('Login'),
                        ),
                        TextButton(
                            onPressed: () {
                                Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => RegisterPage()),
                                );
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center, // Opcional: alinha os textos verticalmente ao centro
                                children: <Widget>[
                                Text(
                                    "Don't have an account?",
                                    textAlign: TextAlign.center, // Opcional: alinha o texto ao centro
                                ),
                                Text(
                                    "Registe",
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