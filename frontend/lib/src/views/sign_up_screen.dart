import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  String? errorMessage;

  // Fonction de validation pour vérifier si le pseudo est alphanumérique
  bool _isValidUsername(String username) {
    final RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9]+$');
    return usernameRegExp.hasMatch(username);
  }

  Future<void> createUserWithEmailAndPassword() async {
    String username = _usernameController.text
        .trim()
        .toLowerCase(); // Convertir le pseudo en minuscules

    // Vérification que le pseudo est alphanumérique
    if (!_isValidUsername(username)) {
      setState(() {
        errorMessage =
            "Le pseudo ne peut contenir que des lettres et des chiffres.";
      });
      return;
    }

    // Vérifier si le pseudo est déjà utilisé
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (result.docs.isNotEmpty) {
      setState(() {
        errorMessage = "Le pseudo est déjà pris. Veuillez en choisir un autre.";
      });
      return;
    }

    try {
      // Créer l'utilisateur avec e-mail et mot de passe
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Ajouter les informations utilisateur dans Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'username': username, // Stocker le pseudo en minuscules
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
      });
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
      setState(() {
        errorMessage = errorText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enregistrement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Pseudo'),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: createUserWithEmailAndPassword,
              child: const Text('S\'enregistrer'),
            ),
            const SizedBox(height: 20),
            errorMessage != null
                ? Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
