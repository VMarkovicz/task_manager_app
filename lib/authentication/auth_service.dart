import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    // Cadastro
    Future<User?> registerWithEmailAndPassword(String email, String password) async {
        try {
            UserCredential result = await _auth.createUserWithEmailAndPassword(
                email: email,
                password: password,
            );
            return result.user;
        } catch (e) {
            print("Erro no cadastro: $e");
            return null;
        }
    }

    // Login
    Future<User?> signInWithEmailAndPassword(String email, String password) async {
        try {
            UserCredential result = await _auth.signInWithEmailAndPassword(
                email: email,
                password: password,
            );
            return result.user;
        } catch (e) {
            print("Erro no login: $e");
            return null;
        }
    }

    // Logout
    Future<void> signOut() async {
        await _auth.signOut();
    }

    // Verificar usuário logado
    Stream<User?> get userChanges => _auth.authStateChanges();
}
