import 'package:flutter/material.dart';

class ProfileForm extends StatelessWidget {
  final String? username;
  final String? email;
  final TextEditingController nameController;
  final VoidCallback onUpdateName;
  final String? errorMessage;
  final Key? formKey;

  const ProfileForm({
    required this.username,
    required this.email,
    required this.nameController,
    required this.onUpdateName,
    required this.errorMessage,
    this.formKey,
  }) : super(key: formKey);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Pseudo: $username'),
        Text('Email: $email'),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Nom'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onUpdateName,
          child: const Text('Mettre à jour le nom'),
        ),
        const SizedBox(height: 20),
        errorMessage != null
            ? Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              )
            : Container(),
      ],
    );
  }
}
