import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  Future<String?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String name,
  }) async {
    try {
      // Vérifier si le pseudo est déjà utilisé
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (result.docs.isNotEmpty) {
        return "Le pseudo est déjà pris. Veuillez en choisir un autre.";
      }

      // Créer l'utilisateur avec e-mail et mot de passe
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Ajouter les informations utilisateur dans Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'username': username, // Stocker le pseudo en minuscules
        'name': name,
        'email': email,
      });

      return null; // Pas d'erreur
    } on FirebaseAuthException catch (e) {
      // Gérer les erreurs spécifiques
      String errorText;
      switch (e.code) {
        case 'email-already-in-use':
          errorText = 'Cet email est déjà utilisé.';
          break;
        case 'invalid-email':
          errorText = 'L\'adresse email est invalide.';
          break;
        case 'weak-password':
          errorText = 'Le mot de passe est trop faible.';
          break;
        case 'operation-not-allowed':
          errorText =
              'Les opérations d\'inscription sont actuellement désactivées.';
          break;
        default:
          errorText = 'Une erreur est survenue : ${e.message}';
      }
      return errorText;
    }
  }
}
