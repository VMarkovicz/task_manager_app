import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/pages/register_page.dart';
import '../authentication/auth_service.dart';

class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

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
                                await AuthController.to.login(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                );
                            },
                            child: Text('Login'),
                        ),
                        TextButton(
                            onPressed: () {
                                Get.off(() => RegisterPage());
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center, 
                                children: <Widget>[
                                Text(
                                    "Don't have an account?",
                                    textAlign: TextAlign.center,
                                ),
                                Text(
                                    "Register",
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