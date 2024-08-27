import 'package:flutter/material.dart';
import '../services/sign_up_service.dart';
import '../utils/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  String? errorMessage;

  Future<void> createUserWithEmailAndPassword() async {
    String username = _usernameController.text.trim().toLowerCase();

    if (!Validators.isValidUsername(username)) {
      setState(() {
        errorMessage =
            "Le pseudo ne peut contenir que des lettres et des chiffres.";
      });
      return;
    }

    final authService = AuthService();
    final result = await authService.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      username: username,
      name: _nameController.text.trim(),
    );

    if (result != null) {
      setState(() {
        errorMessage = result;
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
