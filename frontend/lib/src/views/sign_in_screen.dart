// lib/screens/sign_in_screen.dart
import 'package:flutter/material.dart';
import '../services/sign_in_service.dart';
import '../services/user_service.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _emailOrUsernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? errorMessage;

  Future<void> signIn() async {
    try {
      String emailOrUsername = _emailOrUsernameController.text.trim();
      String password = _passwordController.text.trim();
      String? email;

      if (emailOrUsername.contains('@')) {
        email = emailOrUsername;
      } else {
        email = await UserService().getEmailFromUsername(emailOrUsername);
        if (email == null) {
          setState(() {
            errorMessage = "L'email ou le pseudo est incorrect.";
          });
          return;
        }
      }

      await AuthService().signInWithEmailAndPassword(email, password);
    } on AuthException catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Une erreur inconnue est survenue : $e';
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
