import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/pages/home_page.dart';
import 'package:task_manager_app/pages/login_page.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rxn<User?> firebaseUser = Rxn<User?>();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  // Register
  Future<void> register(String email, String password, String username) async {
    try {
        // Create user with email and password
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
        );

        // Save user data to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
        'username': username,
        'email': email,
        });
        firebaseUser.value = FirebaseAuth.instance.currentUser;

        Get.snackbar(   
            'Sucesso', 
            'Cadastro realizado com sucesso!',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
        );

        Get.off(() => HomePage()); 
    } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      Get.snackbar(
            'Erro', 
            'Este email já está em uso por outro usuário.',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
        );
    } else {
      Get.snackbar(
            'Erro', 
            'Falha no cadastro: ${e.message}',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
        );
    }
  } catch (e) {
    Get.snackbar(
            'Erro', 
            'Erro inesperado: $e',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
        );
  }
  }

  // Login
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
            'Sucesso', 
            'Login realizado!',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
        );

      Get.off(() => HomePage()); 
    } catch (e) {
      Get.snackbar(
            'Erro no login', 
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
        );
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(LoginPage()); 
  }
}
