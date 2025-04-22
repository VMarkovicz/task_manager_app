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

    Future<void> register(String email, String password, String username) async {
        try {
            UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
            );

            await FirebaseFirestore.instance
                .collection('users')
                .doc(userCredential.user!.uid)
                .set({
            'username': username,
            'email': email,
            });
            firebaseUser.value = FirebaseAuth.instance.currentUser;

            Get.snackbar(   
                'Success', 
                'You have been registered!',
                snackPosition: SnackPosition.BOTTOM,
                duration: Duration(seconds: 2),
            );

            Get.off(() => HomePage()); 
        } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
        Get.snackbar(
                'Error', 
                'This email already has an account.',
                snackPosition: SnackPosition.BOTTOM,
                duration: Duration(seconds: 2),
            );
        } else {
        Get.snackbar(
                'Error', 
                'Register failed: ${e.message}',
                snackPosition: SnackPosition.BOTTOM,
                duration: Duration(seconds: 2),
            );
        }
        } catch (e) {
            Get.snackbar(
                    'Error', 
                    'Error: $e',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(seconds: 2),
                );
        }
    }

    Future<void> login(String email, String password) async {
        try {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        Get.snackbar(
                'Success', 
                'You have logged in!',
                snackPosition: SnackPosition.BOTTOM,
                duration: Duration(seconds: 2),
            );

        Get.off(() => HomePage()); 
        } catch (e) {
        Get.snackbar(
                'Login error', 
                e.toString(),
                snackPosition: SnackPosition.BOTTOM,
                duration: Duration(seconds: 2),
            );
        }
    }

    Future<void> logout() async {
        await _auth.signOut();
        Get.offAll(LoginPage()); 
    }
}
