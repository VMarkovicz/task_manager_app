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
            darkTheme: ThemeData.dark().copyWith(
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.black,  // cor de fundo
                    foregroundColor: Colors.white,  // cor dos ícones e título
                    elevation: 0,
                ),
                scaffoldBackgroundColor: Colors.black, // fundo da tela
                cardColor: Colors.grey[900],           // cards escuros
                textTheme: TextTheme(
                    bodyMedium: TextStyle(color: Colors.white), // texto padrão
                ),
            ),
            themeMode: ThemeMode.system,
            home: LoginPage(),
            debugShowCheckedModeBanner: false,
        );
    }
}