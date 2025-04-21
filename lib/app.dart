import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/pages/login_page.dart';

class App extends StatelessWidget {
    const App({super.key});

    @override
    Widget build(BuildContext context) {
        return GetMaterialApp(
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: LoginPage(),
            debugShowCheckedModeBanner: false,
        );
    }
}