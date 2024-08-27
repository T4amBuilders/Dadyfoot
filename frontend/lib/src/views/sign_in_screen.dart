import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _emailOrUsernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? errorMessage;

  Future<String?> _getEmailFromUsername(String username) async {
    try {
      final lowerCaseUsername =
          username.trim().toLowerCase(); // Convertir le pseudo en minuscules
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: lowerCaseUsername)
          .get();

      if (result.docs.isNotEmpty) {
        return result.docs.first['email'];
      } else {
        setState(() {
          errorMessage = "L'email ou le pseudo est incorrect.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
    return null;
  }

  Future<void> signIn() async {
    try {
      String emailOrUsername = _emailOrUsernameController.text.trim();
      String password = _passwordController.text.trim();
      String? email;

      if (emailOrUsername.contains('@')) {
        // C'est un email
        email = emailOrUsername;
      } else {
        // C'est un pseudo, chercher l'email correspondant
        email = await _getEmailFromUsername(emailOrUsername);
        if (email == null) return; // Arrêter si le pseudo est incorrect
      }

      // Connexion avec email et mot de passe
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Gérer les erreurs spécifiques
      String errorText;
      switch (e.code) {
        case 'user-not-found':
          errorText = 'Aucun utilisateur trouvé pour cet email.';
          break;
        case 'wrong-password':
          errorText = 'Le mot de passe est incorrect.';
          break;
        case 'invalid-email':
          errorText = 'L\'adresse email est invalide.';
          break;
        case 'too-many-requests':
          errorText =
              'Trop de tentatives de connexion. Veuillez réessayer plus tard.';
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
        title: const Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailOrUsernameController,
              decoration: const InputDecoration(
                labelText: 'Email ou Pseudo',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signIn,
              child: const Text('Se connecter'),
            ),
            const SizedBox(height: 20),
            errorMessage != null
                ? Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  )
                : Container(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: const Text('Vous n\'avez pas de compte ? S\'enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
