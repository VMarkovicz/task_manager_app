import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/authentication/auth_service.dart';
import 'package:task_manager_app/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
    const RegisterPage({super.key});

    @override
    State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();

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
                        Text("Create an account"),
                        SizedBox(height: 20),
                        TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(labelText: 'Username'),
                        ),
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
                                await AuthController.to.register(
                                    _emailController.text.toString().trim(),
                                    _passwordController.text.toString().trim(),
                                    _usernameController.text.toString().trim(),
                                );
                            },
                            child: Text('Register'),
                        ),
                        TextButton(
                            onPressed: () {
                                Get.off(() => LoginPage());
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center, 
                                children: <Widget>[
                                Text(
                                    "Already have an account?",
                                    textAlign: TextAlign.center, 
                                ),
                                Text(
                                    "Login",
                                    textAlign: TextAlign.center,
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