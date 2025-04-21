import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_manager_app/app.dart';
import 'package:task_manager_app/authentication/auth_service.dart';
import 'package:task_manager_app/task_management/task_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );
    Get.put(AuthController());

    runApp(
        ChangeNotifierProvider(
            create: (context) => TaskController()..fetchTasks(),
            child: const App(),
        ),
    );
}
