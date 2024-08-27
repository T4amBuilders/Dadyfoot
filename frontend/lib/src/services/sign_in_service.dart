// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code, e.message);
    }
  }
}

class AuthException implements Exception {
  final String code;
  final String? message;

  AuthException(this.code, this.message);

  @override
  String toString() {
    switch (code) {
      case 'user-not-found':
        return 'Aucun utilisateur trouvé pour cet email.';
      case 'wrong-password':
        return 'Le mot de passe est incorrect.';
      case 'invalid-email':
        return 'L\'adresse email est invalide.';
      case 'too-many-requests':
        return 'Trop de tentatives de connexion. Veuillez réessayer plus tard.';
      default:
        return 'Une erreur est survenue : $message';
    }
  }
}
